:-use_module(library(lists)).

nascimento(3,1,data(2016, 1, 21)).
nascimento(31,1,data(1993,03,01)).
nascimento(32,1,data(1993,03,01)).
nascimento(33,3,data(1993,03,03)).
nascimento(34,3,data(1993,03,03)).
nascimento(35,5,data(1993,03,05)).
nascimento(21,1,data(1992,02,01)).
nascimento(22,1,data(1992,02,01)).
nascimento(23,3,data(1992,02,03)).
nascimento(24,3,data(1992,02,03)).
nascimento(25,5,data(1992,02,05)).
nascimento(11,1,data(1991,01,01)).
nascimento(12,1,data(1991,01,01)).
nascimento(13,3,data(1991,01,03)).
nascimento(14,3,data(1991,01,03)).
nascimento(15,5,data(1991,01,05)).

obito(3,data(1992,12,03)).
obito(2,data(1991,12,02)).
obito(4,data(1993,12,03)).
obito(1,data(1990,12,01)).

casamento(1,2,data(2,2,2013)).
casamento(4,5,data(3,2,2013)).
casamento(3,6,data(1990,01,01)).

divorcio(1,2,data(3,2,2013)).
divorcio(3,4,data(1991,01,01)).

imigrou(1,data(1990,01,01)).
imigrou(2,data(1990,01,01)).
imigrou(3,data(1990,01,03)).
imigrou(4,data(1990,01,03)).
imigrou(5,data(1990,01,05)).


quantidade_de_registos_de_nascimento(N) :-
	findall(_, nascimento(_, _, _), Lista),
	length(Lista, N).

primeiro_nativo(IdPessoa) :-
	findall(Data-IdPessoa,  nascimento(IdPessoa, _, Data), Lista),
	sort(Lista, Lista2),
	nth0(0, Lista2, Data-IdPessoa).


populacao_total(Data,QtPessoas) :-
	findall(IdPessoa, ((nascimento(IdPessoa, _, Data1); imigrou(IdPessoa, Data1)), (\+ obito(IdPessoa, _); (obito(IdPessoa, Data2), data_maior(Data2, Data))), data_maior(Data, Data1)), List),
	write(List),
	length(List, QtPessoas).

data_maior(Data1, Data2) :-
	L1 = [Data1, Data2],
	sort(L1, L2),
	nth0(1, L2, Data1).

 maes_solteiras(ListaIds) :-
 	findall(IdPessoa, (nascimento(_, IdPessoa, data(Year, _, _)), (2016 - Year < 18), (\+ (casamento(IdPessoa, _, _) ; casamento(_, IdPessoa, _)) ; (divorcio(IdPessoa, _, _); divorcio(_, IdPessoa, _)))), ListaIds).



