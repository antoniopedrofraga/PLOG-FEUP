

%------------------------------%
%--Predicados para vizualizar--%
%-----------tabuleiro----------%
%------------------------------%

%++++++++++++++ Jogadores ++++++++++++%

imprimeJogador(1) :-
	write('Player 1 turn'), nl,
	ansi_format([bold,fg(blue)], 'blue pieces', []).

imprimeJogador(2) :-
	write('Player 2 turn'), nl,
	ansi_format([bold,fg(red)], 'red pieces', []).
	
%++++++++++++++ Torres ++++++++++++++%

imprimeTorreJogador(1) :-
	imprimeTorre(torre-o-azul).
	
imprimeTorreJogador(2) :-
	imprimeTorre(torre-quadrado-vermelho).
	

imprimeTorre(torre-o-azul) :-
	ansi_format([bold,fg(blue)], '*', []).
	
imprimeTorre(torre-quadrado-vermelho) :-
	ansi_format([bold,fg(red)], '#', []).

imprimeTorre(vazio) :-
	write(' ').
	
imprimeTorre(_) :-
	write('?').

%++++++++++++++ Casas ++++++++++++++++%

interpreta([o-vermelho | Torre ]) :-
	ansi_format([bold,fg(red)], '(', []),
	imprimeTorre(Torre),
	ansi_format([bold,fg(red)], ')', []).

interpreta([o-azul | Torre ]) :-
	ansi_format([bold,fg(blue)], '(', []),
	imprimeTorre(Torre),
	ansi_format([bold,fg(blue)], ')', []).
	
interpreta([quadrado-vermelho | Torre ]) :-
	ansi_format([bold,fg(red)], '[', []),
	imprimeTorre(Torre),
	ansi_format([bold,fg(red)], ']', []).
	
interpreta([quadrado-azul | Torre ]) :-
	ansi_format([bold,fg(blue)], '[', []),
	imprimeTorre(Torre),
	ansi_format([bold,fg(blue)], ']', []).

interpreta([ vazio | _ ]) :-
	write('   ').
	
interpreta(_) :-
	write('err').

	
%+++++++++++ Tabuleiro ++++++++++++%	

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
	write(' |'),
	interpreta(H),
	write('|'),
	imprimeLinha(T, Y, 1, S).

imprimeLinha([H | T], Y, X, S) :- 
	X < S,
	interpreta(H),
	write('|'),
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

imprimeTabuleiro(Tabuleiro) :-
	imprimeTabuleiro(Tabuleiro, 0, 7).
				