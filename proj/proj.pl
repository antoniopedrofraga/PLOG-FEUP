
%--------------------------------%
%--------Syrtis em ProLog--------%
%--------------------------------%
%------- escreve syrtis. --------%
%---- na consola para correr ----%
%--------------------------------%
%--------------------------------%


syrtis :-
	B = _,
	%criaTabuleiro(B, 0, 7),%
	criaTabuleiroTesteFinal(B),
	write('\n\n'),
	imprimeTabuleiro(B, 0, 7).

%--------------------------------%
%------Tabuleiros de teste--------%
%--------------------------------%
criaTabuleiroTesteInicial(B) :-
	L0 = [ 'vazio', 'vazio', 'o-azul', 'quadrado-vermelho', 'o-azul', 'vazio', 'vazio'],
	L1 = [ 'vazio', 'quadrado-vermelho', 'o-azul', 'quadrado-vermelho', 'o-vermelho', 'quadrado-vermelho', 'vazio'],
	L2 = [ 'o-vermelho', 'o-azul', 'quadrado-azul', 'quadrado-vermelho', 'o-vermelho', 'quadrado-azul', 'quadrado-azul'],
	L3 = [ 'o-vermelho', 'quadrado-azul', 'quadrado-azul', 'vazio', 'o-vermelho', 'o-vermelho', 'quadrado-azul'],
	L4 = [ 'o-vermelho', 'o-vermelho', 'quadrado-azul', 'o-azul', 'o-vermelho', 'quadrado-vermelho', 'quadrado-azul'],
	L5 = [ 'vazio', 'o-azul', 'quadrado-azul', 'o-azul', 'quadrado-vermelho', 'o-azul', 'vazio'],
	L6 = [ 'vazio', 'vazio', 'quadrado-vermelho', 'o-azul', 'quadrado-vermelho', 'vazio', 'vazio'],
	B = [L0, L1, L2, L3, L4, L5, L6].

criaTabuleiroTesteIntermedio(B) :-
	L0 = [ 'vazio', 'vazio', 'vazio', 'vazio', 'quadrado-azul', 'vazio', 'vazio'],
	L1 = [ 'vazio', 'vazio', 'quadrado-vermelho', 'o-vermelho', 'o-azul', 'quadrado-vermelho', 'vazio'],
	L2 = [ 'vazio', 'vazio', 'quadrado-vermelho', 'vazio', 'o-vermelho', 'vazio', 'vazio'],
	L3 = [ 'vazio', 'vazio', 'quadrado-azul', 'vazio', 'vazio', 'vazio', 'vazio'],
	L4 = [ 'vazio', 'vazio', 'o-vermelho', 'quadrado-azul', 'o-azul', 'vazio', 'vazio'],
	L5 = [ 'vazio', 'quadrado-azul', 'o-azul', 'o-azul', 'quadrado-vermelho', 'vazio', 'vazio'],
	L6 = [ 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio'],
	B = [L0, L1, L2, L3, L4, L5, L6].
	
criaTabuleiroTesteFinal(B) :-
	L0 = [ 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio'],
	L1 = [ 'vazio', 'vazio', 'quadrado-azul', 'vazio','vazio', 'vazio', 'vazio'],
	L2 = [ 'vazio', 'vazio', 'o-vermelho', 'quadrado-azul', 'vazio', 'vazio', 'vazio'],
	L3 = [ 'vazio', 'vazio', 'o-vermelho', 'o-azul', 'o-vermelho', 'vazio', 'vazio'],
	L4 = [ 'vazio', 'quadrado-azul', 'o-azul', 'quadrado-vermelho', 'quadrado-vermelho', 'quadrado-vermelho', 'vazio'],
	L5 = [ 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio'],
	L6 = [ 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio', 'vazio'],
	B = [L0, L1, L2, L3, L4, L5, L6].
	
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
	H = 'quadrado-azul',
	criaLista(T, X1, S).


%------------------------------%
%--Predicados para vizualizar--%
%-----------tabuleiro----------%
%------------------------------%

interpreta('o-vermelho') :-
	ansi_format([bold,fg(red)], '( )', []).

interpreta('o-azul') :-
	ansi_format([bold,fg(blue)], '( )', []).
	
interpreta('quadrado-vermelho') :-
	ansi_format([bold,fg(red)], '[ ]', []).
	
interpreta('quadrado-azul') :-
	ansi_format([bold,fg(blue)], '[ ]', []).

interpreta(_) :-
	write('   ').

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
	