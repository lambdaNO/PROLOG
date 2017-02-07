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



/*Pour la fonction pro ... faire l'arbre pour bien comprendre ... :) */
