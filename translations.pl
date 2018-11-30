% en_fr_sing([E|T],[F|T]) returns true if F is the French translation from the english
% word E.

% determiners
en_fr_sing(['a' | T], ['un' | T]).
en_fr_sing(['a' | T], ['une' | T]).
en_fr_sing(['the' | T], ['le' | T]).
en_fr_sing(['the' | T], ['la' | T]).
en_fr_sing(['one' | T], ['un' | T]).
en_fr_sing(['two' | T], ['deux' | T]).
en_fr_sing(['three' | T], ['trois' | T]).

% nouns
en_fr_sing(['restaurant' | T], ['restaurant' | T]).
en_fr_sing(['somewhere','to','eat' | T], ['quelque','part','pour','manger' | T]).
en_fr_sing(['restaurants' | T], ['restaurants' | T]).

% adjectives
% for the sake of space, the masculine forms are used
en_fr_sing(['expensive' | T], ['cher' | T]).
en_fr_sing(['good' | T], ['bon' | T]).
en_fr_sing(['nice' | T], ['beau' | T]).
en_fr_sing(['excellent' | T], ['excellent' | T]).
en_fr_sing(['amazing' | T], ['extraordinaire' | T]).
en_fr_sing(['oustanding' | T], ['incroyable' | T]).
en_fr_sing(['cheap' | T], ['pas', 'cher' | T]).

% the following is a shortened list of the available english adjectives
en_fr_sing(['chinese' | T], ['chinois' | T]).
en_fr_sing(['greek' | T], ['grec' | T]).
en_fr_sing(['international' | T], ['international' | T]).

% days
%en_fr_sing(En, Fr) is true if Fr is the corresponding french translation of En.
en_fr_sing('Monday', 'lundi').
en_fr_sing('Tuesday', 'mardi').
en_fr_sing('Wednesday', 'mercredi').
en_fr_sing('Thursday', 'jeudi').
en_fr_sing('Friday', 'vendredi').
en_fr_sing('Saturday', 'samedi').
en_fr_sing('Sunday', 'dimanche').

% this lets you put an 's' onto anything, regardless of whether or not it should have an ['s' | T] :-)
% en_fr_plur(En, [Fr|Rest]) is true if Fr is the translation of En (an english word) to Fr
% with an 's' character added on to the end.
en_fr_plur(En, [Fr|Rest]) :-
    en_fr_sing(En, [Depluralized|Rest]),
    atom(Depluralized),
    atom_concat(Depluralized, 's', Fr).

% en_fr(En, Fr) is true if the lists are the same except the head of Fr is the french
% translation from the corresponding english word at the head of En
en_fr(En, Fr) :- en_fr_sing(En, Fr).
en_fr(En, Fr) :- en_fr_plur(En, Fr).