/* FAITS */
homme(jean).
homme(gaston).
homme(michel).
homme(popeye).
homme(david).
homme(charly).

femme(marie).
femme(gertrude).
femme(laure).
femme(olive).
femme(virginie).
femme(julie).
femme(mimosa).
femme(sidonie).

mere(gertrude,david).
mere(gertrude,virginie).
mere(laure,charly).
mere(laure,julie).
mere(marie,laure).
mere(olive,mimosa).
mere(olive,sidonie).

pere(gaston,david).
pere(gaston,virginie).
pere(michel,charly).
pere(michel,julie).
pere(popeye,mimosa).
pere(popeye,sidonie).
pere(jean,gaston).
pere(jean,laure).
pere(jean,popeye).

epoux(marie,jean).
epoux(gertrude,gaston).
epoux(laure,michel).
epoux(popeye,olive).

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
fille(X,Y) :-femme(X),pere(Y,X).
/*
	conjonction 
	fille(X,Y) :-femme(X),pere(Y,X).
	conjonction et disjonction
	fille(X,Y) :- femme(X),pere(Y,X);femme(X),pere(Y,X).
*/

parent(X,Y) :- mere(X,Y),pere(X,Y).
fille(X,Y) :- femme(X),parent(Y,X).
fils(X,Y) :- homme(X),parent(Y,X).



