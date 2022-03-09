:- module(database, [person/3, connection/2]).
:- table connection/2.

person(sebastian, jarosz, birth(29, 03, 1995)).
person(mateusz, piątkowski, birth(01, 12, 1985)).
person(martyna, wojciechowska, birth(03, 01, 2020)).
person(mateusz, kowalski, birth(05, 05, 1995)).
person(michal, tenczyński, birth(12, 08, 2002)).
person(taduesz, ponczek, birth(12, 12, 2012)).
person(gabriela, tomczak, birth(10, 04, 2000)).

team(green, mateusz).
team(green, michal).
team(green, tadeusz).
team(red, maria).
team(red, anna).
team(red, justyna).
team(blue, piotr).
team(blue, michal).
team(blue, zygmunt).

connection('Krakow', 'Warszawa').
%connection('Lublin', 'Warszawa').
connection('Krakow', 'Gdansk').
connection('Gdynia', 'Wroclaw').
%connection('Wroclaw', 'Krakow').
%connection('Poznan', 'Warszawa').
%connection('Lublin', 'Gdansk').
connection('Gdansk', 'Gdynia').
connection('Lublin', 'Poznan').
%connection('Poznan', 'Krakow').
connection(X, Y) :- connection(X, Z), connection(Z, Y).
connection(X, Y) :- connection(Y, X).


%person(X, Y, birth(_,_,Year)), Year =< 2004.
%person(mateusz, _, _).
%connection('Lublin', 'Krakow').
%connection('Krakow', 'Gdynia').
%connection('Krakow', X).