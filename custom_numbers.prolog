:- module(custom_numbers, [even/1, odd/1, fibonacci/2, prime/1]).
:- table fibonacci/2.

even(Number) :- Number mod 2 =:= 0.
odd(Number) :- \+ even(Number).

fibonacci(0, 1) :- !.
fibonacci(1, 1) :- !.
fibonacci(Index, Result) :-
	Index1 is Index - 2,
	Index2 is Index - 1,
	fibonacci(Index1, Result1),
	fibonacci(Index2, Result2),
	Result is Result1 + Result2.

prime(Number) :-
	integer(Number),
	!,
	prime(Number, 2).
prime(Number, Helper) :-
	X is sqrt(Number),
	Helper >= X,
	!.
prime(Number, Helper) :-
	GCD is gcd(Number, Helper),
	GCD = 1,
	Helper1 is Helper + 1,
	prime(Number, Helper1), !.
prime(Number, Helper) :-
	GCD is gcd(Number, Helper),
	GCD \= 1,
	write(Number), write(' is divisible by '), writeln(GCD),
	fail.

%prime(23535923437).
%even(34).
%even(47).
%fibonacci(246, Result).