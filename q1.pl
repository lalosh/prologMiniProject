
zip([X],[],[X]).
zip([],[X],[X]).

zip(X,[],X),!.
zip([],X,X),!.

zip([X],[Y],[X,Y]),!.
zip([X],[Y],[Y,X]),!.

zip([H1|T1],L2,[H1|Y]) :- zip(T1,L2,Y).
zip(L1,[H2|T2],[H2|Y]) :- zip(L1,T2,Y).
