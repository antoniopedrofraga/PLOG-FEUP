%--------------------------------%
%--------Syrtis em ProLog--------%
%--------------------------------%
%------- escreve syrtis. --------%
%---- na consola para correr ----%
%--------------------------------%
%--------------------------------%


syrtis :-
	%criaTabuleiro(B, 0, 7)%
	imprimeTabuleiro(0, 7).

	
%-------------------------------%
%-------------------------------%
%-----Predicados para criar-----%
%----------tabuleiro------------%
%-------------------------------%
%-------------------------------%

criaTabuleiro(A, 7, 7).
criaTabuleiro([H | T], X, S) :-
	X1 is X + 1,
	criaLista(H, 0, S),
	criaTabuleiro(T, X1, S).

criaLista(A, 7, 7).
criaLista([H | T], X, S) :-
	X1 is X + 1,
	H = '*',
	criaLista(T, X1, S).
	
	
	
%------------------------------%
%---Predicados para imprimir---%
%------------------------------%
imprimeLinha(0, 0, S) :-
	write('   | '),
	write('0'),
	imprimeLinha(0, 1, S).
	
imprimeLinha(0, X, S) :-
	X < 7,
	write(' | '), write(X),
	N is X + 1,
	imprimeLinha(0, N, S).

imprimeLinha(0, 7, S) :-
	write(' |\n').

imprimeLinha(Y, 7, S) :-
	write('\n').	
	
imprimeLinha(Y, 0, S) :-
	write(' '),
	write(Y),
	write(' |'),
	write(' * |'),
	imprimeLinha(Y, 1, S).

imprimeLinha(Y, X, S) :- 
	X < 7,
	write(' * '),
	write('|'),
	A is X + 1,
	imprimeLinha(Y, A, S).

imprimeLinha(7, 7, S) :-
	write('\n').

	
imprimeSeparador(X, S) :-
	X < S,
	write(----),
	A is X + 1,
	imprimeSeparador(A, S).

imprimeSeparador(A, A):-
	write('\n').

imprimeTabuleiro(X, S):-
	X < S,
	imprimeLinha(X, 0, S),
	imprimeSeparador(-1, S), %--desde o indice -1, para cobrir os indices das linhas--% 
	B is X + 1,
	imprimeTabuleiro(B, S).
	
imprimeTabuleiro(S,S).
	