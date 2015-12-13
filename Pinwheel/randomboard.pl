
randomMode(_) :-
	write('\33\[2J'),
	nl, write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t- - >   P I N W H E E L   P U Z Z L E   < - -'), nl, nl,
	write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('Desenvolvido por Pedro Fraga e Pedro Martins, no ambito de Programacao em Logica.'), nl,
	write('Escolha por favor o valor da soma resultante entre colunas:'), nl, nl,
	repeat,
	write('Valor (entre 10 e 40) = '),
	read(Option), get_char(_),
	Option >= 10, Option =< 40,
	printGeneratingRandomBoard(Option).
	
	

printGeneratingRandomBoard(Sum) :-
	write('\33\[2J'),
	nl, 
	nl, write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('\t\t- - >   P I N W H E E L   P U Z Z L E   < - -'), nl, nl,
	write('\t\t+ - + - + - + - + - + - + - + - + - + - + - +'), nl, nl,
	write('Desenvolvido por Pedro Fraga e Pedro Martins, no ambito de Programacao em Logica.'), nl,
	nl, 
	nl,
	write('A gerar um puzzle aleatorio cuja soma entre colunas resulte em '),
	write(Sum),
	write('...'),
	nl,
	nl,
	write('Por favor aguarde...'),
	nl,
	nl,
	nl,
	initializeRandomSeed,
	generateRandomBoard(Sum).
	
	
generateRandomBoard(Sum) :-
	random(4, 10, NCol),
	random(4, 10, NLin),
	createBoard(Board, NCol, NLin, 0, FinalNumber),
	transpose(Board, Columns),
    apply_sum(Columns, Sum),
    flatten_list(Board, Results),
    labeling( [maximize(FinalNumber), time_out(3, Flag)] , Results),
	drawRandomBoard(Sum, Board, Flag).
	
	
drawRandomBoard(Sum, _, time_out) :-
	generateRandomBoard(Sum).

drawRandomBoard(Sum, Board, _)	:-
	shuffleBoard(Board, Result),
	drawBoard(Result),
	firstUserChoice(Option),
	finalRandom(Option, Sum, Result).
	
finalRandom(1, Sum, Board) :-
	reset_timer,
	solver(Board, Result, Sum), nl, print_time, fd_statistics,
	nl, drawBoard(Result), secondUserChoice, fail.

finalRandom(1, _, _) :-
	nl, nl, nl,
	write('There are no more solutions available...'),
	nl, nl,
	abruptExit.
	
	
finalRandom(2, Sum, _) :-
	generateRandomBoard(Sum).
	
finalRandom(3, _, _).
	
	

shuffleBoard( [] , _).
	
shuffleBoard( [L1 | LRest] , [SL1 | SLRest]) :-
	shuffleList(L1, SL1),
	shuffleBoard(LRest, SLRest).
	
	
	
createBoard(_, _, 0, N, Final) :-
	Final #= N.

createBoard([Lin | Rest], NCol, NLin, N, Final) :-
	length(Lin, NCol),
	domain(Lin, 0, 10),
	nvalue(Number, Lin),
	N1 #= Number + N,
	NLin1 is NLin - 1,
	createBoard(Rest, NCol, NLin1, N1, Final).