% This file is responsible for taking an French-language request for restaurant information and returning a French-language response (although some data, such as restaurant name, may still be in english)

:- use_module(restaurant).
:- use_module(dictionary).
:- use_module(translations).

% True if T0 starts with a starter phrase followed by a noun phrase followed by a location phrase, T3 is the 
% remainder of T0 after the aforementioned terms have been removed, and Pretty is the
% user-friendly string representation of the restaurants returned by the query
% a question consists of a starter phrase ("Trouvez-moi, qu'est-ce que c'est", etc.) followed by a noun phrase ("un restaurant chinois" or "un restaurant cher")
question_fr(T0, T3, Pretty) :-
    starter_phrase_fren(T0,T1),
    noun_phrase_fren(T1,T3,Params),
    get_restaurants(['location=Vancouver', 'locale=fr_CA' | Params], Restaurant),
    restaurants_to_pretty_string_fr(Restaurant, Pretty).

% starter_phrase_fren(Q, T) is true if Q-T is a valid starter phrase as defined
% in the lanaguage.
starter_phrase_fren(['qu', '\'', 'est','-','ce', 'que', 'c', '\'', 'est'| T], T).
starter_phrase_fren(List, T) :- conj_tu_vous('trouv', List, T).
starter_phrase_fren(List, T) :- conj_tu_vous('cherch', List, T).
starter_phrase_fren(['c','\'','est', 'quoi'| T], T).

% turns something like 'trouv' into 'trouvez', 'trouves', 'trouvez-moi', 'trouves-moi'
% conj_tu_vous(V, [C|T], T) is true C is equal to V concatenated with a valid french verb
% conjugation ending.
conj_tu_vous(VerbStem, [Conj|T], T):-
    string_concat(VerbStem, 'ez', Conj).
conj_tu_vous(VerbStem, [Conj|T], T):-
    string_concat(VerbStem, 'es', Conj).
conj_tu_vous(VerbStem, [H,'-','moi'|T], T):-
    conj_tu_vous(VerbStem, [H|T], T).
conj_tu_vous(VerbStem, [H,'-','nous'|T], T):-
    conj_tu_vous(VerbStem, [H|T], T).

% A noun phrase is a determiner followed by a noun followed by adjectives: "un restaurant chinois"
% noun_phrase(T0, T4, [Number|Params]) is true if T0-T4 is a determiner followed by adjectives followed
% by a noun, optionally followed by other adjectives (all in french), and Number is the corresponding
% query parameter for the determiner, and Params is
% the corresponding list of nouns for all the adjectives.
noun_phrase_fren(T0,T4,[Number|Params]) :-
    determiner_fren(T0,T1,Number),
    adjectives_fren(T1,T2,Params1),
    noun_fren(T2,T3),
    adjectives_fren(T3,T4,Params2),
    append(Params1,Params2,Params).

% determiner_fren is true if T0 is a french determiner 
determiner_fren(T0,Rest,Number) :-
    en_fr(Eng, T0),
    det(Eng, Rest, Number).

% noun_fren is true if T0 is a french noun 
noun_fren(T0,Rest) :-
    en_fr(Eng, T0),
    noun(Eng,Rest).

% adjectives_fren is true if T0 is a french adjective or a set of french adjectives optionally 
% interspersed with commas and "et", and params is the search parameters coming from those adjectives
adjectives_fren([','|T1],T2,T) :-
    adjectives_fren(T1,T2,T).
adjectives_fren(['et'|T1],T2,T) :-
    adjectives_fren(T1,T2,T).
adjectives_fren(T0,T2,[FirstParam|T]) :-
    en_fr(Eng, T0),
    adj(Eng,T1,FirstParam),
    adjectives_fren(T1,T2,T).
adjectives_fren(T,T,[]).

% restaurantsToPrettyString(Restaurants, String) is true if String is a list of
% prettified strings
% corresponding to each restaurant in Restaurants
restaurants_to_pretty_string_fr([],[]).
restaurants_to_pretty_string_fr([R1|T], [S1|ST]) :-
    pretty_string_fr(R1, S1),
    restaurants_to_pretty_string_fr(T, ST).

% pretty_string_fr(R, Str) is true if Str is the stringified version (in french)
% of the restaurant object R
pretty_string_fr(restaurant(basic_info(_, Name, Price, _), review_info(Review_Count, Rating), location_info(address(Add1, _, _, City, _, Country, State), _, _), contact_details(Phone,Hours,_)), Str) :-
    pretty_hours_fr(Hours,PrettyHours),
    atomic_list_concat([Name, ", un restaurant ", Rating, " étoiles avec ", Review_Count,  " évaluations, se trouve à ", Add1, " en ", City, ", ", State, ", ", Country, ". Le prix est ", Price, " et leur numéro de téléphone est ", Phone, ". ", PrettyHours], Str).

% pretty_hours_fr(Hours, Str) is true if Str is the string representation of all
% the open hours in Hours.
pretty_hours_fr(Hours, PrettyHours) :-
    maplist(pretty_hours_fr, Hours, HoursList),
    atomic_list_concat(HoursList, ', ', CombinedHoursList),
    atomic_concat('Ils sont ouvert ', CombinedHoursList, PrettyHours).

% pretty_hours_fr(H, Str) is true if Str is the string representation
% of H in french
pretty_hours_fr(hour(Day,Start,End), Str) :-
    day(Day,EnDay),
    en_fr_sing(EnDay,FrenDay),
    atomic_list_concat(['les ', FrenDay, 's de ', Start, ' à ', End], Str).

