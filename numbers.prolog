:- module(numbers, [even/1, odd/1, fibonacci/2]).

even(Number) :- Number mod 2 =:= 0.
odd(Number) :- \+ even(Number).

fibonacci(0, 1) :- !.
fibonacci(1, 1) :- !.
fibonacci(Index, Result) :- Index1 is Index - 2, Index2 is Index - 1, fibonacci(Index1, Result1), fibonacci(Index2, Result2), Result is Result1 + Result2.