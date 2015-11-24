:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).

% Predicado que inicia a aplicação.
% Disponibiliza ao utilizador as opções existentes.
start :-
	write('\33\[2J'),
	nl, write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t- - >   P I N W H E E L   P U Z Z L E   < - -'), nl, nl,
	write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('Desenvolvido por Pedro Fraga e Pedro Martins, no ambito de Programacao em Logica.'), nl,
	write('Escolha por favor o que deseja fazer:'), nl, nl,
	write('1 - Gerar um problema no modo facil.'), nl,
	write('2 - Gerar um problema no modo dificil.'), nl,
	write('3 - Sair do programa.'), nl, nl,
	repeat,
	write('Opcao (entre 1 e 3) = '),
	read(Option),
	checkOption(Option), !, 
	pinwheelBoard(Board),
	write(Board).

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
firstList({3, 4, 5, 1, 10, 8, 6, 5, 3}).
secondList({5, 4, 6, 4, 6, 6, 4, 5, 5}).
thirdList({5, 7, 8, 4, 5, 3, 2, 6, 7}).
fourthList({8, 5, 6, 2, 1, 4, 6, 7, 4}).

test :- 
	firstList(List1), secondList(List2), thirdList(List3), fourthList(List4),
	FirstElement in List1, SecondElement in List2, ThirdElement in List3, FourthElement in List4,
	sum([FirstElement, SecondElement, ThirdElement, FourthElement], #=, 20), 
	labeling([], [FirstElement, SecondElement, ThirdElement, FourthElement]),
	write(FirstElement), write(' '), write(SecondElement), write(' '), write(ThirdElement), write(' '), write(FourthElement).
	

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
checkOption(1).
checkOption(2).
checkOption(3) :- exitApp.
checkOption(_)
	:- nl, write('!!! ERRO !!! Opcao invalida, deve ser um numero entre 1 e 4. Por favor escolha novamente!'), nl, nl, false.
	
% Predicado para sair do programa, imprimindo a respetiva mensagem no ecrã.
exitApp :- 
	nl, write('--------------------------------------------------------------------'), nl,
	write('O programa vai agora fechar. Para abri-lo novamente escreva ''start.'''),
	nl, write('--------------------------------------------------------------------'),nl, nl, abort.