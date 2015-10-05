jogador(jogador1).
jogador(jogador2).
coluna(A, B, C, D, E, F, G).
tabuleiro(coluna, coluna, coluna, coluna, coluna, coluna, coluna).
helloWorld:-write('Hello World!').

imprimeNLinha(X, Y) :-
		X == 0, write('\n'), write(Y).
	
	
imprimeLinha(X, Y) :-
		X < 7,
		imprimeNLinha(X, Y),
		B is X + 1,
		imprimeLinha(B, Y).

imprimeNColunas(X, Y) :-
	X == 0, Y < 7,
	write(' | '),write(Y),
	N is Y + 1,
	imprimeNColunas(X, N).

imprimeSeparador(X) :-
	X < 7,
	write(----),
	A is X + 1,
	imprimeSeparador(A).



imprimeTabuleiro(X, Y):-
	Y < 7,
	(imprimeNColunas(X, 0); (write('\n'), imprimeSeparador(0));(write('|  '),imprimeLinha(0, Y)); 1 == 1), 
	B is Y + 1,
	A is X + 1,
	imprimeTabuleiro(A, B).