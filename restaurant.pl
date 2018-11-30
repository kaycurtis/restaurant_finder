% This file contains the API connection for this program. It is responsible for making calls to the Yelp API
% and translating the response into a format which is usable for the caller classes.

:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(restaurant_deserializer).

api_key('Available on request').
search_url("https://api.yelp.com/v3/businesses/search?").
details_url("https://api.yelp.com/v3/businesses/").

% returns true if List is the json list returned by the yelp api after a GET call to the base url with the provided query parameters
% params is of the form ['queryParam1=XXXX','queryParam2=YYYYY']
% e.g. try get_by_params(Restaurants, ['location=Seattle,WA','limit=4','term=greek']).
get_by_params(List, Params) :- 
	search_url(SearchUrl),
	get_url(SearchUrl, Params, ParamaterizedSearchUrl),
	make_request(ParamaterizedSearchUrl, json(List)).

% returns true if Restaurants is a list of restaurants returned by the yelp api after a GET call to the base url with the provided query parameters
% with additional details provided by subsequent calls to the details URL
% params is of the form ['queryParam1=XXXX','queryParam2=YYYYY']
% e.g. try get_by_params(Restaurants, ['location=Seattle,WA','limit=4','term=greek']).
get_restaurants(Params, Details) :-
    get_by_params(List, ['term=restaurant' | Params]),
    key_value_pair(businesses, Businesses, List),
	get_restaurant_list(Restaurants, Businesses),
	get_restaurant_list_with_details(Restaurants, Details).

% get_restaurant_list_with_details(Restaurants, Details) calls the details URL with the id of each restaurant, and adds detail to each
%get_restaurant_list_with_details(Rest, Details) is true if each item in Details list
% is the corresponding restaurant to the item at the same index of Rest, but with additional
% details included.
get_restaurant_list_with_details([],[]).
get_restaurant_list_with_details([Restaurant|Tail], [Det|DetT]) :-
	get_details_url(Restaurant, DetailsUrl),
	make_request(DetailsUrl, json(Json)),
	add_details(Det, Restaurant, Json),
	get_restaurant_list_with_details(Tail, DetT).

% get_details_url(R, U) is true if DetailsURL is the corresponding Yelp API details url to the restaurant R.
get_details_url(Restaurant,DetailsUrl) :-
	details_url(BaseDetailsUrl),
	get_property(Restaurant,id, Id),
	atomic_list_concat([BaseDetailsUrl,Id], DetailsUrl).

% takes in a url of form "http://example.com?" and a list of parameters of form ["param1=XXX","param2=XXX"] and gets a url of form "http//example.com?param1=XXX&param2=XXX"
% get_url(Url, List, CompleteUrl) is true if CompleteUrl is the Url concatenated to the stringified List of
% query parameters
get_url(Url,[],Url).
get_url(Url, [Param1|T], EndUrl) :- atom_string(Param1, ParamString),
	atomic_list_concat([Url, "", ParamString], NewUrl),
	get_url_rest(NewUrl, T, EndUrl).

% get_url_rest(Url,Params,EndUrl) is true if EndUrl is Url followed by each of the params, joined by the & character
get_url_rest(Url,[],Url).
get_url_rest(Url, [Param1|T], EndUrl) :- atom_string(Param1, ParamString), 
	atomic_list_concat([Url, "&", ParamString], NewUrl),
	get_url_rest(NewUrl, T, EndUrl).

% make_request(URL, Response) is true if Response is the response returned by an HTTP request to URL
make_request(URL, Response) :-
	api_key(Key),
	http_get(URL, JSONResponse,
			[request_header('Authorization'=Key)]),
	atom_json_term(JSONResponse, Response, []).
