:- module(cut, [team_captain/2, team_member/2]).
:- use_module(database).

team_captain(Color, Captain) :- database:team(Color, Captain), !.
team_member(Color, Member) :- database:team(Color, Member).

%team_captain(green, Captain).
%team_captain(X, michal).
%team_member(green, Member).
%team_member(X, michal).