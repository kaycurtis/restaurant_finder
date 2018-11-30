% This file contains the majority of supported vocabulary for this program.

% Determiners (articles) describe how many results are desired. 
% det([T0|T],T,Param) is true if T0 is a determiner supported by this program corresponding to 
% a query parameter of Param, or if there is no determiner
det([a | Rest], Rest, 'limit=1').
det([an | Rest], Rest, 'limit=1').
det([the | Rest], Rest, 'limit=1').
det([two | Rest], Rest, 'limit=2').
det([three | Rest], Rest, 'limit=3').
det([some | Rest], Rest, 'limit=3').
det(T,T).

% proposition([T|R],R) is true if T0 is a proposition supported by this program. In this case, 'of' is the only supported proposition.
preposition([of | Rest], Rest).

% noun ([T0|T], T) is true if T0 is a noun supported by this program
noun([restaurant | T],T).
noun([place,to,eat | T],T).
noun([restaurants | T],T).
noun([places,to,eat | T],T).

% property ([T0|T],T,Prop) is true if T0 is a term interpreted to be referring to prop 
property([name | Rest], Rest, name).
property([names | Rest], Rest, name).
property([number,of,reviews | Rest], Rest, reviews).
property([numbers,of,reviews | Rest], Rest, reviews).
property([review,count | Rest], Rest, reviews).
property([review,counts | Rest], Rest, reviews).
property([address | Rest], Rest, address).
property([addresses | Rest], Rest, address).
property([location | Rest], Rest, address).
property([locations | Rest], Rest, address).
property([category | Rest], Rest, categories).
property([categories | Rest], Rest, categories).
property([rating | Rest], Rest, rating).
property([ratings | Rest], Rest, ratings).
property([price | Rest], Rest, price).
property([cost | Rest], Rest, price).
property([prices | Rest], Rest, price).
property([costs | Rest], Rest, price).
property([expensiveness | Rest], Rest, price).
property([costs | Rest], Rest, price).
property([costliness | Rest], Rest, price).
property([phone | Rest], Rest, phone).
property([phones | Rest], Rest, phone).
property([telephone | Rest], Rest, phone).
property([telephones | Rest], Rest, phone).
property([number | Rest], Rest, phone).
property([numbers | Rest], Rest, phone).
property([phone,number | Rest], Rest, phone).
property([phone,numbers | Rest], Rest, phone).
property([telephone,number | Rest], Rest, phone).
property([telephone,numbers | Rest], Rest, phone).
property([state | Rest], Rest, state).
property([states | Rest], Rest, state).
property([province | Rest], Rest, state).
property([provinces | Rest], Rest, state).
property([zip | Rest], Rest, zip).
property([zips | Rest], Rest, zip).
property([postal,code | Rest], Rest, zip).
property([postal,codes | Rest], Rest, zip).
property([city | Rest], Rest, city).
property([cities | Rest], Rest, city).

% An adjective maps to a filter for the restaurant query.
% adj([H|T],T,Param) returns true if H is a defined adjective word, T
% is the remaining input to be parsed, and Param is a query parameter
% corresponding to the semantics of H.
adj([expensive | T],T,'price=3,4').
adj([pricy | T], T, 'price=3,4').
adj([cheap | T], T, 'price=1,2').
adj([inexpensive | T], T, 'price=1,2').
adj([good | T], T, 'sort_by=rating').
adj([decent | T], T,'sort_by=rating').
adj([well,-,rated | T], T, 'sort_by=rating').
adj([excellent | T], T, 'sort_by=rating').
adj([amazing | T], T, 'sort_by=rating').
adj([outstanding | T], T, 'sort_by=rating').
adj([fantastic | T], T, 'sort_by=rating').

adj(['afghan'| T], T, 'categories=afghani').
adj(['african'| T], T, 'categories=african').
adj(['andalusian'| T], T, 'categories=andalusian').
adj(['arabian'| T], T, 'categories=arabian').
adj(['argentine'| T], T, 'categories=argentine').
adj(['armenian'| T], T, 'categories=armenian').
adj(['asian', 'fusion'| T], T, 'categories=asianfusion').
adj(['asturian'| T], T, 'categories=asturian').
adj(['australian'| T], T, 'categories=australian').
adj(['austrian'| T], T, 'categories=austrian').
adj(['baguette'| T], T, 'categories=baguettes').
adj(['bangladeshi'| T], T, 'categories=bangladeshi').
adj(['basque'| T], T, 'categories=basque').
adj(['bavarian'| T], T, 'categories=bavarian').
adj(['barbeque'| T], T, 'categories=bbq').
adj(['beer', 'garden'| T], T, 'categories=beergarden').
adj(['beer', 'hall'| T], T, 'categories=beerhall').
adj(['beisl'| T], T, 'categories=beisl').
adj(['belgian'| T], T, 'categories=belgian').
adj(['bistro'| T], T, 'categories=bistros').
adj(['black', 'sea'| T], T, 'categories=blacksea').
adj(['brasserie'| T], T, 'categories=brasseries').
adj(['brazilian'| T], T, 'categories=brazilian').
adj(['breakfast', '&', 'brunch'| T], T, 'categories=breakfast_brunch').
adj(['british'| T], T, 'categories=british').
adj(['buffet'| T], T, 'categories=buffets').
adj(['bulgarian'| T], T, 'categories=bulgarian').
adj(['burger'| T], T, 'categories=burgers').
adj(['burmese'| T], T, 'categories=burmese').
adj(['cafe'| T], T, 'categories=cafes').
adj(['cafeteria'| T], T, 'categories=cafeteria').
adj(['cajun/Creole'| T], T, 'categories=cajun').
adj(['cambodian'| T], T, 'categories=cambodian').
adj(['canteen'| T], T, 'categories=canteen').
adj(['caribbean'| T], T, 'categories=caribbean').
adj(['catalan'| T], T, 'categories=catalan').
adj(['cheesesteak'| T], T, 'categories=cheesesteaks').
adj(['chicken', 'wing'| T], T, 'categories=chicken_wings').
adj(['chicken', 'shop'| T], T, 'categories=chickenshop').
adj(['chilean'| T], T, 'categories=chilean').
adj(['chinese'| T], T, 'categories=chinese').
adj(['comfort', 'food'| T], T, 'categories=comfortfood').
adj(['corsican'| T], T, 'categories=corsican').
adj(['creperie'| T], T, 'categories=creperies').
adj(['cuban'| T], T, 'categories=cuban').
adj(['curry', 'sausage'| T], T, 'categories=currysausage').
adj(['cypriot'| T], T, 'categories=cypriot').
adj(['czech'| T], T, 'categories=czech').
adj(['czech/Slovakian'| T], T, 'categories=czechslovakian').
adj(['danish'| T], T, 'categories=danish').
adj(['deli'| T], T, 'categories=delis').
adj(['diner'| T], T, 'categories=diners').
adj(['dinner', 'theater'| T], T, 'categories=dinnertheater').
adj(['dumpling'| T], T, 'categories=dumplings').
adj(['eastern', 'european'| T], T, 'categories=eastern_european').
adj(['parent', 'cafe'| T], T, 'categories=eltern_cafes').
adj(['ethiopian'| T], T, 'categories=ethiopian').
adj(['filipino'| T], T, 'categories=filipino').
adj(['fischbroetchen'| T], T, 'categories=fischbroetchen').
adj(['fish,', '&', 'chips'| T], T, 'categories=fishnchips').
adj(['flatbread'| T], T, 'categories=flatbread').
adj(['fondue'| T], T, 'categories=fondue').
adj(['food', 'court'| T], T, 'categories=food_court').
adj(['food', 'stands'| T], T, 'categories=foodstands').
adj(['freiduria'| T], T, 'categories=freiduria').
adj(['french'| T], T, 'categories=french').
adj(['galician'| T], T, 'categories=galician').
adj(['game', 'meat'| T], T, 'categories=gamemeat').
adj(['gastropub'| T], T, 'categories=gastropubs').
adj(['georgian'| T], T, 'categories=georgian').
adj(['german'| T], T, 'categories=german').
adj(['giblets'| T], T, 'categories=giblets').
adj(['gluten-free'| T], T, 'categories=gluten_free').
adj(['greek'| T], T, 'categories=greek').
adj(['guamanian'| T], T, 'categories=guamanian').
adj(['halal'| T], T, 'categories=halal').
adj(['hawaiian'| T], T, 'categories=hawaiian').
adj(['heuriger'| T], T, 'categories=heuriger').
adj(['himalayan/Nepalese'| T], T, 'categories=himalayan').
adj(['hong', 'kong', 'style', 'cafe'| T], T, 'categories=hkcafe').
adj(['honduran'| T], T, 'categories=honduran').
adj(['hot', 'dog'| T], T, 'categories=hotdog').
adj(['fast', 'food'| T], T, 'categories=hotdogs').
adj(['hot', 'pot'| T], T, 'categories=hotpot').
adj(['hungarian'| T], T, 'categories=hungarian').
adj(['iberian'| T], T, 'categories=iberian').
adj(['indonesian'| T], T, 'categories=indonesian').
adj(['indian'| T], T, 'categories=indpak').
adj(['international'| T], T, 'categories=international').
adj(['irish'| T], T, 'categories=irish').
adj(['island', 'pub'| T], T, 'categories=island_pub').
adj(['israeli'| T], T, 'categories=israeli').
adj(['italian'| T], T, 'categories=italian').
adj(['japanese'| T], T, 'categories=japanese').
adj(['jewish'| T], T, 'categories=jewish').
adj(['kebab'| T], T, 'categories=kebab').
adj(['kopitiam'| T], T, 'categories=kopitiam').
adj(['korean'| T], T, 'categories=korean').
adj(['kosher'| T], T, 'categories=kosher').
adj(['kurdish'| T], T, 'categories=kurdish').
adj(['laos'| T], T, 'categories=laos').
adj(['laotian'| T], T, 'categories=laotian').
adj(['latin', 'american'| T], T, 'categories=latin').
adj(['lyonnais'| T], T, 'categories=lyonnais').
adj(['malaysian'| T], T, 'categories=malaysian').
adj(['meatball'| T], T, 'categories=meatballs').
adj(['mediterranean'| T], T, 'categories=mediterranean').
adj(['mexican'| T], T, 'categories=mexican').
adj(['middle', 'eastern'| T], T, 'categories=mideastern').
adj(['milk', 'bars'| T], T, 'categories=milkbars').
adj(['modern', 'australian'| T], T, 'categories=modern_australian').
adj(['modern', 'european'| T], T, 'categories=modern_european').
adj(['mongolian'| T], T, 'categories=mongolian').
adj(['moroccan'| T], T, 'categories=moroccan').
adj(['new', 'american'| T], T, 'categories=newamerican').
adj(['new', 'canadian'| T], T, 'categories=newcanadian').
adj(['new', 'mexican'| T], T, 'categories=newmexican').
adj(['new', 'zealand'| T], T, 'categories=newzealand').
adj(['nicaraguan'| T], T, 'categories=nicaraguan').
adj(['night', 'food'| T], T, 'categories=nightfood').
adj(['nikkei'| T], T, 'categories=nikkei').
adj(['noodle'| T], T, 'categories=noodles').
adj(['norcinerie'| T], T, 'categories=norcinerie').
adj(['traditional', 'norwegian'| T], T, 'categories=norwegian').
adj(['open', 'sandwich'| T], T, 'categories=opensandwiches').
adj(['oriental'| T], T, 'categories=oriental').
adj(['pakistani'| T], T, 'categories=pakistani').
adj(['pan', 'asian'| T], T, 'categories=panasian').
adj(['parma'| T], T, 'categories=parma').
adj(['persian/Iranian'| T], T, 'categories=persian').
adj(['peruvian'| T], T, 'categories=peruvian').
adj(['pF/Comercial'| T], T, 'categories=pfcomercial').
adj(['pita'| T], T, 'categories=pita').
adj(['pizza'| T], T, 'categories=pizza').
adj(['polish'| T], T, 'categories=polish').
adj(['polynesian'| T], T, 'categories=polynesian').
adj(['pop-up'| T], T, 'categories=popuprestaurants').
adj(['portuguese'| T], T, 'categories=portuguese').
adj(['potato'| T], T, 'categories=potatoes').
adj(['poutinerie'| T], T, 'categories=poutineries').
adj(['pub', 'food'| T], T, 'categories=pubfood').
adj(['live/Raw Food'| T], T, 'categories=raw_food').
adj(['rice'| T], T, 'categories=riceshop').
adj(['romanian'| T], T, 'categories=romanian').
adj(['rotisserie', 'chicken'| T], T, 'categories=rotisserie_chicken').
adj(['russian'| T], T, 'categories=russian').
adj(['salad'| T], T, 'categories=salad').
adj(['sandwich'| T], T, 'categories=sandwiches').
adj(['scandinavian'| T], T, 'categories=scandinavian').
adj(['schnitzel'| T], T, 'categories=schnitzel').
adj(['scottish'| T], T, 'categories=scottish').
adj(['seafood'| T], T, 'categories=seafood').
adj(['serbo', 'croatian'| T], T, 'categories=serbocroatian').
adj(['signature', 'cuisine'| T], T, 'categories=signature_cuisine').
adj(['singaporean'| T], T, 'categories=singaporean').
adj(['slovakian'| T], T, 'categories=slovakian').
adj(['soul', 'food'| T], T, 'categories=soulfood').
adj(['soup'| T], T, 'categories=soup').
adj(['southern'| T], T, 'categories=southern').
adj(['spanish'| T], T, 'categories=spanish').
adj(['sri', 'lankan'| T], T, 'categories=srilankan').
adj(['steakhouse'| T], T, 'categories=steak').
adj(['french', 'southwest'| T], T, 'categories=sud_ouest').
adj(['supper', 'club'| T], T, 'categories=supperclubs').
adj(['sushi'| T], T, 'categories=sushi').
adj(['swabian'| T], T, 'categories=swabian').
adj(['swedish'| T], T, 'categories=swedish').
adj(['swiss'| T], T, 'categories=swissfood').
adj(['syrian'| T], T, 'categories=syrian').
adj(['tabernas'| T], T, 'categories=tabernas').
adj(['taiwanese'| T], T, 'categories=taiwanese').
adj(['tapa'| T], T, 'categories=tapas').
adj(['tapas/Small Plates'| T], T, 'categories=tapasmallplates').
adj(['tavola', 'calda'| T], T, 'categories=tavolacalda').
adj(['tex-Mex'| T], T, 'categories=tex-mex').
adj(['thai'| T], T, 'categories=thai').
adj(['traditional', 'american'| T], T, 'categories=tradamerican').
adj(['traditional', 'swedish'| T], T, 'categories=traditional_swedish').
adj(['trattorie'| T], T, 'categories=trattorie').
adj(['turkish'| T], T, 'categories=turkish').
adj(['ukrainian'| T], T, 'categories=ukrainian').
adj(['uzbek'| T], T, 'categories=uzbek').
adj(['vegan'| T], T, 'categories=vegan').
adj(['vegetarian'| T], T, 'categories=vegetarian').
adj(['venison'| T], T, 'categories=venison').
adj(['vietnamese'| T], T, 'categories=vietnamese').
adj(['waffle'| T], T, 'categories=waffles').
adj(['wok'| T], T, 'categories=wok').
adj(['wrap'| T], T, 'categories=wraps').
adj(['yugoslav'| T], T, 'categories=yugoslav').

% day(DayNum, DayString) returns true if DayNum is between 0 and 6
% and DayString is the corresponding string representation of
% the day represented by DayNum.
day(0,'Monday').
day(1,'Tuesday').
day(2,'Wednesday').
day(3,'Thursday').
day(4,'Friday').
day(5,'Saturday').
day(6,'Sunday').
