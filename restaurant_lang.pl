% Largely inspired by geography.pl: Copyright (c) David Poole and Alan Mackworth 2017. This program
% is released under GPL, version 3 or later; see http://www.gnu.org/licenses/gpl.html

% This file is the high-level natural language processing for the program. It is responsible for answering user questions.

:- use_module(restaurant_lang_en).
:- use_module(restaurant_lang_fr).

% ask(Q,A) gives answer A to question Q
% ask(Q,A) returns true if A is the answer to question Q
ask(Q,A) :-
    question(Q,[],A).

% Main interaction interface. If after parsing the sentence,
% there is leftover input, returns false.
q(Ans) :-
    write("Let's find some food! Ask me: "), flush_output(current_output),
    readln(Ln),
	maplist(downcase_atom, Ln, Ln_lowercase),
    question(Ln_lowercase,End,Ans),
    member(End,[[],['?'],['.']]).

% question(Ln,End,Ans) is true if Ln-End is a valid question as defined in the
% french and english languages, and Ans is the corresponding restaurant result
% to the question.
question(Ln,End,Ans) :- question_en(Ln,End,Ans).
question(Ln,End,Ans) :- question_fr(Ln,End,Ans).

/*
Example usage:

?- q(Ans).
Let's find some food! Ask me: What is an expensive restaurant?
Ans = [restaurant('4EV_ZcQmjAmP3pmO-_nb2A', 'Miku', @(false), 1390, [japanese, sushi], 4.5, coordinates(49.2870083463066, -123.113051358108), $$$, location('200 Granville Street', 'Suite 70', '', 'Vancouver', 'V6C 1S4', 'CA', 'BC', ['200 Granville Street', 'Suite 70', 'Vancouver, BC V6C 1S4', 'Canada']), '+16045683900', 2648.719549140943)] ;
false.

*/
