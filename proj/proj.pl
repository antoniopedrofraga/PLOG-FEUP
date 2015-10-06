%--------------------------------%
%--------Syrtis em ProLog--------%
%--------------------------------%
%------- escreve syrtis. --------%
%---- na consola para correr ----%
%--------------------------------%
%--------------------------------%


syrtis :-
	B = _,
	criaTabuleiro(B, 0, 7),
	write('\n\n'),
	imprimeTabuleiro(B, 0, 7).

	

	
%-------------------------------%
%-------------------------------%
%-----Predicados para criar-----%
%----------tabuleiro------------%
%-------------------------------%
%-------------------------------%

criaTabuleiro(_, A, A).
criaTabuleiro([H | T], X, S) :-
	X \= S,
	X1 is X + 1,
	criaLista(H, 0, S),
	criaTabuleiro(T, X1, S).

criaLista(_, A, A).
criaLista([H | T], X, S) :-
	X \= S,
	X1 is X + 1,
	H = ' ',
	criaLista(T, X1, S).


%------------------------------%
%--Predicados para vizualizar--%
%-----------tabuleiro----------%
%------------------------------%

imprimeNCol(0, 0, S) :-
	write('   | '),
	write('0 | '),	
	imprimeNCol(0, 1, S).
	
imprimeNCol(0, Y, S) :-
	Y < S,
	write(Y),
	write(' | '),
	Y1 is Y + 1,
	imprimeNCol(0, Y1, S).

imprimeNCol(0, S, S) :- 
	write('\n'),
	imprimeSeparador(-1, S).

imprimeNCol(_, _, _).


imprimeLinha(_,_, S, S) :-
	write('\n').	
	
imprimeLinha([H | T], Y, 0, S) :-
	write(' '),
	write(Y),
	write(' | '),
	write(H),
	write(' |'),
	imprimeLinha(T, Y, 1, S).

imprimeLinha([H | T], Y, X, S) :- 
	X < S,
	write(' '),
	write(H),
	write(' |'),
	A is X + 1,
	imprimeLinha(T, Y, A, S).

imprimeLinha(_, A, A, _) :-
	write('\n').

	
imprimeSeparador(X, S) :-
	X < S,
	write(----),
	A is X + 1,
	imprimeSeparador(A, S).

imprimeSeparador(A, A):-
	write('\n').

imprimeTabuleiro([H | T], X, S):-
	X < S,
	imprimeNCol(X, 0, S),
	imprimeLinha(H, X, 0, S),
	imprimeSeparador(-1, S), %--desde o indice -1, para cobrir os numeros das linhas--% 
	X1 is X + 1,
	imprimeTabuleiro(T, X1, S).
	
imprimeTabuleiro(_, S, S).
	