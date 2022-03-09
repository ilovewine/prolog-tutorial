:- module(custom_expressions, [append_lists/2]).

append_lists(List1+List2, List) :-
	X = [List1|List2],
	custom_flatten(X, List-[]).

custom_flatten([], L-L).
custom_flatten(X, [X|L]-L) :- atomic(X).
custom_flatten([Element|List], Start-End) :-
	custom_flatten(Element, Start-Connection),
	custom_flatten(List, Connection-End), !.


%[a,b,c|Z]-Z=Y-[].
%L1 = [1,2,3], L2 = [4,5,6], append_lists(L1+L2,L).
