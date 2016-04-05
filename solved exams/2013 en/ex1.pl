% prof_risco(Pessoa,Profissão)
prof_risco(rui,professor).
prof_risco(to,bombeiro).
prof_risco(marta,bombeiro).
prof_risco(hugo,fuzileiro).

% fuma_muito(Pessoa)
fuma_muito(sofia).
fuma_muito(rui).
fuma_muito(marta).
fuma_muito(pedro).

% dorme(Pessoa,Horas)
dorme(pedro,5).
dorme(joao,4).
dorme(marta,5).
dorme(sofia,8).
dorme(hugo,4).


dorme_pouco(P) :-
	dorme(P, H),
	H < 6.

morre_cedo(P) :-
	fuma_muito(P) ; prof_risco(P,_).

desgracado(P) :-
	\+ (prof_risco(P, _), prof_risco(P2, _), P == P2).
