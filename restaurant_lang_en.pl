% This file is responsible for taking an English-language request for restaurant information and returning an English-language response.

:- use_module(restaurant).
:- use_module(dictionary).

% True if T0 starts with a starter phrase followed by a noun phrase followed by a location phrase, T3 is the 
% remainder of T0 after the aforementioned terms have been removed, and Pretty is the
% user-friendly string representation of the restaurants returned by the query
% User asks for a restaurant. If a location is not provided, defaults to Vancouver.
question_en(T0, T3, Pretty) :-
    starter_phrase(T0, T1),
    noun_phrase(T1,T2,Params),
    location_phrase(T2,T3,Params,NewParams),
    get_restaurants(NewParams, Restaurant),
    restaurants_to_pretty_string(Restaurant, Pretty).

% User asks for a property of a restaurant, such as name, phone number, or number of reviews.
% Use default location of Vancouver if none is provided.
% question_en(T0, T3, Result) returns true if T0 starts with a starter phrase followed by a
% compound noun phrase followed by a location phrase, T3 is the 
% remainder of T0 after the aforementioned terms have been removed, and Result is the
% value of the property requested for the resulting restaurant.
% e.g. "What is the name of a restaurant in Seattle"
question_en(T0, T3, Result) :-
    starter_phrase(T0, T1),
    compound_noun_phrase(T1,T2,Property,Params),
    location_phrase(T2,T3,Params,NewParams),
    get_restaurants(NewParams, Restaurant),
    get_property_list(Restaurant,Property,Result).

% User requests the address of a restaurant
% question_en(T0, T1, Address) returns true if T0 starts with "where" followed by a
% noun phrase, T1 is the remainder of T0 after the aforementioned terms have been removed,
% and Result is Address is value address of the resulting restaurant.
question_en(['where',Verb | T0], T1, Address) :-
    to_be_conj(Verb),
    noun_phrase(T0,T1,Params),
    get_restaurants(['location=Vancouver' | Params], Restaurant),
    get_property_list(Restaurant, address, Address).

% Parses phrases containing a location to search by. Defaults to Vancouver if no location is present.
% location_phrase(T0, T1, Params, ParamsWLocation) returns true if T0 starts with a valid
% location starter as defined, T1 is the rest of T0 after relevant location information
% has been removed, and ParamsWLocation is the concatenation of the location query parameter
% onto the list Params.
location_phrase([in | T0], T1, Params, ParamsWithLocation) :-
    location(T0, T1, Params, ParamsWithLocation).
location_phrase([close,to | T0], T1, Params, ParamsWithLocation) :-
    location(T0, T1, Params, ParamsWithLocation).
location_phrase([near | T0], T1, Params, ParamsWithLocation) :-
    location(T0, T1, Params, ParamsWithLocation).
location_phrase(T, T, Params, ['location=Vancouver'|Params]). 

% Adds the location parameter to the list of Params
% location(T0, T1, Params, NewParams) is true if T0 is the location data
% to be parsed from the user input, T1 is the rest of T0 after all location information is
% removed, Params is the current list of query parameters, and NewParams is the corresponding
% query parameter for the location data added to the front of Params.
location(T0, T1, Params, [LocationParam | Params]) :-
    build_location("", T0, T1, Location),
    atom_concat('location=', Location, LocationParam).

% Constructs the location value from the remaining values in the
% original question. Adds to the location until reaching the end
% or valid ending punction.
% build_location(LocList, T0, T1, Result) is true if LocList is the concatenated string of
% location data parsed so far, T0 is the remaining location information to parse, T1 is the
% rest of T0 after all the location information is removed, and Result is the concatenation of
% LocList and T0-T1.
build_location(LocationList, ['?'|T], ['?'|T], LocationList).
build_location(LocationList, ['.'|T], ['.'|T], LocationList).
build_location(LocationList, [], [], LocationList).
build_location(LocationList, [H|T], Rest, Result) :-
    dif(H,'?'),
    dif(H, '.'),
    atom_string(H, NextItemString),
    atom_concat(LocationList, NextItemString, CurrList),
    build_location(CurrList, T, Rest, Result).

% compound_noun_phrase is true if T0-T4 is a compound noun phrase (somthing like
% "the name of " + noun_phrase or "the number of ratings of " + noun_phrase) consisting of
% a determiner, followed by the property Property of the restaurant (e.g. name, ratings), followed by a
% preposition, and then a noun phrase. And Params is the corresponding list of query filters
% based on T0-T4.
compound_noun_phrase(T0, T4, Property, Params) :-
    determiner(T0, T1, 'limit=1'),
    property(T1, T2, Property),
    preposition(T2, T3),
    noun_phrase(T3, T4, Params).

% noun_phrase(T0, T3, Number|Params] is true if T0-T3 is a determiner followed by adjectives followed
% by a noun, Number is the corresponding query parameter for the determiner, and Params is
% the corresponding list of nouns for all the adjectives.
noun_phrase(T0,T3,[Number|Params]) :-
    determiner(T0,T1,Number),
    adjectives(T1,T2,Params),
    noun(T2,T3).

% determiner(T0,T2,Param) is true if T0-T2 is a valid determiner defined in the language,
% and Param is the corresponding query parameter for the expected number of results represented by
% the determiner T0-T2.
determiner(T0,T2,Param) :-
    det(T0,T2,Param).
determiner(T,T,[]).

% adjectives(T0,T1,Params) is true if 
% T0-T1 is an adjective valid for resaurant queries or T0=T1 and
% Params is the corresponding list of query parameters for the parsed adjectives.
adjectives([','|T1],T2,T) :-
    adjectives(T1,T2,T).
adjectives(T0,T2,[FirstParam|T]) :-
    adj(T0,T1,FirstParam),
    adjectives(T1,T2,T).
adjectives(T,T,[]).

% starter_phrase(Question, T) is true if Question-T is a valid starter phrase as defined
% in the lanaguage.
starter_phrase(['what', Verb | T], T) :-
    to_be_conj(Verb).
starter_phrase(['what', '\'', 's' | T], T).
starter_phrase([Imperative | T], T) :-
    imperative(Imperative).
starter_phrase([Imperative, Asker | T], T) :-
    imperative(Imperative),
    asker(Asker).
starter_phrase(['search', 'for' | T], T).

to_be_conj(is).
to_be_conj(are).

imperative('find').
imperative('give').
imperative('show').
imperative('suggest').

asker('me').
asker('us').

% restaurants_to_pretty_string(Restaurants, String) is true if String is a list of
% prettified strings corresponding to each restaurant in Restaurants
restaurants_to_pretty_string([],[]).
restaurants_to_pretty_string([R1|T], [S1|ST]) :-
    pretty_string(R1, S1),
    restaurants_to_pretty_string(T, ST).

% pretty_string(R, Str) is true if Str is the stringified version
% of the restaurant object R
pretty_string(restaurant(basic_info(_, Name, Price, Categories), review_info(Review_Count, Rating), location_info(address(Add1, _, _, City, _, Country, State), _, _), contact_details(Phone,Hours,_)), Str) :-
    pretty_categories(Categories, Pretty_categories),
    pretty_hours(Hours, Pretty_hours),
    atomic_list_concat([Name, " is located at ", Add1, " in ", City, ", ", State, ", ", Country, ". It has a ", Rating, " rating and ", Review_Count, " reviews. Its price is ", Price, ". Its phone number is ", Phone, ". ", Pretty_hours, " Some keywords: ", Pretty_categories], Str).

% pretty_categories(C, S) is true if S is the stringified version
% of the restaurant categories object C
pretty_categories(C, S) :-
    atomic_list_concat(C, ', ', Atom),
    atom_string(Atom, S).

% pretty_hours(Hours, Str) is true if Str is the string representation of all
% the open hours in the list Hours.
pretty_hours(Hours, Pretty_hours) :-
    maplist(pretty_hour, Hours, HoursList),
    atomic_list_concat(HoursList, ', ', CombinedHoursList),
    atomic_concat('It is open ', CombinedHoursList, Pretty_hours).

% pretty_hour(H, Str) is true if Str is the string representation
% of hour object H
pretty_hour(hour(Day,Start,End), Str) :-
    day(Day,PrettyDay),
    atomic_list_concat([PrettyDay, 's from ', Start, ' to ', End], Str).

