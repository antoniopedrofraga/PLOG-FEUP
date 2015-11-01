:- include('Interface.pl').
:- include('Utilitarios.pl').
:- include('Menus.pl').


%--------------------------------%
%--------Syrtis em ProLog--------%
%--------------------------------%
%------- escreva syrtis. --------%
%---- na consola para correr ----%
%--------------------------------%
%--------------------------------%

syrtis :-
	limpaEcra,
	menuPrincipal.

	
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


%++++++++++++++++++++++ Colocar Torres ++++++++++++++++++++++%


colocaTorre(Tabuleiro, Tabuleiro2, X, Y, [Torre | Resto], N) :-
		colocaTorre(Tabuleiro, Tabuleiro2, 0, 0, X, Y, Torre),
		N1 is N + 1,
		menuJogo(Tabuleiro2, Resto, N1).

colocaTorre(Tabuleiro, _, _, _, Torres, N) :-
		menuJogoAviso(Tabuleiro, Torres, N).


		
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
	atribuirTorre(H, H2, Torre),
	X1 is X + 1,
	colocaTorreEmLinha(T, T2, X1, XLimite, Torre).
	
	
colocaTorreEmLinha([H | T], [H2 | T2], X, XLimite, Torre) :-
	X < 7,
	X \= XLimite,
	X1 is X + 1,
	H2 = H,
	colocaTorreEmLinha(T, T2, X1, XLimite, Torre).
	
colocaTorreEmLinha(_, _, 7, _, _).


atribuirTorre([o-azul | _], [H2 | T2], torre-o-azul) :-
	H2 = o-azul,
	T2 = torre-o-azul.
	
	
atribuirTorre([quadrado-azul | vazio], [H2 | T2], torre-quadrado-azul) :-
	H2 = quadrado-azul,
	T2 = torre-quadrado-azul.
	
	
atribuirTorre([o-vermelho | vazio], [H2 | T2], torre-o-vermelho) :-
	H2 = o-vermelho,
	T2 = torre-o-vermelho.
	
	
atribuirTorre([quadrado-vermelho | vazio], [H2 | T2], torre-quadrado-vermelho) :-
	H2 = quadrado-vermelho,
	T2 = torre-quadrado-vermelho.
	
atribuirTorre( _, _, _) :- 
	fail.



	