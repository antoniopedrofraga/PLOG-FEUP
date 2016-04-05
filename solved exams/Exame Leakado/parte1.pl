:-use_module(library(lists)).
:-use_module(library(clpfd)).

%install(name, original_install_date, original_version, original_size)
install('Google Play Services', 2014-10-10, 6.8, 35.6).
install('Acrobat Reader', 2014-10-12, 9.4, 18.2).
install('Google Maps', 2014-10-13, 9.14, 38.7).
install('ANT Radio Service', 2014-10-13, 4.0, 0.4).

%update(name, update_date, new_version, new_size)
update('Acrobat Reader', 2014-10-12, 9.5, 18.4).
update('Acrobat Reader', 2016-12-14, 22.3, 22.2).
update('Acrobat Reader', 2016-12-14, 15.2, 22.2).
update('Acrobat Reader', 2016-12-14, 22.4, 22.2).
update('Google Play Services', 2015-12-14, 8.4, 51.0).
update('Google Maps', 2015-12-15, 9.17, 47.7).

%depends_on(app, version, list of dependencies (app-minVersion) )
depends_on('OCV Face Detection', 1.0, ['OpenCV Manager'-3.2]).
depends_on('Google Maps', 9.18, ['Google Play Services'-98.4]).
depends_on('Beaming Service', 1.2, ['ANT Radio Service'-4.14, 'ANT+ Plugins Service'-3.6]).
depends_on('ANT+ Plugins Service', 3.6, ['ANT Radio Service'-4.0]).


installAndUpdate(X) :-
	install(X, Date, _, _), update(X, Date, _, _).


sizes(ListOfApps, ListOfSizes, TotalSize) :-
	sizes(ListOfApps, ListOfSizes),
	sumlist(ListOfSizes, TotalSize).

sizes([App], [Size]) :-
	install(App, _, _, Size).
sizes([AppsH | AppsT], [SizeH | SizeT]) :-
	install(AppsH, _, _, SizeH),
	sizes(AppsT, SizeT).

version(AppName, Version, Size):-
       update(AppName,Date,Version,Size),
       \+ checkMoreRecent(AppName,Date,Version).
  
checkMoreRecent(AppName,Date1,V1):-
       update(AppName,Date1,V2,_),
        V2 > V1.

checkMoreRecent(AppName,Date1,_):-
        update(AppName,Date2,_,_),
        Date2 @> Date1.


canInstall(AppName, Version) :-
	\+ depends_on(AppName, _, _) ;
	(depends_on(AppName, Version, Dependencies), checkDependencies(Dependencies)).

checkDependencies([]).
checkDependencies([Name-Version | T]) :-
	version(Name, V, _),
	V >= Version,
	checkDependencies(T).


allapps :-
	install(Name, _, _, _),
	version(Name, _, Size),
	writeApp(Name, Size),
	fail.

allapps.


writeApp(Name, Size) :-
	write(Name),
	write(' ('),
	write(Size),
	write('MB)'),
	nl.



predX(X) :-
	version(X, V, _),
	\+ x(X, V) .

x(X, V) :-
	depends_on(DA, Dv, Ds),
	version(DA, Dv, _),
	member(X-DAV, Ds),
	V >= DAV, !.


distanciaDeEdicao([H|T], [H|T2], Distancia):-
  distanciaDeEdicao(T, T2, Distancia),!.

distanciaDeEdicao([H|T], [H2|T2], Distancia):-
  H \= H2,
  distanciaDeEdicao(T, [H2|T2], Distancia1),
  distanciaDeEdicao([H|T], T2, Distancia2),
  distanciaDeEdicao(T,T2,Distancia3),
  ((Distancia1 =< Distancia2, Distancia1 =< Distancia3, Distancia is Distancia1+1); repeat),
  ((Distancia2 =< Distancia1, Distancia2 =< Distancia3, Distancia is Distancia2+1); repeat),
  ((Distancia3 =< Distancia2, Distancia3 =< Distancia2, Distancia is Distancia3+1); repeat),!.

distanciaDeEdicao([], [], 0).
distanciaDeEdicao([], L, Distancia):- length(L, Distancia).
distanciaDeEdicao(L, [], Distancia):- length(L, Distancia).


       
aux1([Element1, Element2 | T], [MapH | MapT]) :-
	Element1 #> Element2 #<=> MapH,
	aux2([Element1, Element2 | T], MapT).

aux2([Element1, Element2], [MapElement]) :-
	Element2 #> Element1 #<=> MapElement.

aux2([Element1, Element2, Element3 | T], [MapH | MapT]) :-
	Element1 #< Element2 #/\ Element2 #> Element3 #<=> MapH,
	aux2([Element2, Element3 | T], MapT).

local_and_global_maxima(NLocalMax, GlobalMax, N, L) :-
	length(L, N),
	domain(L, 1, GlobalMax),
	%
	aux1(L, Map),
	NLocalMax1 is NLocalMax + 1,
	count(1, Map, #=, NLocalMax1),
	count(GlobalMax, L, #=, 1),
	%
	labeling([], L).
