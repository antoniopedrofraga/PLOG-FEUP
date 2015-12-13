:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(samsort)).
:- use_module(library(system)).
:- include('utilities.pl').
:- include('randomboard.pl').

% Predicado que inicia a aplicação.
% Disponibiliza ao utilizador as opções existentes.
start :-
	write('\33\[2J'),
	nl, write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t- - >   P I N W H E E L   P U Z Z L E   < - -'), nl, nl,
	write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('Desenvolvido por Pedro Fraga e Pedro Martins, no ambito de Programacao em Logica.'), nl,
	write('Escolha por favor o que deseja fazer:'), nl, nl,
	write('1 - Gerar um problema no modo ''soma 20''.'), nl,
	write('2 - Gerar um problema no modo ''soma 15''.'), nl,
	write('3 - Gerar um problema aleatorio com soma definida.'), nl,
	write('4 - Sair do programa.'), nl, nl,
	repeat,
	write('Opcao (entre 1 e 4) = '),
	read(Option), get_char(_),
	checkOption(Option).

firstList([3, 4, 5, 1, 10, 8, 6, 5, 3]).
secondList([5, 4, 6, 4, 6, 6, 4, 5, 5]).
thirdList([5, 7, 8, 4, 5, 3, 2, 6, 7]).
fourthList([8, 5, 6, 2, 1, 4, 6, 7, 4]).

% checkOption/1 pode ter um valor entre 1 e 3. Todos os outros são opções inválidas.
checkOption(1) :- hardMode(_).
checkOption(2) :- easyMode(_).
checkOption(3) :- randomMode(_).
checkOption(4) :- abruptExit.
checkOption(_)
	:- nl, write('!!! ERRO !!! Opcao invalida, deve ser um numero entre 1 e 3. Por favor escolha novamente!'), nl, nl, false.
	
apply_permutation([], []).
apply_permutation([Line|Board], [ResultLine|Result]):-
	length(Line, N),
	length(ResultLine, N),
	length(P, N),
	sorting(ResultLine, P, Line),
	apply_permutation(Board, Result).

apply_sum([], _).
apply_sum([Column|Columns], Sum):-
	sum(Column, #=, Sum),
	apply_sum(Columns, Sum).
	
sort_board([], []).
sort_board([L|B], [SL|SB]):- samsort(L, SL),
   sort_board(B, SB).

solver(Board, Result, Sum):-
    sort_board(Board, Sorted),
    apply_permutation(Sorted, Result),
    transpose(Result, Columns),
    apply_sum(Columns, Sum),
    flatten_list(Result, Results),
    labeling([], Results).
							   
flatten_list([],[]).
flatten_list([L1|Ls], Lf):- is_list(L1), flatten_list(L1, L2), append(L2, Ld, Lf), flatten_list(Ls, Ld).
flatten_list([L1|Ls], [L1|Lf]):- \+is_list(L1), flatten_list(Ls, Lf).

easyMode(Result) :-
	write('\33\[2J'),
	nl, write('\t\t + - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t - - >  P I N W H E E L - S O M A   1 5  < - -'), nl, nl,
	write('\t\t + - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	nl, write('-----------------------------------------------------------------------------------------'), nl,
	write('\t\t\t   O problema foi gerado. '), nl,
	write('O objetivo consiste em organizar cada linha de forma a que o somatorio das colunas de 15. '),
	nl, write('-----------------------------------------------------------------------------------------'), nl, nl,
	secondList(L1),
	thirdList(L2),
	fourthList(L3),
	shuffleList(L1, RL1),
	shuffleList(L2, RL2),
	shuffleList(L3, RL3),
	drawBoard([RL1, RL2, RL3]), firstUserChoice(Choice), 
	easyModeNext(Choice, Result, RL1, RL2, RL3).
	
hardMode(Result) :-
	write('\33\[2J'),
	nl, write('\t\t + - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t - - >  P I N W H E E L - S O M A   2 0  < - -'), nl, nl,
	write('\t\t + - + - + - + - + - + - + - + - + - + - + - +'), nl, 
	nl, write('-----------------------------------------------------------------------------------------'), nl,
	write('\t\t\t   O problema foi gerado. '), nl,
	write('O objetivo consiste em organizar cada linha de forma a que o somatorio das colunas de 20. '),
	nl, write('-----------------------------------------------------------------------------------------'), nl, nl,
	firstList(L1),
	secondList(L2),
	thirdList(L3),
	fourthList(L4),
	shuffleList(L1, RL1),
	shuffleList(L2, RL2),
	shuffleList(L3, RL3),
	shuffleList(L4, RL4),
	drawBoard([RL1, RL2, RL3, RL4]), firstUserChoice(Choice),
	hardModeNext(Choice, Result, RL1, RL2, RL3, RL4).
	
hardModeNext(1, Result, RL1, RL2, RL3, RL4) :-
	reset_timer,
	solver([RL1, RL2, RL3, RL4], Result, 20), nl, print_time, fd_statistics,
	nl, drawBoard(Result), secondUserChoice, fail.	
hardModeNext(2, Result, _, _, _, _) :-
	hardMode(Result).
	
easyModeNext(1, Result, RL1, RL2, RL3) :-
	reset_timer,
	solver([RL1, RL2, RL3], Result, 15), nl, print_time, fd_statistics,
	nl, drawBoard(Result), secondUserChoice, fail.	
easyModeNext(2, Result, _, _, _) :-
	easyMode(Result).
	
shuffleList(A, B) :- random_permutation(A, B).

sumBoard(B, Sum) :-
	transpose(B, NewB),
	sumColumns(NewB, [], Sum).

sumColumns([], B, B).
sumColumns([X | Xs], B, Final) :-
	sumLine(X, Sum),
	append(B, [Sum], NewList),
	sumColumns(Xs, NewList, Final).

sumLine([], 0).
sumLine([X | Xs], Sum) :-
	sumLine(Xs, Sum1),
	Sum is X + Sum1.
	
% Predicado que desenha o puzzle para interação com o utilizador.
% Faz uso de um outro predicado auxiliar para desenhar cada linha individualmente.
drawBoard([], S, SumList):-
	write('\t    +'), drawTop(S), 
	write('\t    '), drawEnd(S), nl, 
	write('\t     '), drawColumnSum(SumList), nl , nl, !.

drawBoard([X | Xs], S, SumList) :-
	write('\t    +'), drawTop(S),
	write('\t    |'), drawMiddle(S),
	write('\t    |'), drawLine(X), nl,
	write('\t    |'), drawMiddle(S),
	drawBoard(Xs, S, SumList), !.

drawBoard([X | Xs]) :-
	sumBoard([X | Xs], SumList),
	getSize([X | Xs], S),
	write('\t    +'), drawTop(S),
	write('\t    |'), drawMiddle(S),
	write('\t    |'), drawLine(X), nl,
	write('\t    |'), drawMiddle(S),
	drawBoard(Xs, S, SumList), !.

% Predicado para desenhar uma linha do tabuleiro (convertendo cada valor individual).
% Condição de terminação: lista vazia (percorreu a linha até ao fim).
drawLine([]).
drawLine([X | Xs]) :-
	convertValue(X), write('|'), drawLine(Xs), !.
	
drawColumnSum([]).
drawColumnSum([X | Xs]) :-
	convertValue(X), write(' '), drawColumnSum(Xs), !.
	
convertValue(X) :-
	X > 9, write(' '), write(X), write('  '), !.	
convertValue(X) :-
	write('  '), write(X), write('  '), !.

drawTop(0) :- nl, !.	
drawTop(S) :-
	write('-----+'),
	S1 is S - 1, drawTop(S1), !.

drawMiddle(0) :- nl, !.	
drawMiddle(S) :-
	write('     |'),
	S1 is S - 1, drawMiddle(S1), !.
	
drawMiddlePlus(0) :- nl, !.	
drawMiddlePlus(S) :-
	write('     +'),
	S1 is S - 1, drawMiddlePlus(S1), !.
	
drawEnd(0) :- nl, !.	
drawEnd(S) :-
	write('   =  '),
	S1 is S - 1, drawEnd(S1), !.
	
getSize([H | _], S) :-
	length(H, S), !.