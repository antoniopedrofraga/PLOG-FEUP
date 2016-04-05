:-use_module(library(lists)).

artist(1,'MIEIC',2006).        
artist(2,'John Williams',1951).
artist(3,'LEIC',1995).         
artist(4,'One Hit Wonder',2013).

album(a1,'MIEIC Reloaded',2006,[1]).     
album(a2,'Best Of',2015,[2]).
album(a3,'Legacy',2014,[1,3]).            
album(a4,'Release',2013,[4]).

:- dynamic song/3.
song(a1,'Rap do MIEIC',4.14).          
song(a2,'Indiana Jones',5.25).
song(a1,'Pop do MIEIC',4.13).          
song(a2,'Harry Potter',5.11).
song(a1,'Rock do MIEIC',3.14).         
song(a2,'Jaws',3.04).
song(a2,'Jurassic Park',5.53).         
song(a2,'Back to the Future',3.24).
song(a2,'Star Wars',5.20).             
song(a2,'E.T. the Extra-Terrestrial',3.42).
song(a3,'Legacy',3.14).                
song(a3,'Inheritance',4.13).
song(a4,'How did I do it?',4.05).
song(a4,'Teste',4.05).


hasLongSong(AlbumId) :-
	song(AlbumId, _, Duration),
	Duration > 5.



recentSingle(AlbumId) :-
	song(AlbumId, Song1, _), song(AlbumId, Song2, _), Song1 \= Song2, !, fail.
recentSingle(AlbumId) :-
	album(AlbumId, _, Year, _), Year >= 2010.

songDurations([], []).
songDurations([SongsH | SongsT], [DurationsH | DurationsT]) :-
	song( _, SongsH, DurationsH),
	songDurations(SongsT, DurationsT).


albumSongs(AlbumId) :-
	\+ (album(AlbumId, _, _, _)), !, fail.
albumSongs(AlbumId) :-
	song(AlbumId, Song, Duration),
	writeSong(Song, Duration),
	fail.
albumSongs(_).


writeSong(Song, Duration) :-
	write(Song),
	write(' ('),
	write(Duration),
	write(')'), nl.

addSongs(_, []).
addSongs(AlbumId, [Song-Duration | T]) :-
 	\+ (song(AlbumId, Song, Duration)),
 	assertz(song(AlbumId, Song, Duration)),
 	addSongs(AlbumId, T).
adSongs(AlbumId, [_ | T]) :-
	addSongs(AlbumId, T).



songsPerAlbum(AlbumId, Songs) :-
 	findall(_, song(AlbumId, _, _), List),
 	length(List, Songs).

artistSongsPerYear(ArtistId, SongsPerYear) :-
	artist(ArtistId, _, Premier),
	findall(Songs, (album(Album, _, Year, Members), Year =< 2014, member(ArtistId, Members), songsPerAlbum(Album, Songs)), Songs),
	sumlist(Songs, Number),
	SongsPerYear is Number / (2015 - Premier).


totalDuration(AlbumId, DurationShort, DurationLong) :-
	findall(Duration, (song(AlbumId, _, Duration), Duration < 4), DurationShortList),
	findall(Duration, (song(AlbumId, _, Duration), Duration >= 4), DurationLongList),
	sumDurations(DurationShortList, 0, DurationShort),
	sumDurations(DurationLongList, 0, DurationLong).

sumDurations([], Ac, Duration) :-
	Seconds100Final is float_fractional_part(Ac),
	Seconds60Final is Seconds100Final * 6 / 10,
	Minutes is floor(Ac),
	Duration is Minutes + Seconds60Final.
sumDurations([H | T], Ac, Duration) :-
	sumMinSec(Ac, H, Result),
	sumDurations(T, Result, Duration).
sumMinSec(Ac, T, Result) :-
	Seconds60 is float_fractional_part(T),
	Seconds100 is Seconds60 * 10 / 6,
	Minutes is floor(T),
	Time is Minutes + Seconds100,
	Result is Ac + Time.
	

whatDoesItDo([],_,[]).
whatDoesItDo([X|Xs],A,[X|Ys]):-
    album(X,_,_,LA), member(A,LA), !, whatDoesItDo(Xs,A,Ys).
whatDoesItDo([_|Xs],A,Ys):-
    whatDoesItDo(Xs,A,Ys).
