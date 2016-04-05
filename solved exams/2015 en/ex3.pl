:- use_module(library(lists)).

follows(asdrubal, capitulina). 
follows(capitulina, asdrubal). 
follows(capitulina, marciliano). 
follows(irineu, epifanio). 
follows(marciliano, epifanio).


density(D) :-
	findall(User, (follows(User, _) ; follows(_, User)) , DuplicatedUsers),
	findall(_, follows(_, _) , Follows),
	sort(DuplicatedUsers, Users),
	length(Users, Number),
	PossibleFollowsPerUser is Number - 1,
	PossibleFollows is PossibleFollowsPerUser * Number,
	length(Follows, NumberOfFollows),
	D is NumberOfFollows / PossibleFollows.


	

heterogeneity(H) :-
	findall(NumberOfFollowers-User, ((follows(_, User) ; follows(User, _)), findall(Follower, follows(Follower,User), Followers), length(Followers, NumberOfFollowers)), DuplicatedList),
	sort(DuplicatedList, List),
	count(0, 0, List, H).

count(It, Occurrences, [Number-_], H) :-
	It == Number,
	H = It-Occurrences.

count(_, Occurrences, [Number-_], H) :-
	H = Number-Occurrences.


count(It, Ocurrences, [Number-_ | ListT], H) :-
	It == Number,
	Ocurrences1 is Ocurrences + 1,
	count(It, Ocurrences1, ListT, H).

count(It, Occurrences, List, [HH , TT]) :-
	It1 is It + 1,
	HH = It-Occurrences,
	count(It1, 0, List, TT).
