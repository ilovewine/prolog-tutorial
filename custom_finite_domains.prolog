:- module(custom_finite_domains, [solve_money_puzzle/1, optimization_problem/1]).
:- use_module(library(clpfd)).

%     S E N D
%   + M O R E
% -----------
% = M O N E Y

% Each letter is a digit from 0 to 9. How do we solve this?

solve_money_puzzle([S, E, N, D] + [M, O, R, E] = [M, O, N, E, Y]) :-
	Digits = [S, E, N, D, M, O, R, Y],
	Digits ins 0..9,
	all_different(Digits),
	M #\= 0,
	S #\= 0,
	S * 1000 + E * 100 + N * 10 + D +
	M * 1000 + O * 100 + R * 10 + E #=
	M * 10000 + O * 1000 + N * 100 + E * 10 + Y,
	label(Digits), !.

% solve_money_puzzle(Send + More = Money).
% solve_money_puzzle(Digits).

% Linear Programming Example

% Problem: We're trying to ship 3 different resources from destination A to B.
% The ship can carry max 5 t and can contain max 7000 l.
% Resource no. 1: 1kg <=> 4l
% Resource no. 2: 1kg <=> 3l
% Resource no. 3: 1kg <=> 5l
% Additionally we have been obligated to provide min 350kg of resource no. 2 and min 200kg of resource no. 3.
% Table of profits:
%   profit | weight | resource
% ---------------------------
%  170 PLN |  1 kg  | no. 1
%  100 PLN |  1 kg  | no. 2
%  300 PLN |  1 kg  | no. 3

% How much of all of these resources should we load onto the ship to maximise profits?

% X1, X2, X3 - weights of corresponding resources [kg]
optimization_problem([X1, X2, X3]) :-
	Resources = [X1, X2, X3],
	Resources ins 0..5000,
	X1 + X2 + X3 #=< 5000,
	4*X1 + 3*X2 + 5*X3 #=< 7000,
	X2 #>= 350,
	X3 #>= 200,
	Profit #= 170*X1 + 100*X2 + 300*X3,
	Costs #= X1 + X2 + X3,
	labeling([max(Profit), min(Costs)], Resources), !, writeln(Profit).