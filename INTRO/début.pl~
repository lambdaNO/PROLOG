/* FAITS
 * Les hommes
 */
homme(jean).
homme(gaston).
homme(michel).
homme(popeye).
homme(david).
homme(charly).
/* 
 * Les femmes
 */
femme(marie).
femme(gertrude).
femme(laure).
femme(olive).
femme(virginie).
femme(julie).
femme(mimosa).
femme(sidonie).
/* 
 * Relation de mère
 */
mere(gertrude,david).
mere(gertrude,virginie).
mere(laure,charly).
mere(laure,julie).
mere(marie,laure).
mere(marie,gaston).
mere(marie,popeye).
mere(olive,mimosa).
mere(olive,sidonie).
/* 
 * Relation de pètr
 */
pere(gaston,david).
pere(gaston,virginie).
pere(michel,charly).
pere(michel,julie).
pere(popeye,mimosa).
pere(popeye,sidonie).
pere(jean,gaston).
pere(jean,laure).
pere(jean,popeye).
/* 
 * Relation de couple
 */
epoux(marie,jean).
epoux(gertrude,gaston).
epoux(laure,michel).
epoux(olive,popeye).

/*REGLES*/

epouse(Y,X) :- epoux(X,Y).

enfant(X) :- pere(Y,X).
enfant(X) :- mere(Y,X).
/*	
	Autre ecriture : 
	disjonction
	enfant(X) :- pere(Y,X);mere(Y,X).

	Pour enlever le warning 
	on peut utiliser les variables anonymes : 
	enfant(X) :- mere(_,X).
	enfant(X) :- pere(_,X).
*/
fille(X,Y) :-femme(X),pere(Y,X).
fille(X,Y) :-femme(X),mere(Y,X).
/*
	conjonction 
	fille(X,Y) :-femme(X),pere(Y,X).
	conjonction et disjonction
	fille(X,Y) :- femme(X),pere(Y,X);femme(X),mere(Y,X).
*/
%définition d'enfant à deux variables

enfant(X,Y) :- parent(Y,X).

parent(X,Y) :- mere(X,Y);pere(X,Y).
/*Dans prolog, quand on définit un prédicat (meme nom) mais avec un nombre de variables différent, il considère que ce sont deux prédicats différents*/
parent(X):-enfant(_,X).
/*
parent(X) :- enfant(X,_).
*/



fille(X,Y) :- femme(X),parent(Y,X).
fils(X,Y) :- homme(X),parent(Y,X).

frere(X,Y) :- homme(X),fils(X,Z),parent(Z,Y).
soeur(X,Y) :- femme(X),fille(X,Z),parent(Z,Y).

% En interdisant d'être son propre frere
fratrie(X,Y) :- parent(Z,X),X\==Y,parent(Z,Y).
% En utilisant père et mère à défaut de parent car on obtient deux fois le nom des frêres

/*
Permet d'éviter les warnings ... car on utilise pas de Z, variable non déclarée 
	grandpere(X,Y) :- hommes(X),parent(Z,Y).
grandpere(X,Y) :- homme(X),(parent(X,_),parent(_,Y)).
//On rencontre un souci dans le parcours de l'arbre.
?- grandpere(X,Y).
X = jean,
Y = david ;
X = jean,
Y = virginie ;
X = jean,
Y = charly ;
X = jean,
Y = julie ;
X = jean,
Y = laure ;
X = jean,
Y = mimosa ;
*/
/*
grandpere(X,Y) :- homme(X),(parent(X,Z),parent(Z,Y)).
*/
grandpere(X,Y) :-  (pere(X,Z),parent(Z,Y)).
/*
grandmere(X,Y) :- femme(X),(parent(X,Z),parent(Z,Y)).
*/
grandmere(X,Y) :- (mere(X,Z),parent(Z,Y)).

oncle(X,Y) :- (frere(X,Z),(parent(Z,Y))),(X\==Z).

tante(X,Y) :- (soeur(X,Z),parent(Z,Y)),(X\=Z).

grandparent(X,Y) :- grandpere(X,Y);grandmere(X,Y).

petitfils(X,Y) :- homme(X),grandparent(Y,X).

petitefille(X,Y) :- femme(X),grandparent(Y,X).

marier(X,Y) :- epoux(X,Y).
marier(X,Y):- epouse(X,Y).

/*
	marier(X,Y) :- epoux(X,Y),epouse(Y,X).
*/
%Autre méthode de définition de grand parents avec enfants

grand_parent()
