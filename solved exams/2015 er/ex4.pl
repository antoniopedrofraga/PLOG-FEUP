:- use_module(library(clpfd)).
:- use_module(library(lists)).


aux1(Board, [P1, P2 | T], StopsSum, N) :-
	(abs(P1 - P2) mod N #= 0) #\/ ((P1 - 1) div N #= (P2 - 1) div N),
   	aux1([P2 | T], N).

path(BoardValues,NPos,Path,Value) :-
	length(Path, NPos),
	length(BoardValues, TilesNumber),
	domain(Path, 1, TilesNumber),
	N is sqrt(TilesNumber),
	aux1(BoardValues, Path, StopsSum, SideSize),
	labeling([maximize(StopsSum)], Path),
	sumlist(Path, Value).

