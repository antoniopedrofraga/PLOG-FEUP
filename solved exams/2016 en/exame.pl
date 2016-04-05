%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).



:-use_module(library(lists)).
:-use_module(library(clpfd)).

madeItThrough(Participant) :-
    participant(Participant, _, _),
    performance(Participant, Times),
    member(120, Times).


juriTimes(Participants, JuriMember, Times, Total) :-
    getTimes(Participants, JuriMember, Times),
    sumlist(Times, Total).

getTimes([], _, _).    
getTimes([PH | PT], N, [TH | TT]) :-
    participant(PH, _, _),
    performance(PH, Times),
    nth1(N,Times,TH),
    getTimes(PT, N, TT).


patientJuri(JuriMember) :-
    performance(Id, Times),
    performance(Id2, Times2),
    Id \= Id2, 
    nth1(JuriMember,Times,120),
    nth1(JuriMember,Times2,120).

bestParticipant(P1,P2,P) :-
    performance(P1, Times1), sumlist(Times1, Total1),
    performance(P2, Times2), sumlist(Times2, Total2),
    ((Total1 > Total2, P = P1) ; (Total2 > Total1, P = P2)).

allPerfs :-
    \+ (participant(Participant, _, Performance),
    performance(Participant, Times),
    \+ (write(Participant),write(':'), write(Performance), write(':'), write(Times), nl) ).


 nSuccessfulParticipants(T) :-
    findall(_, (participant(Id, _, _), performance(Id, Times), \+ (member(Time, Times), Time \= 120)), List),
    length(List, T).

juriFans(JuriFansList) :-
    findall(Id-Juries, (participant(Id, _, _), performance(Id, Times), findall(Position, nth1(Position, Times, 120), Juries)), JuriFansList).


eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

nextPhase(N, Participants) :-
    findall(Time-Id-Performance,  eligibleOutcome(Id, Performance, Time), List),
    sort(List, NewList),
    length(NewList, EligibleParticipantsNumber),
    EligibleParticipantsNumber >= N,
    reverse(NewList, SortedList),
    getParticipants(SortedList, Participants, 1, N).
    
getParticipants([SortedH | SortedT], [SortedH | PT], It, N) :-
    It =< N,
    It1 is It + 1,
    !, getParticipants(SortedT, PT, It1, N).    
getParticipants(_, PT, _, _) :-
    PT = [].

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

langford(X, L) :-
    X1 is X * 2,
    length(L, X1),
    percorreLista(X, L).
    
percorreLista(0, _) :- !.
percorreLista(X, L) :-
    impoe(X, L),
    X1 is X - 1,
    percorreLista(X1, L).


aux1([A, B]) :-
    A #\= B.
aux1([_]).
aux1([]).
aux1([El1, El2, El3 | T]) :-
     ((El1 #< El2 #/\ El2 #> El3) #\/
    (El1 #> El2 #/\ El1 #> El3 #/\ El3 #> El2) #\/
    (El3 #> El1 #/\ El3 #> El2 #/\ El1 #> El2)) #\/
    ((El1 #> El2 #/\ El2 #< El3) #\/
    (El1 #< El2 #/\ El1 #< El3 #/\ El3 #< El2) #\/
    (El3 #< El1 #/\ El3 #< El2 #/\ El1 #< El2)),
    aux1([El2, El3 | T]).

ups_and_downs(Min, Max, N, L) :-
    length(L, N),
    domain(L, Min, Max),
    %
    aux1(L),
    %
    labeling([], L).