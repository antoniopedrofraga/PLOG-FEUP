:-use_module(library(clpfd)).

distributeRestriction1([_]).
distributeRestriction1([VarsH,VarsH2 | VarsT]) :-
	VarsH #\= VarsH2,
	distributeRestriction1([VarsH2 | VarsT]).

distributeDomain([], []).
distributeDomain([ListH | ListT], [VarsH| VarsT]) :-
	list_to_fdset(ListH, Set),
	in_set(VarsH, Set),
	distributeDomain(ListT, VarsT).

distribute(List, Vars) :-
	length(List, N),
	length(Vars, N),
	distributeDomain(List, Vars),
	distributeRestriction1(Vars),
	labeling( [], Vars).


distributeRestriction2(0, _, _, _).
distributeRestriction2(NBags, Vars, MinObj, MaxObj) :-
	NBags > 0,
	count(NBags,Vars,#=,Count),
	(Count #= 0 #\/ (Count #=< MaxObj #/\ Count #>= MinObj)),
	NBags1 is NBags - 1,
	distributeRestriction2(NBags1, Vars, MinObj, MaxObj).

distribute(NBags, List, MinObj, MaxObj, Vars) :-
	length(List, N),
	length(Vars, N),
	distributeDomain(List, Vars),
	distributeRestriction2(NBags, Vars, MinObj, MaxObj),
	labeling([], Vars).