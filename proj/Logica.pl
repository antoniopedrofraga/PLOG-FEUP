

%-------------------------------%
%-------------------------------%
%--------Logica de jogo---------%
%-------------------------------%
%-------------------------------%


comecaJogo(Tabuleiro) :-
	Jogador is 1,
	jogo(Tabuleiro, Jogador).
	
%-------------------------------%
%-------------------------------%
%------Predicados relativos-----%
%----------a jogadores----------%
%-------------------------------%
%-------------------------------%


trocaJogador(1, NovoJogador) :-
	NovoJogador = 2.
	
trocaJogador(2, NovoJogador) :-
	NovoJogador = 1.


%-------------------------------%
%-------------------------------%
%------Predicados relativos-----%
%-----------a jogadas-----------%
%-------------------------------%
%-------------------------------%

	
existemCasasAdjacentes(Tabuleiro, Jogador, Px, Py, Px2, Py2, XLimite, YLimite) :-
	PxMais is Px + 1,
	PxMenos is Px - 1,
	PyMais is Py + 1,
	PyMenos is Py - 1,
	Px2Mais is Px2 + 1,
	Px2Menos is Px2 - 1,
	Py2Mais is Py2 + 1,
	Py2Menos is Py2 - 1,
	((verificaCasasAdjacentes(Tabuleiro, Jogador, PxMais, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, PxMenos, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, PyMais, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, PyMenos, XLimite, YLimite));
	(verificaCasasAdjacentes(Tabuleiro, Jogador, Px2Mais, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px2Menos, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, Py2Mais, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, Py2Menos, XLimite, YLimite))).


verificaCasasAdjacentes(Tabuleiro, 1, Px, Py, XLimite, YLimite) :-
	Px < XLimite, Px >= 0, Py < YLimite, Py >= 0,
	obtemCasaVazia(Tabuleiro, Casa, Px, Py, XLimite, YLimite),
	(Casa == o-vermelho ; Casa == o-azul ; Casa == quadrado-azul).
	
verificaCasasAdjacentes(Tabuleiro, 2, Px, Py, XLimite, YLimite) :-
	Px < XLimite, Px >= 0, Py < YLimite, Py >= 0,
	obtemCasaVazia(Tabuleiro, Casa, Px, Py, XLimite, YLimite),
	(Casa == o-vermelho ; Casa == quadrado-azul ; Casa == quadrado-vermelho).
	
%+++++++++++++++++ Verificar se é possível afundar casas ++++++++++++++++++%

jogadasAfundaCasa(Tabuleiro, Jogador, Px, Py, Px2, Py2, XLimite, YLimite) :-
	PxMais is Px + 1,
	PxMenos is Px - 1,
	PyMais is Py + 1,
	PyMenos is Py - 1,
	Px2Mais is Px2 + 1,
	Px2Menos is Px2 - 1,
	Py2Mais is Py2 + 1,
	Py2Menos is Py2 - 1,
	((verificaAfundaCasa(Tabuleiro, Jogador, PxMais, Py, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, PxMenos, Py, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, Px, PyMais, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, Px, PyMenos, XLimite, YLimite));
	(verificaAfundaCasa(Tabuleiro, Jogador, Px2Mais, Py, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, Px2Menos, Py, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, Px, Py2Mais, XLimite, YLimite);
	verificaAfundaCasa(Tabuleiro, Jogador, Px, Py2Menos, XLimite, YLimite))).
	
	
jogadasAfundaCasa(_, _, _, _, _, _, _, _, _) :-
	write('Falhou').


verificaAfundaCasa(Tabuleiro, _, Px, Py, XLimite, YLimite) :-
	Px < XLimite, Px >= 0, Py < YLimite, Py >= 0,
	obtemCasaVazia(Tabuleiro, Casa, Px, Py, XLimite, YLimite),
	(Casa == o-vermelho ; Casa == quadrado-azul ; Casa == quadrado-vermelho; Casa == o-azul).

	
%+++++++++++++++ Posicao das torres +++++++++++++++%

posicoesTorre(Tabuleiro, 1, Px, Py, XLimite, YLimite, NTorre) :-
	posicoesTorre(Tabuleiro, torre-o-azul, Px, Py, 0, XLimite, YLimite, 1, NTorre).
	
posicoesTorre(Tabuleiro, 2, Px, Py, XLimite, YLimite, NTorre) :-
	posicoesTorre(Tabuleiro, torre-quadrado-vermelho, Px, Py, 0, XLimite, YLimite, 1, NTorre).

	
posicoesTorre([H | T], Torre, Px, Py, Y, XLimite, YLimite,N, NTorre) :-
	Y < YLimite,
	posicoesTorreLinha(H, Torre, Px, 0, XLimite, N, NTorre),
	atribuiValorY([H | T], Torre, Px, Py, Y, XLimite, YLimite,N, NTorre).

posicoesTorre([_ | T], Torre, Px, Py, Y, XLimite, YLimite, N, NTorre) :-
	Y < YLimite,
	Y1 is Y + 1,
	posicoesTorre(T, Torre, Px, Py, Y1, XLimite, YLimite, N, NTorre).
	
posicoesTorre(_, _, _, _, _, _, _, _, _).

posicoesTorreLinha([H | _], Torre, Px, X, XLimite, N, N) :-
	X < XLimite,
	averiguarTorre(H, Torre),
	Px is X.

posicoesTorreLinha([H | T], Torre, Px, X, XLimite, N, NTorre) :-
	X < XLimite,
	X1 is X + 1,
	averiguarTorre(H, Torre),
	N1 is N + 1,
	posicoesTorreLinha(T, Torre, Px, X1, XLimite, N1, NTorre).
	
posicoesTorreLinha([_ | T], Torre, Px, X, XLimite, N, NTorre) :-
	X < XLimite,
	X1 is X + 1,
	posicoesTorreLinha(T, Torre, Px, X1, XLimite, N, NTorre).

posicoesTorreLinha( _, _, _, _, _, 2, 2).

atribuiValorY(_, _, Px, Py, Y, _, _, _, _) :-
	integer(Px),
	Py is Y.

atribuiValorY([_ | T], Torre, Px, Py, Y, XLimite, YLimite, _, _) :-
	Y1 is Y + 1,
	posicoesTorre(T, Torre, Px, Py, Y1, XLimite, YLimite, 1, 1).

averiguarTorre([_ | T], Torre) :-
	T == Torre.

	
%-------------------------------%
%-------------------------------%
%-----Predicados para criar-----%
%----------tabuleiro------------%
%-------------------------------%
%-------------------------------%

criaTabuleiroAleatorio(Tabuleiro2) :- B = _, criaTabuleiro(B, 0, 7), colocaPosicoes(B, Tabuleiro2).

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
	H = [ vazio | vazio],
	criaLista(T, X1, S).
	
%------------------------------%
%---Predicados para colocar----%
%--------casas / torres--------%
%---------no tabuleiro---------%
%------------------------------%

%+++++++++++++++++ Colocar casas ++++++++++++++++%

colocaPosicoes(Tabuleiro, TabuleiroFinal) :-
	Posicoes = [ [2 , 3] , [4 , 3], [1 , 3], [5, 3], [0, 3], [6, 3], [0, 2], [6, 4], [1, 2], [5, 4], [2, 2], [4, 4], [3, 2], [3, 4], [4, 2], [2, 4], [5, 2], [1, 4], [6, 2], [0, 4],
[1, 5], [5, 1], [4, 1], [2, 5], [3, 1], [3, 5], [2, 1], [4, 5], [1, 1], [5, 5], [2, 0], [4, 6], [3, 0], [3, 6], [4, 0], [2, 6] ],
	colocaPosicoes(Tabuleiro, TabuleiroFinal ,Posicoes, 0).

colocaPosicoes(Tabuleiro, TabuleiroFinal, [Cabeca | [Cabeca2 | _ ]], 34) :-
	Casa = _,
	CasaOposta = _,
	NumeroRandom = _,
	random_between(1, 4, NumeroRandom),
	casaAleatoria(Casa, CasaOposta, NumeroRandom),
	Tabuleiro2 = _,
	colocaCasa(Tabuleiro, Tabuleiro2, Cabeca, Casa),
	colocaCasa(Tabuleiro2, TabuleiroFinal, Cabeca2, CasaOposta).
	
colocaPosicoes(Tabuleiro, TabuleiroFinal, [Cabeca | [Cabeca2 | Cauda ]], N) :-
	N1 is N + 2,
	Casa = _,
	CasaOposta = _,
	NumeroRandom = _,
	random_between(1, 4, NumeroRandom),
	casaAleatoria(Casa, CasaOposta, NumeroRandom),
	Tabuleiro2 = _,
	colocaCasa(Tabuleiro, Tabuleiro2, Cabeca, Casa),
	Tabuleiro3 = _,
	colocaCasa(Tabuleiro2, Tabuleiro3, Cabeca2, CasaOposta),
	colocaPosicoes(Tabuleiro3, TabuleiroFinal, Cauda, N1).
	
casaAleatoria(Casa, CasaOposta, 1) :-
	Casa = o-vermelho,
	CasaOposta = quadrado-azul.
	
casaAleatoria(Casa, CasaOposta, 2) :-
	Casa = o-azul,
	CasaOposta = quadrado-vermelho.

casaAleatoria(Casa, CasaOposta, 3) :-
	Casa = quadrado-vermelho,
	CasaOposta = o-azul.
	
casaAleatoria(Casa, CasaOposta, 4) :-
	Casa = quadrado-azul,
	CasaOposta = o-vermelho.
		
colocaCasa(Tabuleiro, Tabuleiro2, [X | Y], Casa) :-
	colocaCasa(Tabuleiro, Tabuleiro2, X, Y, Casa).

colocaCasa(Tabuleiro, TabuleiroResultante,  X, [Y | _], Casa) :-
	colocaCasa(Tabuleiro, TabuleiroResultante,0, 0, X, Y, Casa).

	
colocaCasa([H | T], [H2 | T2], _, Y, XLimite, YLimite, Casa) :-
	Y == YLimite,
	Y1 is Y + 1,
	colocaCasaEmLinha(H, H2, 0, XLimite, Casa),
	colocaCasa(T, T2, 0, Y1, XLimite, YLimite, Casa).	

colocaCasa([H | T], [H2 | T2], _, Y, XLimite, YLimite, Casa) :-
	Y < 7,
	Y1 is Y + 1,
	H2 = H,
	colocaCasa(T, T2, 0, Y1, XLimite, YLimite, Casa).
	
colocaCasa(_, _, _, _, _, _, _).

	
colocaCasaEmLinha([_ | T], [H2 | T2], X, XLimite, Casa) :-
	X == XLimite,
	X1 is X + 1,
	H2 = [Casa | vazio],
	colocaCasaEmLinha(T, T2, X1, XLimite, Casa).

colocaCasaEmLinha([H | T], [H2 | T2], X, XLimite, Casa) :-
	X < 7,
	X1 is X + 1,
	H2 = H,
	colocaCasaEmLinha(T, T2, X1, XLimite, Casa).
	
colocaCasaEmLinha(_, _, _, _, _).

%++++++++++++++++++++++ Afunda Casa ++++++++++++++++++++++%

afundaCasaPosicionada([H | _], Px, Py, X, Y, XLimite, _) :-
	Y == Py,
	afundaCasaPosicionadaLinha(H, Px, X, XLimite).
	
afundaCasaPosicionada([ _ | T], Px, Py, X, Y, XLimite, YLimite) :-
	Y < YLimite,
	Y1 is Y + 1,
	afundaCasaPosicionada(T, Px, Py, X, Y1, XLimite, YLimite).
	
afundaCasaPosicionadaLinha([[H | T]| _], Px, X, _) :-
	Px == X,
	T == vazio,
	H = vazio.
	
afundaCasaPosicionadaLinha([_ | T], Px, X, XLimite) :-
	X < XLimite,
	X1 is X + 1,
	afundaCasaPosicionadaLinha( T, Px, X1, XLimite).
	

%++++++++++++++++++++++ Obter Casas ++++++++++++++++++++++%

obtemCasaVazia(Tabuleiro, Casa, Px, Py, XLimite, YLimite) :-
	Px >= 0, Px < XLimite, Py >= 0, Py < YLimite,
	obtemCasaVazia2(Tabuleiro, Casa, 0, Px, Py, XLimite, YLimite).
	
obtemCasaVazia(_, Casa, Px, Py, XLimite, YLimite) :-
	(Px < 0; Px >= XLimite; Py < 0; Py >= YLimite),
	Casa = vazio.
	
obtemCasaVazia2([H | _], Casa, Y, Px, Py, XLimite, _) :-
	Y == Py,
	obtemCasaVaziaLinha(H, Casa, 0, Px, XLimite).
	
obtemCasaVazia2([_ | T], Casa, Y, Px, Py, XLimite, YLimite) :-
	Y < YLimite,
	Y1 is Y + 1,
	obtemCasaVazia2( T, Casa, Y1, Px, Py, XLimite, YLimite).
	
obtemCasaVaziaLinha([[Casa1 | Peca ]| _], Casa, X, Px, _) :-
	X == Px,
	Peca == vazio,
	Casa = Casa1.

obtemCasaVaziaLinha([_ | T], Casa, X, Px, XLimite) :-
	X < XLimite,
	X1 is X + 1,
	obtemCasaVaziaLinha(T, Casa, X1, Px, XLimite).
	
	
obtemCasa(Tabuleiro, Casa, Px, Py, XLimite, YLimite) :-
	obtemCasa2(Tabuleiro, Casa, 0, Px, Py, XLimite, YLimite).
	
obtemCasa(_, _, _, _, _, _).
	
obtemCasa2([H | _], Casa, Y, Px, Py, XLimite, _) :-
	Y == Py,
	obtemCasaLinha(H, Casa, 0, Px, XLimite).
	
obtemCasa2([_ | T], Casa, Y, Px, Py, XLimite, YLimite) :-
	Y < YLimite,
	Y1 is Y + 1,
	obtemCasa2( T, Casa, Y1, Px, Py, XLimite, YLimite).
	
obtemCasaLinha([[Casa1 | _ ]| _], Casa, X, Px, _) :-
	X == Px,
	Casa = Casa1.

obtemCasaLinha([_ | T], Casa, X, Px, XLimite) :-
	X < XLimite,
	X1 is X + 1,
	obtemCasaLinha(T, Casa, X1, Px, XLimite).
	
	
obtemTorre(Tabuleiro, Casa, Px, Py, XLimite, YLimite) :-
	obtemTorre2(Tabuleiro, Casa, 0, Px, Py, XLimite, YLimite).
	
obtemTorre(_, _, _, _, _, _).
	
obtemTorre2([H | _], Casa, Y, Px, Py, XLimite, _) :-
	Y == Py,
	obtemTorreLinha(H, Casa, 0, Px, XLimite).
	
obtemTorre2([_ | T], Casa, Y, Px, Py, XLimite, YLimite) :-
	Y < YLimite,
	Y1 is Y + 1,
	obtemTorre2( T, Casa, Y1, Px, Py, XLimite, YLimite).
	
obtemTorreLinha([[_ | Torre ]| _], Casa, X, Px, _) :-
	X == Px,
	Casa = Torre.

obtemTorreLinha([_ | T], Casa, X, Px, XLimite) :-
	X < XLimite,
	X1 is X + 1,
	obtemTorreLinha(T, Casa, X1, Px, XLimite).

%+++++++++++++++++++++++++++ Coloca Torres +++++++++++++++++++++++++++%

colocaTorreMovida(Tabuleiro, Tabuleiro2, X, Y, XLimite, YLimite, 1) :-
		colocaTorreMovida(Tabuleiro, Tabuleiro2, 0, 0, X, Y, XLimite, YLimite, torre-o-azul).
		
colocaTorreMovida(Tabuleiro, Tabuleiro2, X, Y, XLimite, YLimite, 2) :-
		colocaTorreMovida(Tabuleiro, Tabuleiro2, 0, 0, X, Y, XLimite, YLimite, torre-quadrado-vermelho).


		
colocaTorreMovida([H | T], [H2 | T2], _, Y, XFinal, YFinal, XLimite, YLimite, Torre) :-
	Y == YFinal,
	colocaTorreMovidaEmLinha(H, H2, 0, XFinal, XLimite, Torre),
	Y1 is Y + 1,
	colocaTorreMovida(T, T2, 0, Y1, XFinal, YFinal, XLimite, YLimite, Torre).	

colocaTorreMovida([H | T], [H2 | T2], _, Y, XFinal, YFinal, XLimite, YLimite, Torre) :-
	Y < YLimite,
	Y1 is Y + 1,
	H2 = H,
	colocaTorreMovida(T, T2, 0, Y1, XFinal, YFinal, XLimite, YLimite, Torre).
	
colocaTorreMovida(_, _, _, _, _, _, _, _, _).

	
colocaTorreMovidaEmLinha([H | T], [H2 | T2], X, XFinal ,XLimite, Torre) :-
	X == XFinal,
	atribuirTorreMovida(H, H2, Torre),
	X1 is X + 1,
	colocaTorreMovidaEmLinha(T, T2, X1, XFinal, XLimite, Torre).
	
	
colocaTorreMovidaEmLinha([H | T], [H2 | T2], X, XFinal, XLimite, Torre) :-
	X < XLimite,
	X1 is X + 1,
	H2 = H,
	colocaTorreMovidaEmLinha(T, T2, X1, XFinal, XLimite, Torre).
	
colocaTorreMovidaEmLinha(_, _, _, _, _, _).

atribuirTorreMovida([Casa | vazio], [H2 | T2], Torre) :-
	H2 = Casa,
	T2 = Torre.
	
atribuirTorreMovida( _, _, _) :-
	fail.

	
%++++++++++++++++++++++ Colocar Torres Iniciais ++++++++++++++++++++++%


colocaTorre(Tabuleiro, X, Y, [Torre | Resto], N) :-
		colocaTorre(Tabuleiro, Tabuleiro2, 0, 0, X, Y, Torre),
		N1 is N + 1,
		escolheTorres(Tabuleiro2, Resto, N1).

colocaTorre(Tabuleiro, _, _, _, Torres, N) :-
		escolheTorresAviso(Tabuleiro, Torres, N).


		
colocaTorre([H | T], [H2 | T2], _, Y, XLimite, YLimite, Torre) :-
	Y == YLimite,
	colocaTorreEmLinha(H, H2, 0, XLimite, Torre),
	Y1 is Y + 1,
	colocaTorre(T, T2, 0, Y1, XLimite, YLimite, Torre).	

colocaTorre([H | T], [H2 | T2], _, Y, XLimite, YLimite, Torre) :-
	Y < 7,
	Y \= YLimite,
	Y1 is Y + 1,
	H2 = H,
	colocaTorre(T, T2, 0, Y1, XLimite, YLimite, Torre).
	
colocaTorre(_, _, _, 7, _, _, _).

	
colocaTorreEmLinha([H | T], [H2 | T2], X, XLimite, Torre) :-
	X == XLimite,
	atribuirTorreInicial(H, H2, Torre),
	X1 is X + 1,
	colocaTorreEmLinha(T, T2, X1, XLimite, Torre).
	
	
colocaTorreEmLinha([H | T], [H2 | T2], X, XLimite, Torre) :-
	X < 7,
	X \= XLimite,
	X1 is X + 1,
	H2 = H,
	colocaTorreEmLinha(T, T2, X1, XLimite, Torre).
	
colocaTorreEmLinha(_, _, 7, _, _).


atribuirTorreInicial([o-azul | vazio], [H2 | T2], torre-o-azul) :-
	H2 = o-azul,
	T2 = torre-o-azul.
			
	
atribuirTorreInicial([quadrado-vermelho | vazio], [H2 | T2], torre-quadrado-vermelho) :-
	H2 = quadrado-vermelho,
	T2 = torre-quadrado-vermelho.
	
atribuirTorreInicial( _, _, _) :- 
	fail.

%++++++++++++++++++++++ Remover torre +++++++++++++++++++%

removeTorre(Tabuleiro, Tabuleiro2,XFinal, YFinal, XLimite, YLimite) :-
	removeTorre(Tabuleiro, Tabuleiro2, 0, 0, XFinal, YFinal,XLimite, YLimite).
	

removeTorre([H | T], [H2 | T2], _, Y, XFinal, YFinal, XLimite, YLimite) :-
	Y == YFinal,
	removeTorreEmLinha(H, H2, 0, XFinal, XLimite),
	Y1 is Y + 1,
	removeTorre(T, T2, 0, Y1, XFinal, YFinal, XLimite, YLimite).	

removeTorre([H | T], [H2 | T2], _, Y, XFinal, YFinal, XLimite, YLimite) :-
	Y < YLimite,
	Y \= YFinal,
	Y1 is Y + 1,
	H2 = H,
	removeTorre(T, T2, 0, Y1, XFinal, YFinal, XLimite, YLimite).
	
removeTorre(_, _, _, _, _, _, _, _).

	
removeTorreEmLinha([[Casa1 | _] | T], [[Casa | Torre] | T2], X, XFinal, XLimite) :-
	X == XFinal,
	Torre = vazio,
	Casa = Casa1,
	X1 is X + 1,
	removeTorreEmLinha(T, T2, X1, XFinal, XLimite).
	
	
removeTorreEmLinha([H | T], [H2 | T2], X, XFinal, XLimite) :-
	X < XLimite,
	X \= XFinal,
	X1 is X + 1,
	H2 = H,
	removeTorreEmLinha(T, T2, X1, XFinal, XLimite).
	
removeTorreEmLinha(_, _, _, _, _).	
	
%++++++++++++++ Verificar posicao de torres +++++++++++++%

verificaTorre(Tabuleiro, Jogador, X, Y, XLimite, YLimite) :-
	posicoesTorre(Tabuleiro, Jogador, Px, Py, XLimite, YLimite, 1),
	posicoesTorre(Tabuleiro, Jogador, Px2, Py2, XLimite, YLimite, 2),
	((X == Px , Y == Py) ; (X == Px2 , Y == Py2)),
	menuMoveTorre(Tabuleiro, Jogador, X, Y).
	
verificaTorre(Tabuleiro, Jogador, _, _, _, _) :-
	moveTorreAviso,
	executaJogada(Tabuleiro, Jogador, 2).
	
moveTorre(Tabuleiro, Jogador, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	obtemTorre(Tabuleiro, Torre, XFinal, YFinal, XLimite, YLimite),
	Torre == vazio,
	existeIlha(Tabuleiro, Jogador, X, Y, XFinal, YFinal, XLimite, YLimite),
	removeTorre(Tabuleiro, Tabuleiro2, X, Y, XLimite, YLimite),
	colocaTorreMovida(Tabuleiro2, Tabuleiro3, XFinal, YFinal, XLimite, YLimite, Jogador),
	trocaJogador(Jogador, Jogador2),
	jogo(Tabuleiro3, Jogador2).
	
	
moveTorre(Tabuleiro, Jogador,_, _, _, _, _, _) :-
	moveTorreFinalAviso,
	jogo(Tabuleiro, Jogador).
	

	
%+++++++++++++++++++++++ Ilhas ++++++++++++++++++++++++++%



existeIlha(Tabuleiro, 1, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	Lista = [ [X , Y] ],
	((verificaPecaCircular(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite));
	(verificaPecaAzul(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite))).
	
	
existeIlha(Tabuleiro, 2, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	Lista = [ [X , Y] ],
	((verificaPecaQuadrada(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite));
	(verificaPecaVermelha(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite))).

%++++++++++++++++++++++ Pecas Circulares ++++++++++++++++++++++++++++%	

verificaPecaCircular(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	X >= 0, X < XLimite, Y >= 0, Y < YLimite, 
	obtemCasa(Tabuleiro, Casa, X, Y, XLimite, YLimite),
	(Casa == o-azul ; Casa == o-vermelho),
	verificaLista(Lista, [X, Y]),
	append(Lista, [[X, Y]], Lista2),
	verificaIgualdadeCircular(Tabuleiro, Lista2, X, Y, XFinal, YFinal, XLimite, YLimite).
	
	
verificaIgualdadeCircular(_, _, X, Y, XFinal, YFinal, _, _) :-
	X == XFinal,
	Y == YFinal.
	
verificaIgualdadeCircular(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	(verificaLista(Lista, [XMais, Y]); verificaLista(Lista, [XMenos, Y]); verificaLista(Lista, [X, YMais]); verificaLista(Lista, [X, YMenos])),
	(verificaPecaCircular(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaCircular(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite)).

%++++++++++++++++++++++++++++++ Pecas Azuis +++++++++++++++++++++++++++++++++++++++%

verificaPecaAzul(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	X >= 0, X < XLimite, Y >= 0, Y < YLimite, 
	obtemCasa(Tabuleiro, Casa, X, Y, XLimite, YLimite),
	(Casa == o-azul ; Casa == quadrado-azul),
	verificaLista(Lista, [X, Y]),
	append(Lista, [[X, Y]], Lista2),
	verificaIgualdadeAzul(Tabuleiro, Lista2, X, Y, XFinal, YFinal, XLimite, YLimite).
	
	
verificaIgualdadeAzul(_, _, X, Y, XFinal, YFinal, _, _) :-
	X == XFinal,
	Y == YFinal.
	
verificaIgualdadeAzul(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	(verificaLista(Lista, [XMais, Y]); verificaLista(Lista, [XMenos, Y]); verificaLista(Lista, [X, YMais]); verificaLista(Lista, [X, YMenos])),
	(verificaPecaAzul(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaAzul(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite)).
	
%++++++++++++++++++++++ Pecas Quadradas ++++++++++++++++++++++++++++%	

verificaPecaQuadrada(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	X >= 0, X < XLimite, Y >= 0, Y < YLimite, 
	obtemCasa(Tabuleiro, Casa, X, Y, XLimite, YLimite),
	(Casa == quadrado-azul ; Casa == quadrado-vermelho),
	verificaLista(Lista, [X, Y]),
	append(Lista, [[X, Y]], Lista2),
	verificaIgualdadeQuadrada(Tabuleiro, Lista2, X, Y, XFinal, YFinal, XLimite, YLimite).
	
	
verificaIgualdadeQuadrada(_, _, X, Y, XFinal, YFinal, _, _) :-
	X == XFinal,
	Y == YFinal.
	
verificaIgualdadeQuadrada(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	(verificaLista(Lista, [XMais, Y]); verificaLista(Lista, [XMenos, Y]); verificaLista(Lista, [X, YMais]); verificaLista(Lista, [X, YMenos])),
	(verificaPecaQuadrada(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaQuadrada(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite)).

%++++++++++++++++++++++++++++++ Pecas Vermelhas +++++++++++++++++++++++++++++++++++++++%

verificaPecaVermelha(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	X >= 0, X < XLimite, Y >= 0, Y < YLimite, 
	obtemCasa(Tabuleiro, Casa, X, Y, XLimite, YLimite),
	(Casa == o-vermelho ; Casa == quadrado-vermelho),
	verificaLista(Lista, [X, Y]),
	append(Lista, [[X, Y]], Lista2),
	verificaIgualdadeVermelha(Tabuleiro, Lista2, X, Y, XFinal, YFinal, XLimite, YLimite).
	
	
verificaIgualdadeVermelha(_, _, X, Y, XFinal, YFinal, _, _) :-
	X == XFinal,
	Y == YFinal.
	
verificaIgualdadeVermelha(Tabuleiro, Lista, X, Y, XFinal, YFinal, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	(verificaLista(Lista, [XMais, Y]); verificaLista(Lista, [XMenos, Y]); verificaLista(Lista, [X, YMais]); verificaLista(Lista, [X, YMenos])),
	(verificaPecaVermelha(Tabuleiro, Lista, XMais, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, XMenos, Y, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, X, YMais, XFinal, YFinal, XLimite, YLimite);
	verificaPecaVermelha(Tabuleiro, Lista, X, YMenos, XFinal, YFinal, XLimite, YLimite)).
	
	
verificaLista([], _).
	
verificaLista([H | T], Par) :-
	H \= Par,
	verificaLista( T, Par).
	
	
	
%++++++++++++++++++++++++ Afunda Casa ++++++++++++++++++++++++++%	
	
afundaCasa(Tabuleiro, Jogador, X, Y, XLimite, YLimite) :-
	posicoesTorre(Tabuleiro, Jogador, Px, Py, XLimite, YLimite, 1),
	posicoesTorre(Tabuleiro, Jogador, Px2, Py2, XLimite, YLimite, 2),
	verificaAdjacencia(Tabuleiro, Jogador,Px, Py, Px2, Py2, X, Y, XLimite, YLimite).
	
afundaCasa(Tabuleiro, Jogador, _, _, _, _) :-
	afundaCasaFinalAviso,
	jogo(Tabuleiro, Jogador).
	
	

verificaAdjacencia(Tabuleiro, _,Px, Py, Px2, Py2, X, Y, XLimite, YLimite) :-
	PxMais is Px + 1,
	PxMenos is Px - 1,
	PyMais is Py + 1,
	PyMenos is Py - 1,
	Px2Mais is Px2 + 1,
	Px2Menos is Px2 - 1,
	Py2Mais is Py2 + 1,
	Py2Menos is Py2 - 1,
    ((PxMais == X, Py == Y); (PxMenos == X, Py == Y); (Px == X, PyMais == Y); (Px == X, PyMenos == Y);
	(Px2Mais == X, Py2 == Y); (Px2Menos == X, Py2 == Y); (Px2 == X, Py2Mais == Y); (Px2 == X, Py2Menos == Y)),
	obtemCasaVazia(Tabuleiro, Casa, X, Y, XLimite, YLimite),
	(Casa == o-vermelho ; Casa == o-azul ; Casa == quadrado-azul ; Casa == quadrado-vermelho),
	verificaVizinhanca(Tabuleiro, X, Y, XLimite, YLimite),
	verificaTabuleiroLigado(Tabuleiro, XLimite, YLimite).
	
verificaAdjacencia(Tabuleiro, Jogador,_, _, _, _, _, _, _, _) :-
	afundaCasaFinalAviso,
	jogo(Tabuleiro, Jogador).
	
verificaVizinhanca(Tabuleiro, X, Y, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	obtemCasaVazia(Tabuleiro, Casa0, XMais, Y, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa1, XMenos, Y, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa2, X, YMais, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa3, X, YMenos, XLimite, YLimite),
	trace,
	(Casa0 == vazio; Casa1 == vazio; Casa2 == vazio; Casa3 == vazio).
	
verificaTabuleiroLigado(Tabuleiro, XLimite, YLimite) :-
	verificaTabuleiroLigado(Tabuleiro, 0, XLimite, YLimite).
	
	
	
verificaTabuleiroLigado(Tabuleiro, Y, XLimite, YLimite) :-
	Y < YLimite,
	obtemLinhaTabuleiroLigado(Tabuleiro, 0, Y, XLimite, YLimite),
	Y1 is Y + 1,
	verificaTabuleiroLigado(Tabuleiro, Y1, XLimite, YLimite).

verificaTabuleiroLigado(_, Y, _, YLimite) :-
	Y >= YLimite.
	

obtemLinhaTabuleiroLigado(Tabuleiro, X, Y, XLimite, YLimite) :-
	X < XLimite,
	verificaVizinhancaLigada(Tabuleiro, X, Y, XLimite, YLimite),
	X1 is X + 1,
	obtemLinhaTabuleiroLigado(Tabuleiro, X1, Y, XLimite, YLimite).
	
obtemLinhaTabuleiroLigado(_, X, _, XLimite, _) :-
	X >= XLimite.
	

verificaVizinhancaLigada(Tabuleiro, X, Y, XLimite, YLimite) :-
	XMais is X + 1,
	XMenos is X - 1,
	YMais is Y + 1,
	YMenos is Y - 1,
	obtemCasaVazia(Tabuleiro, Casa0, XMais, Y, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa1, XMenos, Y, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa2, X, YMais, XLimite, YLimite),
	obtemCasaVazia(Tabuleiro, Casa3, X, YMenos, XLimite, YLimite),
	(Casa0 \= vazio; Casa1 \= vazio; Casa2 \= vazio; Casa3 \= vazio).
	
