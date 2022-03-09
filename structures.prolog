:- module(structures, [create_term_using_functor/3, create_term/3]).

create_term_using_functor(Name, Args, Term) :-
	length(Args, Length),
	functor(Term, Name, Length),
	assign_args(Term, Args, 1), !.

assign_args(_, [], _).
assign_args(Term, [Arg|Args], Index) :-
	arg(Index, Term, Arg),
	Index1 is Index + 1,
	assign_args(Term, Args, Index1).

create_term(Name, Args, Term) :- Term =..[Name|Args].

% create_term(writeln, ['hello'], T), call(T).
% create_term_using_functor(person, [sebastian, jarosz, X], Term), call(Term).