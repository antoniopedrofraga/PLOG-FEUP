:- use_module(library(clpfd)).
:- use_module(library(lists)).

plr1(Cores, Tamanhos) :-
	Amarelo = 1, Verde = 2, Azul = 3, Preto = 4,
	Cores = [C1, C2, C3, C4],
	Tamanhos = [T1, T2, T3, T4],
	domain(Cores, 1, 4),
	domain(Tamanhos, 1, 4),
	all_different(Cores),
	all_different(Tamanhos),
	element(PosAzul, Cores, Azul),
	PosAntesAzul #= PosAzul - 1,
	PosDepoisAzul #= PosAzul + 1,
	element(PosAntesAzul, Tamanhos, TamAntesAzul),
	element(PosDepoisAzul, Tamanhos, TamDepoisAzul),
	TamAntesAzul #< TamDepoisAzul,
	element(PosVerde, Cores, Verde),
	element(PosVerde, Tamanhos, 1),
	PosAzul #< PosVerde,
	element(PosAmarelo, Cores, Amarelo),
	element(PosPreto, Cores, Preto),
	PosPreto #< PosAmarelo,
	append([Cores, Tamanhos], L),
	labeling([], L).

