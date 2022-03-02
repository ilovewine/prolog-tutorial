:- module(custom_lists, [member/2, rgb_in_colors/0, split_in_half/3, colors/1]).

member(Element, [Element|_Tail]) :- !.
member(Element, [_Head|Tail]) :- member(Element, Tail).

colors([blue, yellow, green, black, white, red, cyan]).
rgb_in_colors :- colors(X), member(blue, X), member(green, X), member(red, X).

split_in_half(List, FirstHalf, SecondHalf) :- length(List, Length), split_in_half(Length, 1, List, ReversedFirstHalf, [], SecondHalf), reverse(FirstHalf, ReversedFirstHalf), !.
split_in_half(Length, Index, [El|List], FirstHalf, FirstHelper, SecondHalf) :- Index =< Length / 2, split_in_half(Length, Index+1, List, FirstHalf, [El|FirstHelper], SecondHalf).
split_in_half(_Length, _Index, List, FirstHalf, FirstHalf, SecondHalf) :- SecondHalf = List.