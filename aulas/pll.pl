:- use_module(library(clpfd)).
:- use_module(library(lists)).

carteiro(N, L, C) :-
	length(L, N),
	domain(L, 1, N),
	all_distinct(L),
	soma_dif(L, C),
	reset_timer,
	labeling([maximize(C)], L),
	print_time,
	fd_statistics.
	
carteiro_rapido(N, L, C) :-
	length(L, N),
	domain(L, 1, N),
	circuit(L),
	soma_dif(L, C),
	reset_timer,
	labeling([maximize(C)], L),
	print_time,
	fd_statistics.
	
soma_dif([X, Y | R], SD) :-
	SD #= abs(X - Y) + SDR,
	soma_dif([Y | R], SDR).
	
soma_dif([_], 0).



reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.
	