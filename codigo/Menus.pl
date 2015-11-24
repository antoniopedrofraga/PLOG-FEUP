

%-------------------------------%
%-------------------------------%
%-------Interface de jogo-------%
%-------------------------------%
%-------------------------------%



menuPrincipal :-
	novaLinha(2),
	write('*** Syrtis in Prolog ***\n'), novaLinha(3),
	novaLinha(3),
	write('***************************\n'),
	write('*        Main Menu        *\n'),
	write('***************************'), novaLinha(2),
	write('1 - Play\n2 - About\n3 - Quit\n\n> '),
	get_single_char(Escolha),
	(
		Escolha = 49 -> menuJogo;
		Escolha = 50 -> menuSobre;
		Escolha = 51;
		novaLinha(1),
		limpaEcra,
		write(Escolha), nl,
		write('ERROR : invalid input...'), novaLinha(1),
		menuPrincipal
	).

menuSobre :- limpaEcra, 
			write('***************************\n'),
			write('*        About Menu       *\n'),
			write('***************************'),
			novaLinha(4),
			write('By Pedro Fraga and Carolina Moreira'),
			novaLinha(4),
			write('This code was developed for PLOG subject at FEUP in 2015'),
			novaLinha(4),
			write('"Blue and Red like I dont see what the big deal is!"'),
			novaLinha(4),
			esperaPorEnter, menuPrincipal, !.

menuJogo :-
	limpaEcra,
	criaTabuleiroAleatorio(Tabuleiro),
	Torres = [torre-o-azul, torre-quadrado-vermelho, torre-o-azul, torre-quadrado-vermelho],
	escolheTorres(Tabuleiro, Torres, 0).
			
			
%+++++++++++++++++++ Menu para escolher torres +++++++++++++++++++++++++++%


escolheTorres(Tabuleiro, _, 4) :-
	escolhePecas(Tabuleiro).
	
escolheTorres(Tabuleiro, [Torre1 | Resto], N) :-
	limpaEcra,
	write('***************************\n'),
	write('*         New Game        *\n'),
	write('***************************'),
	novaLinha(4),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Tower to be placed -> '),
	imprimeTorre(Torre1),
	novaLinha(3),
	write('Its time for a player to place the towers...'),
	novaLinha(3),
	write('Write a column number : '),
	obtemNumeroDeTabuleiro(Coluna),
	write('Write a line number : '),
	obtemNumeroDeTabuleiro(Linha),
	novaLinha(3),
	colocaTorre(Tabuleiro, Coluna, Linha, [Torre1 | Resto], N).
	
escolheTorresAviso(Tabuleiro, Torres, N) :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('You cant replace a tower or place a tower where there is no slot!'),
	novaLinha(2),
	write('Pick a slot with the same shape and colour.'),
	novaLinha(3),
	esperaPorEnter,
	escolheTorres(Tabuleiro, Torres, N).

	
%++++++++++++++++++++++++++ Menu para escolher pecas ++++++++++++++++++++++++++%

escolhePecas(Tabuleiro) :-
	limpaEcra,
	write('***************************\n'),
	write('*         New Game        *\n'),
	write('***************************'),
	novaLinha(4),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(4),
	write('The other player should now pick a side, '),
	ansi_format([bold,fg(blue)], 'blue', []),
	write(' pieces play first.'),
	novaLinha(3),
	write('1 - '), ansi_format([bold,fg(blue)], 'blue', []), nl,
	write('2 - '), ansi_format([bold,fg(red)], 'red', []), nl,
	novaLinha(2),
	Escolha = _,
	obtemNumero(Escolha, 1, 2),
	informaNumeroJogador(Tabuleiro, Escolha).
	
	
informaNumeroJogador(Tabuleiro, 1) :-
	limpaEcra,
	write('***************************\n'),
	write('*         New Game        *\n'),
	write('***************************'),
	novaLinha(4),
	write('The player who picked a side is now the P1, he should play first with '), ansi_format([bold,fg(blue)], 'blue pieces', []), write('...'),nl,
	write('The player who placed towers is now the P2, he should play in second with '), ansi_format([bold,fg(red)], 'red pieces', []), write('...'),
	novaLinha(4),
	esperaPorEnter,
	comecaJogo(Tabuleiro).
	
informaNumeroJogador(Tabuleiro, 2) :-
	limpaEcra,
	write('***************************\n'),
	write('*         New Game        *\n'),
	write('***************************'),
	novaLinha(4),
	write('The player who placed towers is now the P1, he should play first with '), ansi_format([bold,fg(blue)], 'blue pieces', []), write('...'),nl,
	write('The player who picked a side is now the P2, he should play second with '), ansi_format([bold,fg(red)], 'red pieces', []), write('...'),
	novaLinha(4),
	esperaPorEnter,
	comecaJogo(Tabuleiro).
	
	
%+++++++++++++++++++++++++++++ Jogo ++++++++++++++++++++++++++++++++%

	
jogo(_, _, _, _, _, 4, _) :-
	menuFimJogo(1).
	
jogo(_, _, _, _, _, _, 4) :-
	menuFimJogo(2).
	
jogo(Tabuleiro, Jogador, Passou, P1Passou, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('*********************************\n'),
	write('*                               *\n'),
	write('*             Syrtis            *\n'),
	write('*                               *\n'),
	write('*********************************'),
	novaLinha(4),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	imprimePassagens(P1Passou, P2Passou),
	imprimeAfunda(P1Afundou, P2Afundou),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Wich move do you want to do?'),
	novaLinha(4),
	write('1 - Pass\n2 - Move Tower\n3 - Sink Slot\n4 - Move Slot\n'),
	novaLinha(2),
	obtemNumero(Escolha, 1, 3),
	executaJogada(Tabuleiro, Jogador, Escolha, Passou, P1Passou, P2Passou, P1Afundou, P2Afundou).
	
	
executaJogada(_, _, _, _, 4, _, _, _) :-
	menuFimJogo(2).
	
executaJogada(_, _, _, _, _, 4, _, _) :-
	menuFimJogo(1).
	
executaJogada(Tabuleiro, 1, 1, 0, P1Passou, _, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*        You passed       *\n'),
	write('***************************'),
	novaLinha(4),
	write('Now is\n'),
	imprimeJogador(2),
	novaLinha(2),
	esperaPorEnter,
	X is P1Passou + 1,
	jogo(Tabuleiro, 2, 1, X, 0, P1Afundou, P2Afundou).
	

executaJogada(Tabuleiro, 2, 1, 0, _, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*        You passed       *\n'),
	write('***************************'),
	novaLinha(4),
	write('Now is\n'),
	imprimeJogador(1),
	novaLinha(2),
	esperaPorEnter,
	X is P2Passou + 1,
	jogo(Tabuleiro, 1, 1, 0, X, P1Afundou, P2Afundou).
	
executaJogada( _, _, 1, 1, _, _,P1Afundou, P2Afundou) :-
	P1Afundou > P2Afundou,
	limpaEcra,
	write('***************************\n'),
	write('*         Game Over       *\n'),
	write('***************************'),
	novaLinha(4),
	write('The following player won: '),nl,
	imprimeJogador(1),
	novaLinha(4),
	write('He sinked more slots consecutively recently after the two players pass consecutively!!\n'),
	novaLinha(3).
	
executaJogada( _, _, 1, 1, _, _,P1Afundou, P2Afundou) :-
	P1Afundou < P2Afundou,
	limpaEcra,
	write('***************************\n'),
	write('*         Game Over       *\n'),
	write('***************************'),
	novaLinha(4),
	write('The following player won: '),nl,
	imprimeJogador(2),
	novaLinha(4),
	write('He sinked more slots consecutively recently after the two players pass consecutively!\n'),
	novaLinha(3).
	
	

executaJogada( _, _, 1, 1, _, _,P1Afundou, P2Afundou) :-
	P1Afundou == P2Afundou,
	limpaEcra,
	write('***************************\n'),
	write('*         Game Over       *\n'),
	write('***************************'),
	novaLinha(4),
	write('The following player won: '),nl,
	imprimeJogador(1),
	novaLinha(4),
	write('He played first after the two players passed consecutively and no one had sink a tile!\n'),
	novaLinha(3).
	
	
executaJogada(Tabuleiro, Jogador, 2, _, P1Passou, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*       Move a tower      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Pick the tower to be moved'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(X, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(Y, 0, YLimite),
	verificaTorre(Tabuleiro, Jogador, X, Y, XLimite, YLimite, P1Passou, P2Passou, P1Afundou, P2Afundou).
	
	
executaJogada(Tabuleiro, Jogador, 3, _, P1Passou, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*        Sink a slot      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Pick the slot to be sink'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(X, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(Y, 0, YLimite),
	afundaCasa(Tabuleiro, Jogador, X, Y, XLimite, YLimite,  P1Passou, P2Passou, P1Afundou, P2Afundou).
	

executaJogada(Tabuleiro, Jogador, 4, _, P1Passou, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*        Move a slot      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Pick the slot to be moved'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(X, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(Y, 0, YLimite),
	verificaCasa(Tabuleiro, Jogador, X, Y, XLimite, YLimite, P1Passou, P2Passou, P1Afundou, P2Afundou).
	


menuMoveTorre(Tabuleiro, Jogador, X, Y, P1Passou, P2Passou, P1Afundou, P2Afundou) :-
	limpaEcra,
	write('***************************\n'),
	write('*       Move a tower      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Tower -> '), imprimeTorreJogador(Jogador), write(' '), write([X | Y]),
	novaLinha(2),
	write('Where do you want to place this tower?'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(XFinal, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(YFinal, 0, YLimite),
	novaLinha(3),
	write('Checking if it is a valid move, wait a second...'),
	novaLinha(3),
	moveTorre(Tabuleiro, Jogador, X, Y, XFinal, YFinal, XLimite, YLimite, P1Passou, P2Passou, P1Afundou, P2Afundou).
	
menuMoveCasa(Tabuleiro, Jogador, X, Y, _, _, _, _) :-
	limpaEcra,
	write('***************************\n'),
	write('*       Move a slot       *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	write('Turn:\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Slot Position -> '), write([X | Y]),
	novaLinha(2),
	write('Where do you want to place this slot?'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(_, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(_, 0, YLimite),
	novaLinha(3),
	write('Checking if it is a valid move, wait a second...'),
	novaLinha(3).
	
	
	
	
moveTorreAviso :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('You picked a slot which is not occupied or you picked a tower from your opponent!\n'),
	novaLinha(2),
	write('Play again.'),
	novaLinha(3),
	esperaPorEnter.
	
moveTorreFinalAviso :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('The destination position must form an island with the initial position!\n'),
	novaLinha(2),
	write('Pick a move again.'),
	novaLinha(3),
	esperaPorEnter.
	
	
afundaCasaFinalAviso :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('You must pick an empty slot adjacent to one of your towers!\n'),
	novaLinha(1),
	write('In the end of your move all tiles must be connected...'),
	novaLinha(2),
	write('Please play again.'),
	novaLinha(3),
	esperaPorEnter.
	
	
moveCasaAviso :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('You picked a slot which is not occupied by one of your towers!\n'),
	novaLinha(2),
	write('Play again.'),
	novaLinha(3),
	esperaPorEnter.
	
	
	
menuFimJogo(Jogador) :-
	limpaEcra,
	write('***************************\n'),
	write('*        Game Over        *\n'),
	write('***************************'),
	novaLinha(4),
	write('The winner is :'), novaLinha(2),
	imprimeJogador(Jogador),
	novaLinha(3).
	
	
	
