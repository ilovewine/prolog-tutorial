:- module(custom_lists, [member/2, rgb_in_colors/0, rgb_in_colors/1, split_in_half/3, colors/1, custom_length/2, sort_ascii/2, quicksort/2, random_list/2]).

member(Element, [Element|_Tail]) :- !.
member(Element, [_Head|Tail]) :- member(Element, Tail).

colors([blue, yellow, green, black, white, red, cyan]).
rgb_in_colors(X) :- member(blue, X), member(green, X), member(red, X).
rgb_in_colors :- colors(X), rgb_in_colors(X).

custom_length(List, Length) :- custom_length(List, Length, 0).
custom_length([], Length, Length) :- !.
custom_length([_|List], Length, Index) :-
	Index1 is Index+1,
	custom_length(List, Length, Index1).

split_in_half(List, FirstHalf, SecondHalf) :-
	length(List, Length),
	split_in_half(Length, 1, List, ReversedFirstHalf, [], SecondHalf),
	reverse(FirstHalf, ReversedFirstHalf),
	!.
split_in_half(Length, Index, [El|List], FirstHalf, FirstHelper, SecondHalf) :-
	Index =< Length / 2,
	split_in_half(Length, Index+1, List, FirstHalf, [El|FirstHelper], SecondHalf).
split_in_half(_Length, _Index, List, FirstHalf, FirstHalf, SecondHalf) :- SecondHalf = List.

sort_ascii(List, SortedList) :-
	list_to_char_codes(List, CodeList),
	quicksort(CodeList, SortedCodeList),
	char_codes_to_list(SortedCodeList, SortedList).

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

quicksort([El2, El1], [El1, El2]) :- El1 =< El2.
quicksort([El1, El2], [El1, El2]) :- !.
quicksort([Head|Tail], SortedList) :-
	split_sort(Head, [Head|Tail], FirstHalf, SecondHalf),
	quicksort(FirstHalf, SortedFirstHalf),
	quicksort(SecondHalf, SortedSecondHalf),
	append(SortedFirstHalf, SortedSecondHalf, SortedList),
	!.

split_sort(Element, List, FirstHalf, SecondHalf) :-
	split_sort(Element, List, FirstHalf, [], SecondHalf, []).
split_sort(Element, [El|List], FirstHalf, FirstHelper, SecondHalf, SecondHelper) :-
	El =< Element,
	split_sort(Element, List, FirstHalf, [El|FirstHelper], SecondHalf, SecondHelper),
	!.
split_sort(Element, [El|List], FirstHalf, FirstHelper, SecondHalf, SecondHelper) :-
	split_sort(Element, List, FirstHalf, FirstHelper, SecondHalf, [El|SecondHelper]).
split_sort(_Element, [], FirstHalf, FirstHalf, SecondHalf, SecondHalf) :- !.

random_list(0, []) :- !.
random_list(Length, [Head|List]) :-
	random(X),
	Head is round(X * 100),
	Length1 is Length-1,
	random_list(Length1, List).