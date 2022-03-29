:- module(io, [write_hello_world/0, write_hello_world/1, get_people_database/0]).
:- use_module(library(readutil)).
:- use_module(database).

write_hello_world(Mode) :-
	writeln('What is your name?'),
	read(Name),
	open('text.txt', Mode, Stream),
	set_output(Stream),
	write('Hello, '),
	write(Name),
	write('!'),
	close(Stream).

write_hello_world :- write_hello_world(write).

get_people_database :-
	read_file_to_string('people.txt', People, []),
	split_string(People, '\n', '\n', Database),
	database_to_terms(Database, [], Terms),
	assert_terms(Terms),
	listing(person),
	person("Tadeusz", LastName, Birth), writeln(LastName), writeln(Birth).

database_to_terms([], Terms, Terms).
database_to_terms([Entry|Database], Helper, Terms) :-
	split_string(Entry, ' ', ' ', SplittedEntry),
	SplittedEntry = [Name, LastName, UnformattedBirth],
	split_string(UnformattedBirth, '.', '.', FormattedBirth),
	Birth =.. [birth|FormattedBirth],
	Term =.. [person, Name, LastName, Birth],
	database_to_terms(Database, [Term|Helper], Terms).

assert_terms([]).
assert_terms([Term|Terms]) :-
	assertz(Term),
	assert_terms(Terms).