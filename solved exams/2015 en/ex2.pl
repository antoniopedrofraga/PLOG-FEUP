:-use_module(library(lists)).	

course(eic0026, 'Planilhas Orientadas a Gamers', 'PLOG', 3, 1, 5).
course(eic0084, 'Luau de Animação  Interação Gestual', 'LAIG', 3, 1, 7).
course(eic0024, 'Estimativas de Sofrimento', 'ESOF', 3, 1, 6).
course(eic0032, 'Realidade Comatosa', 'RCOM', 3, 1, 6).
course(eic0112, 'Lágrimas e Tremores para a Web', 'LTW', 3, 1, 6).

student(2012012270, 'Artemisa Antonieta', 2012).
student(2012490160, 'Bernardete Bernardes', 2012).
student(2012687310, 'Cristalina Coronado', 2012).
student(2012380501, 'Demétrio Dourolindo', 2012).
student(2012380401, 'Eleutério Elisandro', 2012).
student(2012746621, 'Felismina Felizardo', 2012).
student(2012012271, 'Teste', 2000).

score(2012012270, eic0026, 2014, 20).
score(2012012270, eic0084, 2014, 16).
score(2012012270, eic0024, 2014, 17).
score(2012012270, eic0032, 2014, 12).
score(2012012270, eic0112, 2014, 18).
score(2012012271, eic0112, 2005, 18).
score(2012012271, eic0112, 2014, 18).
score(2012687310, eic0032, 2014, missed).
score(2012490160, eic0026, 2014, missed).
score(2012490160, eic0084, 2014, 7).
score(2012490160, eic0024, 2014, 10).
score(2012490160, eic0032, 2014, 4).
score(2012490160, eic0112, 2014, missed).
score(2012380501, eic0032, 2014, 11).


nCourses(C) :-
	findall(_, course(_, _, _, _, _, _), List),
    length(List, C).

studentAverage(S, A):-
	findall(N,(score(S,_,_,N), N \= missed, N >= 10),L),
	length(L,N2),
	N2 > 0,
	sumlist(L,N1),
	A is N1 / N2.	

studentAverage(_, nd).

cadeirao(C) :-
	findall(N, (course(Code, _, _, _, _, _), findall(_, score(_, Code, _, _), L), length(L, N)), CoursesNumbers),
	max_member(Max, CoursesNumbers),
	findall(Name, (course(Code, Name, _, _, _, _), findall(_, score(_, Code, _, _), L), length(L, Max)), C).


