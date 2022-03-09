:- module(custom_lists, [member/2, rgb_in_colors/0, rgb_in_colors/1, split_in_half/3, colors/1, custom_length/2, sort_ascii/2, quicksort/2, random_list/2]).

member(Element, [Element|_Tail]) :- !.
member(Element, [_Head|Tail]) :- member(Element, Tail).

%member(2, [x,y,z,er,4,56,2,[f,d,s]]).
%member(X, [x,y,z,er,4,56,2,[f,d,s]]).
%\+ atomic(X), length(X, Length), Length > 1, member(X, [x,y,z,er,4,56,2,[f,d,s]]), !.
%member(_, [x,y,z,er,4,56,2,[f,d,s]]).
%member(_, []).

colors([blue, yellow, green, black, white, red, cyan]).
rgb_in_colors(X) :- member(blue, X), member(green, X), member(red, X).
rgb_in_colors :- colors(X), rgb_in_colors(X).

%colors(X).
%rgb_in_colors.

custom_length(List, Length) :- custom_length(List, Length, 0).
custom_length([], Length, Length) :- !.
custom_length([_|List], Length, Index) :-
	Index1 is Index+1,
	custom_length(List, Length, Index1).

%custom_length(X, 5).
%custom_length([5,4,3,2], Length).

split_in_half(List, FirstHalf, SecondHalf) :-
	length(List, Length),
	split_in_half(Length, 1, List, ReversedFirstHalf, [], SecondHalf),
	reverse(FirstHalf, ReversedFirstHalf),
	!.
split_in_half(Length, Index, [El|List], FirstHalf, FirstHelper, SecondHalf) :-
	Index =< Length / 2,
	split_in_half(Length, Index+1, List, FirstHalf, [El|FirstHelper], SecondHalf).
split_in_half(_Length, _Index, List, FirstHalf, FirstHalf, SecondHalf) :- SecondHalf = List.

%split_in_half([a,b,c,d,e,f], X, Y).
%split_in_half(X, [a,b,c], [d,e,f]).
%split_in_half([a,b,c|Rest],X,[d,e,f]).

sort_ascii(List, SortedList) :-
	list_to_char_codes(List, CodeList),
	quicksort(CodeList, SortedCodeList),
	char_codes_to_list(SortedCodeList, SortedList).

%atom_chars(thisisjustasentence, X), sort_ascii(X, Sorted).

list_to_char_codes(List, CodeList) :- list_to_char_codes(List, CodeList, []).
list_to_char_codes([], CodeList, ReversedCodeList) :- reverse(CodeList, ReversedCodeList), !.
list_to_char_codes([Element|List], CodeList, CodeListHelper) :-
	term_to_atom(Element, Atom),
	char_code(Atom, ElementCode),
	list_to_char_codes(List, CodeList, [ElementCode|CodeListHelper]).

char_codes_to_list(CodeList, List) :- char_codes_to_list(CodeList, List, []).
char_codes_to_list([], List, ReversedList) :- reverse(List, ReversedList), !.
char_codes_to_list([ElementCode|CodeList], List, Helper) :-
	char_code(Element, ElementCode),
	char_codes_to_list(CodeList, List, [Element|Helper]).

quicksort([], []).
quicksort([Head|Tail], SortedList) :-
	split_sort(Head, Tail, FirstHalf, SecondHalf),
	quicksort(FirstHalf, SortedFirstHalf),
	quicksort(SecondHalf, SortedSecondHalf),
	append(SortedFirstHalf, [Head|SortedSecondHalf], SortedList),
	!.

%quicksort([2,45,2346,2,-635,0,28,103456,-574,243,346], Sorted).

split_sort(_, [], [], []).
split_sort(Pivot, [El|List], [El|FirstHalf], SecondHalf) :- El =< Pivot, !, split_sort(Pivot, List, FirstHalf, SecondHalf).
split_sort(Pivot, [El|List], FirstHalf, [El|SecondHalf]) :- El > Pivot, split_sort(Pivot, List, FirstHalf, SecondHalf).

random_list(0, []) :- !.
random_list(Length, [Head|List]) :-
	random(X),
	Head is round(X * 100),
	Length1 is Length-1,
	random_list(Length1, List).

%random_list(6, List).
%random_list(6, List), quicksort(List, Sorted).
