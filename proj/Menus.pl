

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
	Coluna = _,
	obtemNumeroDeTabuleiro(Coluna),
	novaLinha(3),
	write('Write a line number : '),
	Linha = _,
	obtemNumeroDeTabuleiro(Linha),
	novaLinha(3),
	Tabuleiro2 = _,
	colocaTorre(Tabuleiro, Tabuleiro2, Coluna, Linha, [Torre1 | Resto], N).
	
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
	novaLinha(2),
	jogadasValidas(Tabuleiro, Jogador, Jogadas),
	novaLinha(3),
	write(Jogadas).
