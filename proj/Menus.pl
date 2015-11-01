

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
	Torres = [torre-o-vermelho, torre-o-azul, torre-quadrado-vermelho, torre-quadrado-azul],
	menuJogo(Tabuleiro, Torres, 0).
			
menuJogo(_, _, 4).

menuJogo(Tabuleiro, [Torre1 | Resto], N) :-
	limpaEcra,
	criaTabuleiroAleatorio(Tabuleiro),
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
	
menuJogoAviso(Tabuleiro, Torres, N) :-
	limpaEcra,
	write('***************************\n'),
	write('*          ERROR          *\n'),
	write('***************************'),
	novaLinha(4),
	write('You cant replace a tower or place a tower where there is no slot'),
	novaLinha(2),
	write('Pick a slot with the same shape and colour'),
	novaLinha(3),
	esperaPorEnter,
	menuJogo(Tabuleiro, Torres, N).
