child(john, m, 3.5).
child(mary, f, 4.1).
child(esquilo, f, 3.5).

weight(john, 5, 3.3).
weight(john, 10, 3.5).
weight(john, 15, 3.8).
weight(mary, 5, 4.1).
weight(mary, 10, 4.5).
weight(mary, 15, 4.9).
weight(esquilo, 5, 3.5).
weight(esquilo, 10, 3.7).
weight(esquilo, 15, 3.8).

diapers(dodot, small, 3, 5, 0.5).
diapers(dodot, medium, 4.5, 6, 0.4).
diapers(libero, small, 2, 4, 0.7).
diapers(libero, medium, 3.5, 5, 0.7).

boughtFor(john, dodot, small, 1).
boughtFor(mary, libero, small, 0).
boughtFor(john, dodot, small, 5).
boughtFor(mary, dodot, small, 8).
boughtFor(esquilo, libero, small, 8).

priceDiapers(Baby, DaysSinceBirth, Brand, Model, Price) :-
	boughtFor(Baby, Brand, Model, DaysSinceBirth),
	diapers(Brand, Model, _, _, Price).

healthyBaby(Gender, Baby) :-
	child(Baby, Gender, Weight),
	\+ (weight(Baby, _, Weight2),
		Weight > Weight2).

weightsAtBirth( [H] , [H2]) :-
	child( H, _, H2).

weightsAtBirth( [H | T] , [H2 | T2]) :-
	child( H, _, H2),
	weightsAtBirth( T, T2).


diapersBoughtForHealthyBabies([], _, []).

diapersBoughtForHealthyBabies([H | T], Gender, [BabiesH | BabiesT]) :-
	healthyBaby(Gender, Baby),
	boughtFor(Baby, H, _, _),
	BabiesH = H-Baby,
	diapersBoughtForHealthyBabies(T, Gender, BabiesT).

diapersBoughtForHealthyBabies([H | T], Gender, Babies) :-
	\+ (healthyBaby(Gender, Baby),
	boughtFor(Baby, H, _, _)),
	diapersBoughtForHealthyBabies(T, Gender, Babies).

suitableDiapers(Baby, DaysSinceBirth) :-
	weight(Baby, DaysSinceBirth, Weight),
	diapers(Brand, Model, Min, Max, _),
	Weight >= Min,
	Weight =< Max, 
	printDiapers(Brand, Model),
	fail.
	
suitableDiapers(_, _).

printDiapers(Brand, Model) :-
	write('Brand: '),
	write(Brand),
	write(' - Model: '),
	write(Model),
	nl.
