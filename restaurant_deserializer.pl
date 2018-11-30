% restaurant(basic_info, review_info, location_info, contact_details)

% basic_info(id, name, price, categories)
% price is a number of dollar signs ($ or $$ or $$$)
% categories is of form [chinese, noodles]

% review_info(review_count, rating)

% location_info(address, coordinates, distance)
% address(add1, add2, add3, city, zip, country, state)

% contact_details(phone, hours, open_now)
% hours is of the form [hour(Day,Start,End)]

% get_restaurant_list(Restaurants,Json) is true if Restaurants is a list of restaurant objects corresponding to Json, a list of json objects
get_restaurant_list([],[]).
get_restaurant_list([ResH|ResT], [JsonH|JsonT]) :-
	convert_to_undetailed_restaurant(ResH, JsonH),
	get_restaurant_list(ResT, JsonT).

% key_value_pair(k, v, lst) returns true if lst contains an entry k=v 
key_value_pair(Key, Value, [(Key=Value)|_]).
key_value_pair(Key, Value, [_|T]) :- key_value_pair(Key, Value, T).

% contains_key (k, lst) returns true if lst contains an entry k=v for some v
contains_key(K, Lst) :- key_value_pair(K, _, Lst).

% add_details(Restaurant,UndetailedRestaurant,Json) is true if Restaurant is the UndetailedRestaurant with extra information from Json added 
add_details(restaurant(Basic_info, Review_info, Location_info, contact_details(Phone, Hours, Open_now)), 
	restaurant(Basic_info, Review_info, Location_info, contact_details(Phone, _, _)), List) :-
		key_value_pair(hours, [json(RawHours)], List),
		get_hour_info(Hours, Open_now, RawHours).

% get_hour_info(Hours, OpenNow, RawHours) is true if Hours is the list of
% open hours corresponding to RawHours json, and OpenNow is the value of
% the is_open_now json key in RawHours json.
get_hour_info(Hours, OpenNow, RawHours) :-
	key_value_pair(open, HourList, RawHours),
	get_hours(Hours, HourList),
	key_value_pair(is_open_now, OpenNow, RawHours).

% Parse the opening hours returned in JSON to a list of hour(Day,Start,End)
% get_hours(ParsedHours, RawJsonHours) is true if ParsedHours is the corresponding
% list of hour(Day,Start,End) data to the json representation in RawJsonHours
get_hours([],[]).
get_hours([hour(Day,Start,End)|HoursRest], [json(JsonObj)|JsonRest]) :-
	key_value_pair(day,Day,JsonObj),
	key_value_pair(start,Start,JsonObj),
	key_value_pair(end,End,JsonObj),
	get_hours(HoursRest, JsonRest).

% convert_to_undetailed_restaurant(R, Json) is true if R is the restaurant object parsed from Json
convert_to_undetailed_restaurant(restaurant(Basic_info, Review_info, Location_info, contact_details(Phone,'','')), json(List)) :-
	convert_to_basic_info(Basic_info, List),
	convert_to_review_info(Review_info, List),
	convert_to_location_info(Location_info, List),
	get_nullable_property(phone, Phone, List).

% convert_to_undetailed_restaurant(Info, List) is true if Info is the basic_info object extracted from List
convert_to_basic_info(basic_info(Id, Name, Price, Categories), List) :-
	key_value_pair(id, Id, List),
	get_nullable_property(name, Name, List),
	get_nullable_property(price, Price, List), % $$$
	key_value_pair(categories, CategoriesList, List),
	get_category_list(Categories, CategoriesList).

% convert_to_undetailed_restaurant(Review, List) is true if Review is the review object extracted from List
convert_to_review_info(review_info(Review_Count, Rating), List) :-
	get_nullable_property(review_count, Review_Count, List),
	get_nullable_property(rating, Rating, List).

% convert_to_undetailed_restaurant(LocationInfo, List) is true if LocationInfo is the location_info object
% extracted from Json
convert_to_location_info(location_info(Address, Coordinates, Distance), List) :-
	key_value_pair(coordinates, json(CoordinatesList), List),
	get_coordinates(Coordinates, CoordinatesList),
	key_value_pair(location, json(LocationJson), List),
	convert_to_address(Address, LocationJson),	
	get_nullable_property(distance, Distance, List).

% get_nullable_property returns true if the list contains the value for the property or if the property isn't present and the value is not available
get_nullable_property(Property,Value,List) :- key_value_pair(Property, Value, List).
get_nullable_property(Property,'not available', List) :- \+contains_key(Property, List).

% get_category_list(Categories,Json) is true if Categories is the categories object parsed from Json
get_category_list([],[]).
get_category_list([H|T], [json(Json)|JsonTail]) :- key_value_pair(alias, H, Json), get_category_list(T, JsonTail).

% get_coordinates(Coordinates,Json) is true if Coordinates is the coordinates object parsed from Json
get_coordinates(coordinates(Lat,Lon), JsonList) :- key_value_pair(latitude, Lat, JsonList), key_value_pair(longitude, Lon, JsonList).

% getLocation(Location,Json) is true if Location is the location object parsed from Json
convert_to_address(address(Add1, Add2, Add3, City, Zip, Country, State), LocationJson) :-
	key_value_pair(address1, Add1, LocationJson),
	key_value_pair(address2, Add2, LocationJson),
	key_value_pair(address3, Add3, LocationJson),
	key_value_pair(city, City, LocationJson),
	key_value_pair(zip_code, Zip, LocationJson),
	key_value_pair(country, Country, LocationJson),
	key_value_pair(state, State, LocationJson).

% get_property_list(Restaurants,Property,Properties) is true if Properties is a list of Property for each restaurant in Restaurants
% e.g. Get all the phone numbers of a list of restaurants ['4159999999','2501020320']
get_property_list([],_,[]).
get_property_list([H|T],Prop,[H2|T2]) :- get_property(H, Prop, H2), get_property_list(T, Prop, T2).

% get_property(Restaurant,Property,Value) is true if property Property has value Value in the given Restaurant
get_property(restaurant(basic_info(Id,_,_,_),_,_,_), id, Id).
get_property(restaurant(basic_info(_,Name,_,_),_,_,_), name, Name).
get_property(restaurant(basic_info(_,_,Price,_),_,_,_), price, Price).
get_property(restaurant(basic_info(_,_,_,Categories),_,_,_), caregories, Categories).
get_property(restaurant(_,review_info(Review_count,_),_,_),reviews, Review_count).
get_property(restaurant(_,review_info(_,Rating),_,_),rating, Rating).
% address(add1, add2, add3, city, zip, country, state)
get_property(restaurant(_,_,location_info(address(Add1, _, _, _, _, _, _),_,_),_),address, Add1).
get_property(restaurant(_,_,location_info(address(_, _, _, _, _, _, State),_,_),_),state, State).
get_property(restaurant(_,_,location_info(address(_, _, _, _, _, Country, _),_,_),_),country, Country).
get_property(restaurant(_,_,location_info(address(_, _, _, _, Zip, _, _),_,_),_),zip, Zip).
get_property(restaurant(_,_,location_info(address(_, _, _, City, _, _, _),_,_),_),city, City).
get_property(restaurant(_,_,location_info(_,Coordinates,_),_),coordinates, Coordinates).
get_property(restaurant(_,_,_,contact_details(Phone,_,_)), phone, Phone).
get_property(restaurant(_,_,_,contact_details(_,Hours,_)), hours, Hours).