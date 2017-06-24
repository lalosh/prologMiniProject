

cost("beef1",1).
cost("beef2",2).
cost("beef3",3).
cost("beef4",4).

ingredients("a",["beef4","beef3"]).
ingredients("b",["beef1","beef2"]).
ingredients("c",["beef2","beef3"]).
ingredients("d",["beef4","beef2"]).

resturant("x",["gox","box"],["a","b"]).
resturant("y",["goy","boy"],["c","a"]).
resturant("z",["gox","boz"],["d","c"]).
resturant("w",["gow","box"],["a","d"]).

av(X,Y):- available(X,Y).
available(X,Y) :- resturant(Y,L1,L2),member(X,L2).

/*this method is just like available(X,Y) but for workers instead of food*/
worker_x_is_available_at_res_y(X,Y) :- resturant(Y,L1,L2), member(X,L1).

/*some food is multi_available if it's available in two different resturant*/
mav(X):- multi_available(X).
multi_available(X) :- available(X,Y1),available(X,Y2),Y1 \= Y2,!.

/*over_worked is just like multi_available but for workers not food*/
ow(X):-over_worked(X).
over_worked(X) :- worker_x_is_available_at_res_y(X,Y1),worker_x_is_available_at_res_y(X,Y2),Y1 \= Y2,!.


total_cost(X,Y) :- ingredients(X,L),convert_food_costs_to_numbers(L,L2),list_sum(L2,Y).

/*sum a list of integer numbers*/
list_sum([],0).
list_sum([X],X),!.
list_sum([H|T],Y) :- list_sum(T,Y1), Y is Y1+H.

/*given a list of things it return a list of their costs*/
cc(X,Y):-convert_food_costs_to_numbers(X,Y).
convert_food_costs_to_numbers([],[]).
convert_food_costs_to_numbers([H],[J]):- cost(H,J),!.
convert_food_costs_to_numbers([H|T],[J|K]) :- cost(H,J),convert_food_costs_to_numbers(T,K).


hi(X,Y) :- has_ingredients(X,Y).
has_ingredients(X,Y) :- ingredients(X,Z),contained(Y,Z).

/*a list contained inside another list*/
contained([],[]).
contained([H],L2) :-  member(H,L2).
contained([H|T],L2) :-  not(has_double_elements([H|T])), contained(T,L2), member(H,L2).


/*check if a list has two similar elements*/
hd(X) :- has_double_elements(X).
not(has_double_elements([])).
not(has_double_elements([H])).
has_double_elements([H|T]) :- member(H,T),!.

add_element(X,L,[X|L]).

length_is_bigger_than_one(L):-len(L).
len([H1,H2|T]).
