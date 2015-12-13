:- use_module(library(clpfd)).
:- use_module(library(lists)).

livros(Livros, NPrateleiras, Resultado) :-
	length(Somas, NPrateleiras),
	domain(Somas, 0, 5),
	addSpace(NPrateleiras, Resultado),
	somalivros(Livros, Resultado, Somas),
	count(5, Somas,#=,Count),
	labeling([maximize(Count)], Somas),
	write(Resultado),
	nl,
	write(Somas).
	
somalivros([], [], []).
somalivros([], [A | A2], [B | B2]) :-
	A #= 0,
	B #= 0,
	somalivros([], A2, B2).
	
somalivros([X | Resto], [Livro | OutrosLivros], [Soma | Cauda] ) :-
	SomaNova #= X + Soma,
	SomaNova #< 5,
	Livro #= X,
	somalivros(Resto, OutrosLivros, [SomaNova | Cauda]).
	
	
somalivros(Livros, Prateleiras, [_ | Cauda] ) :-
	somalivros(Livros, Prateleiras, Cauda).
	
	