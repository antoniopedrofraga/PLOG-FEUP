

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
%-----------a jogadas-----------%
%-------------------------------%
%-------------------------------%

jogadasValidas(Tabuleiro, Jogador, Jogadas) :-
	Jogadas = [ passar | Cauda ],
	jogadasMoveTorre(Tabuleiro, Jogador, Cauda).
	
jogadasMoveTorre(Tabuleiro, Jogador, Jogadas) :-
	existemCasasAdjacentes(Tabuleiro, Jogador, Jogadas).

jogadasMoveTorre(_, _, _).


existemCasasAdjacentes(Tabuleiro, Jogador, Jogadas) :-
	tamanhoTabuleiro(Tabuleiro, XLimite, YLimite),
	posicoesTorre(Tabuleiro, Jogador, Px, Py, XLimite, YLimite, 1),
	posicoesTorre(Tabuleiro, Jogador, Px2, Py2, XLimite, YLimite, 2),
	existemCasasAdjacentes2(Tabuleiro, Jogador, Jogadas, Px, Py, Px2, Py2, XLimite, YLimite).
	
existemCasasAdjacentes2(Tabuleiro, Jogador, [H | Jogadas], Px, Py, Px2, Py2, XLimite, YLimite) :-
	(verificaCasasAdjacentes(Tabuleiro, Jogador, Px + 1, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px - 1, Py, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, Py + 1, XLimite, YLimite);
	verificaCasasAdjacentes(Tabuleiro, Jogador, Px, Py - 1, XLimite, YLimite)),
	H = mover.

existemCasasAdjacentes2(Tabuleiro, Jogador, Jogadas, Px, Py, Px2, Py2, XLimite, YLimite) :-
	write('Falhou'), nl.

verificaCasasAdjacentes(Tabuleiro, 1, Px, Py, XLimite, YLimite) :-
	Px =< XLimite, Px >= 0, Py =< YLimite, Py >= 0,
	obtemCasa(Tabuleiro, Casa, Px, Py),
	(Casa == o-vermelho ; Casa == o-azul ; Casa == quadrado-azul).
	
verificaCasasAdjacentes(Tabuleiro, 2, Px, Py, XLimite, YLimite) :-
	Px =< XLimite, Px >= 0, Py =< YLimite, Py >= 0,
	obtemCasa(Tabuleiro, Casa, Px, Py),
	(Casa == o-vermelho ; Casa == quadrado-azul ; Casa == quadrado-vermelho).






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


	
tamanhoTabuleiro([H | T], XLimite, YLimite) :-
		tamanhoLista(H, XLimite),
		tamanhoLista(T, Tamanho),
		YLimite is Tamanho + 1.
	
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

%++++++++++++++++++++++ Obter Casas ++++++++++++++++++++++%

obtemCasa(Tabuleiro, Casa, Px, Py) :-
	obtemCasa2(Tabuleiro, Casa, 0, Px, Py).
	
obtemCasa2([H | _], Casa, Y, Px, Py) :-
	Y == Py,
	obtemCasaLinha(H, Casa, 0, Px).
	
obtemCasa2([_ | T], Casa, X, Y, Px, Py) :-
	Y1 is Y + 1,
	obtemCasa2( T, Casa, X, Y1, Px, Py).
	
obtemCasaLinha([[Casa1 | _ ]| _], Casa, X, Px) :-
	X == Px,
	Casa = Casa1.

obtemCasaLinha([_ | T], Casa, X, Px) :-
	X1 is X + 1,
	obtemCasaLinha(T, Casa, X1, Px).

	
%++++++++++++++++++++++ Colocar Torres ++++++++++++++++++++++%


colocaTorre(Tabuleiro, Tabuleiro2, X, Y, [Torre | Resto], N) :-
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