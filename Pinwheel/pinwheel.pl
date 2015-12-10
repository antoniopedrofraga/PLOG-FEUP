:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(samsort)).

% Predicado que inicia a aplicação.
% Disponibiliza ao utilizador as opções existentes.
start :-
	write('\33\[2J'),
	nl, write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t- - >   P I N W H E E L   P U Z Z L E   < - -'), nl, nl,
	write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('Desenvolvido por Pedro Fraga e Pedro Martins, no ambito de Programacao em Logica.'), nl,
	write('Escolha por favor o que deseja fazer:'), nl, nl,
	write('1 - Gerar um problema'), nl,
	write('2 - Sair do programa.'), nl, nl,
	repeat,
	write('Opcao (entre 1 e 2) = '),
	read(Option),
	checkOption(Option).

pinwheelBoard([
	[3, 5, 5, 8],
	[4, 4, 7, 5],
	[5, 6, 8, 6],
	[1, 4, 4, 2],
	[10, 6, 5, 1],
	[8, 6, 3, 4],
	[6, 4, 2, 6],
	[5, 5, 6, 7],
	[3, 5, 7, 4]]
	).

setPossibleNumbers({1, 2, 3, 4, 5, 6, 7, 8, 10}).
firstList([3, 4, 5, 1, 10, 8, 6, 5, 3]).
secondList([5, 4, 6, 4, 6, 6, 4, 5, 5]).
thirdList([5, 7, 8, 4, 5, 3, 2, 6, 7]).
fourthList([8, 5, 6, 2, 1, 4, 6, 7, 4]).


% Acede um elemento numa lista a partir do índice passado como argumento.
% Condição de terminação: quando o índice estiver a 1.
getListElement([Element | _], 1, Element).
getListElement([_ | Xs], Index, Element) :-
	Index > 1, NewIndex is Index-1, getListElement(Xs, NewIndex, Element).

drawCircle :-
    write('    /  /              /  /'), nl,
    write(' /        /        /        /'), nl,
    write('/          /      /          /'), nl,
    write('/          /      /          /'), nl,
    write(' /        /        /        /'), nl,
    write('    /  /              /  /').

% checkOption/1 pode ter um valor entre 1 e 3. Todos os outros são opções inválidas.
checkOption(1) :- configureSolve.
checkOption(2) :- exitApp.
checkOption(_)
	:- nl, write('!!! ERRO !!! Opcao invalida, deve ser um numero entre 1 e 4. Por favor escolha novamente!'), nl, nl, false.
	
% Predicado para sair do programa, imprimindo a respetiva mensagem no ecrã.
exitApp :- 
	nl, write('--------------------------------------------------------------------'), nl,
	write('O programa vai agora fechar. Para abri-lo novamente escreva ''start.'''),
	nl, write('--------------------------------------------------------------------'),nl, nl, abort.
	
	
	
apply_permutation([], []).
apply_permutation([Line|Board], [ResultLine|Result]):-
	length(Line, N),
	length(ResultLine, N),
	length(P, N),
	trace,
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
	write(Result),
    transpose(Result, Columns),
    apply_sum(Columns, Sum),
    flatten_list(Result, Results),
	write(Results),
    labeling([], Results).
							   
flatten_list([],[]).
flatten_list([L1|Ls], Lf):- is_list(L1), flatten_list(L1, L2), append(L2, Ld, Lf), flatten_list(Ls, Ld).
flatten_list([L1|Ls], [L1|Lf]):- \+is_list(L1), flatten_list(Ls, Lf).



% Predicado que desenha o puzzle juntamente com a soma de todas as colunas

configureSolve :-
	firstList(L1),
	secondList(L2),
	thirdList(L3),
	fourthList(L4),
	Board = [L1, L2, L3, L4],
	getSize(Board, S),
	nl,
	drawBoard(Board, S).
	
	
% Predicado que desenha o puzzle para interação com o utilizador.
% Faz uso de um outro predicado auxiliar para desenhar cada linha individualmente.
drawBoard([], S):-
	write('    +'), drawTop(S).
	
drawBoard([X | Xs], S) :-
	write('    +'), drawTop(S),
	write('    |'), drawMiddle(S),
	write('    |'), drawLine(X), nl,
	write('    |'), drawMiddle(S),
	drawBoard(Xs, S).

% Predicado para desenhar uma linha do tabuleiro (convertendo cada valor individual).
% Condição de terminação: lista vazia (percorreu a linha até ao fim).
drawLine([]).
drawLine([X | Xs]) :-
	convertValue(X), write('|'), drawLine(Xs).
	

convertValue(10) :-
	write(' '), write(10), write('  ').	

convertValue(X) :-
	write('  '), write(X), write('  ').

	
drawTop(0) :-
	nl.
	
drawTop(S) :-
	write('-----+'),
	S1 is S - 1, drawTop(S1).

	
drawMiddle(0) :-
	nl.
	
drawMiddle(S) :-
	write('     |'),
	S1 is S - 1, drawMiddle(S1).
	
	
	