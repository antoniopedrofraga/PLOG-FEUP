

%-------------------------------%
%-------------------------------%
%-------Interface de jogo-------%
%-------------------------------%
%-------------------------------%



menuPrincipal :-
	novaLinha(2),
	write('*** Syrtis in Prolog ***\n\nBy Pedro Fraga and Carolina Moreira'), novaLinha(3),
	novaLinha(3),
	write('***************************\n'),
	write('*        Main Menu        *\n'),
	write('***************************'), novaLinha(2),
	write('1 - Play\n2 - Help\n3 - Quit\n\n> '),
	get_single_char(Escolha),
	(
		Escolha = 49 -> menuJogo;
		Escolha = 50 -> menuAjuda;
		Escolha = 51;
		novaLinha(1),
		limpaEcra,
		write(Escolha), nl,
		write('ERROR : invalid input...'), novaLinha(1),
		menuPrincipal
	).

menuAjuda :- limpaEcra, 
			write('***************************\n'),
			write('*        Help Menu        *\n'),
			write('***************************'),
			novaLinha(4),
			write('Under construction...'),
			novaLinha(4),
			esperaPorEnter, menuPrincipal, !.

menuJogo :-
	Tabuleiro = _,
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



jogo(Tabuleiro, Jogador) :-
	limpaEcra,
	write('*********************************\n'),
	write('*                               *\n'),
	write('*             Syrtis            *\n'),
	write('*                               *\n'),
	write('*********************************'),
	novaLinha(4),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Wich move do you want to do?'),
	novaLinha(4),
	write('1 - Pass\n2 - Move Tower\n3 - Sink Slot\n4 - Move Slot\n'),
	novaLinha(2),
	obtemNumero(Escolha, 1, 4),
	executaJogada(Tabuleiro, Jogador, Escolha).
	
executaJogada(Tabuleiro, Jogador, 1) :-
	limpaEcra,
	write('***************************\n'),
	write('*        You passed       *\n'),
	write('***************************'),
	novaLinha(4),
	trocaJogador(Jogador, NovoJogador),
	write('Now is\n'),
	imprimeJogador(Jogador),
	novaLinha(2),
	esperaPorEnter,
	jogo(Tabuleiro, NovoJogador).
	
	
executaJogada(Tabuleiro, Jogador, 2) :-
	limpaEcra,
	write('***************************\n'),
	write('*       Move a tower      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Pick the tower to be moved'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(X, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(Y, 0, YLimite),
	verificaTorre(Tabuleiro, Jogador, X, Y, XLimite, YLimite).
	
	
executaJogada(Tabuleiro, Jogador, 3) :-
	limpaEcra,
	write('***************************\n'),
	write('*        Sink a slot      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
	imprimeJogador(Jogador),
	novaLinha(2),
	write('Pick the slot to be sink'),
	novaLinha(3),
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	write('Write a column number : '),
	obtemNumero(X, 0, XLimite),
	write('Write a line number : '),
	obtemNumero(Y, 0, YLimite),
	afundaCasa(Tabuleiro, Jogador, X, Y, XLimite, YLimite).
	
	

menuMoveTorre(Tabuleiro, Jogador, X, Y) :-
	limpaEcra,
	write('***************************\n'),
	write('*       Move a tower      *\n'),
	write('***************************'),
	novaLinha(3),
	imprimeTabuleiro(Tabuleiro),
	novaLinha(2),
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
	moveTorre(Tabuleiro, Jogador, X, Y, XFinal, YFinal, XLimite, YLimite).
	
	
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
	
	
	
