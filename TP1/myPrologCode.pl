%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                 Debut...                                       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% I. UNIFICATION ('_' : variable anonyme):

e0(1,[X,Y]) :- f(X,a,Y) = f(b,Y,_).
e0un :- f(X,a,Y) = f(b,Y,c).
/*Va retourner false  car on ne peut ecraser la valeur d'une variable par une autre Y=a,Y=c - C'est MEGA FALSE (et normal)*/
e0deux(1,[X,Y,Z]) :- f(X,a,Z) = f(b,Y,c).

