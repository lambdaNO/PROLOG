%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                 Debut...                                       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% I. UNIFICATION ('_' : variable anonyme):

e0(1,[X,Y]) :- f(X,a,Y) = f(b,Y,_).
e0a(1,[X,Y]) :- f(X,a,Y) = f(b,Y,c).
/*Va retourner false  car on ne peut ecraser la valeur d'une variable par une autre Y=a,Y=c - C'est MEGA FALSE (et normal)*/
e0b(1,[X,Y,Z]) :- f(X,a,Z) = f(b,Y,c).

e0(2,[X,Y]) :- f(X,_,h(Y,Y,c)) = f(Z,0,h(k(X),V,X)).
e0a(2,[X,Y,A]) :- f(X,A,h(Y,Y,c)) = f(Z,0,h(k(X),V,X)).

e0(3,[U]) :- f(X,h(X,X),k(Y,Y)) = f(g(0),Y,U).
e0a(3,[U],[X]) :- f(X,h(X,X),k(Y,Y)) = f(g(0),Y,U).
e0b(3,[X],[U]) :- f(X,h(X,X),k(Y,Y)) = f(g(0),Y,U).

/*kifkif avec et sans ()*/
e0(4,[X,Y,Z]) :- f(X,h(_,Y,Y),_) = f(Y,h(6,k(5),Z),c).
e0a(4,X,Y,Z) :- f(X,h(_,Y,Y),_) = f(Y,h(6,k(5),Z),c).


e0(5,_) :-
  f(X,[1,2]) = f([1|Y],X),
  write(X),
  nl,        % a la ligne
  write(Y).
e0a(5,_) :-
  f(X,[1,2]) = f([1|Y],X),
  write(X),
	nl,
	write('coucou virgule'),
  nl,        % a la ligne
  write(Y).


e0d(5,_) :-
  f(X,[1,2,3]) = f([1|Y],X),
  write(X),
  nl,        % a la ligne
  write(Y).
e0e(5,_) :-
  f(X,[1,2,3]) = f([1|Y],X),
 write('X = '), write(X),
  nl,        % a la ligne
  write('Y = '),write(Y).

e0f(5,X) :-
  f(X,[1,2]) = f([1|Y],X),
  nl,        % a la ligne
  write('Y = '),write(Y).
/*
* ?- e0f(5,_).

Y = [2]
true.
?- e0f(5,X).

Y = [2]
X = [1, 2].


*/

e0g(5,_) :-
  f(X,[1,2,3]) = f([1,2|Y],X),
  nl,        % a la ligne
  write('Y = '),write(Y).

/*
WHYYYYYYYYYY ? Pourquoi tant de valeurs de Y ? 
?- e0g(5,_).

Y = [3]
true ;

Y = []
true.

*/


e0h(5,_) :-
  f(X,[1,2]) = f([1,2|Y],X),
  nl,        % a la ligne
  write('Y = '),write(Y).

/*
BECAUSE
X vaut [1,2] liste à deux éléments
MAIS X vaut aussi [1,2|Y], une liste avec minimum 3 éléments 
*/

/*Les classiques : */
e0(6,X) :- f(a,b) = f(X,X).
/*False car deux valeurs*/
e0(7,X) :- f(X) = X.               % BOUCLES !!!!!
e0(8,X) :- [1|X] = X.

e0(9,X) :- [1|_] = X.

/*UN ALGO COMPREND TROIS REGLES */
e0(10,[X,Y]) :- p(X,[a|Y]).

p(m,[a,b,c]).                     % definition de p/2 par un fait

e0(10,[X,Y]) :- p(X,[a,b|Y]).


/* UN SECOND ALGO A TROIS REGLES*/
e0a(10,[X,Y]) :- p1(X,[a|Y]).

p1(m,[a,b,c,d,e]).                     % definition de p/2 par un fait

e0a(10,[X,Y]) :- p1(X,[a,b|Y]).

/* UN SECOND ALGO A TROIS REGLES*/

e0b(10,[X,Y]) :- p2(X,[a|Y]).

p2(m,[a,b,c,d,e]).                     % definition de p/2 par un fait

e0b(10,[X,Y]) :- p2(X,[a,b|Y]).

p2(m,[a,b,c,d,e]).   

e0b(10,[X,Y]) :- p2(X,[a,b,c|Y]).

p2(m,[b,c,d,e]). 

e0b(10,[X,Y]) :- p2(X,[a,b,c,d|Y]).
/*Renvoi false Mais renvoi des multiples*/

/* */

e0c(10,[X,Y]) :- p3(X,[a|Y]).

p3(m,[a,b,c,d,e]).                     % definition de p/2 par un fait

e0c(10,[X,Y]) :- p3(X,[a,b|Y]).

p3(m,[a,b,c,d,e]).   

e0c(10,[X,Y]) :- p3(X,[a,b,c|Y]).


e0c(10,[X,Y]) :- p3(X,[a,b,c,d|Y]).
/*Renvoi false Mais renvoi des multiples*/

/* */

e0d(10,[X,Y]) :- p4(X,[a|Y]).

p4(m,[a,b,c,d,e]).                     % definition de p/2 par un fait

e0d(10,[X,Y]) :- p4(X,[a,b|Y]).

e0d(10,[X,Y]) :- p4(X,[a,b,c|Y]).

e0d(10,[X,Y]) :- p4(X,[a,b,c,d|Y]).
/*Renvoi false ET ne renvoi pas de multiple*/


/*Pour la fonction pro ... faire l'arbre pour bien comprendre ... :) */


e1(a) :- write('a -> b '),
nl,
e1(b),
nl,
write(' b -> c '),
nl,
e1(c),
nl,
write('c -> fail '),                % ECHEC
nl,
write(' Backtrack... '),
nl,
fail.
e1(a) :- write(' deuxieme clause de a '),
nl,
write(' a -> e '),
nl,
e1(e).
e1(b) :- write(' b reussit ').
e1(c) :- write(' c -> e '),
nl,
e1(e).
e1(e) :- write(' e reussit ').

/* MY LTERNATIVE */
/* ONE */
/* On obtient le même résultat qu avec e1(a) puisque le fail entraine un arret */
e1bis(a) :- write('a -> b '),
nl,
e1bis(b),
nl,
write(' b -> c '),
nl,
e1bis(c),
nl,
write('c -> fail '),                % ECHEC
nl,
write(' Backtrack... '),
nl,
fail.
e1bis(a) :- write(' deuxieme clause de a '),
nl,
write(' a -> e '),
nl,
e1bis(e).
e1bis(b) :- write(' b reussit ').
e1bis(b) :- write(' deuxième clause de b '),
nl,
fail.
e1bis(c) :- write(' c -> e '),
nl,
e1bis(e).
e1bis(e) :- write(' e reussit ').

/* TWO */
/* LA CA CHANGE */
e1tris(a) :- write('a -> b '),
nl,
e1tris(b),
nl,
write(' b -> c '),
nl,
e1tris(c),
nl,
write('c -> fail '),                % ECHEC
nl,
write(' Backtrack... '),
nl,
fail.
e1tris(a) :- write(' deuxieme clause de a '),
nl,
write(' a -> e '),
nl,
e1tris(e).
e1tris(b) :- write(' b reussit ').
e1tris(b) :- write(' deuxième clause de b ').
e1tris(c) :- write(' c -> e '),
nl,
e1tris(e).
e1tris(e) :- write(' e reussit ').

