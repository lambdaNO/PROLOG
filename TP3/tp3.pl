%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   TP 3                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% I. Operateurs            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% op(+Precedence,+Assoc,+Functor) definit un nouvel operateur 'Functor'
%% PRECEDENCE:  1 =< number =< 1200 : une priorite
%% ASSOCIATIVITY : associativite
%% 1. operateurs unaires : fx - prefixe non-associatif ("?-") ;
%%                         fy - prefixe ("not");
%%                         yf - postfixe.
%% 2. binaires :           xfx - interfixe, non-associatif (":-");
%%                         xfy - associatif a droite (.(..))
%%                         yfx - associatif a gauche ((..).)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calcul des fonctions booleennes

:-op(600,fy,'~').      % negation
:-op(670,yfx,&).
:-op(690,yfx,'V').

p.  % la lettre vraie ; les autres lettres sont fausses

sat(true):-!.
sat(X & Y) :-!,
  sat(X),
  sat(Y).
sat(X 'V' Y) :-
  sat(X),!.
sat(X 'V' Y) :-
  sat(Y).
sat('~' X) :-!,
  not(sat(X)).
sat(X) :- call(X).

ex1 :- sat('~'(p & ('~' p))).                     % yes
ex2 :- sat(p & ('~' p)).                          % no
ex3 :- sat(p 'V' '~' (a 'V' ('~' p 'V' b))).  % yes
exx :- sat('~' p).


%%%%%%%%%% des exemples de predicat
pos(0):-fail.
pos(1).
pos(2) :- write('Avez vous le laisser passer A 38'),nl.
pos(3) :- write('Avez vous le laisser passer A 38'),nl,fail.
pos(4) :- write('Il vous faut le formulaire bleu').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% II.                  Boucles en Prolog             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Boucle `REPEAT'
%%
%% Exemple : calcul du nombre d'occurrences de 0 dans un fichier
%%
noc0(File,N) :-
  abolish(compt/1),          % abolit le predicat   compt/1
  assert(compt(0)),          % met le fait dans la BD
  see(File),                 % ouvre le fichier File pour la lecture
  boucle0,
  seen,                      % fermeture du fichier
  retract((compt(N))),       % supprime le fait dans la BD ; PCH !!!
  !.

%% tell/1 : ouverture pour l'ecriture
%% told/0 : fermeture

boucle0 :-
  repeat,                    % PCH
  get0(B),
  sa(B > -1,                % lecture d'un octet ; faux a la fin
                             % le fichier n'est pas termine
     (sas(B == 48,           % 0 lu
          lect(N),
          fail
          ),
          fail
      )
     ),
     !.

lect(N) :-
  retract((compt(N))),
  N1 is N+1,
  assert((compt(N1))),
  !.

tst1(N) :-
  noc0('WORD.TXT',N).

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Boucle `FORALL'
%%
%% Exemple : calcul du nombre d'entiers pairs dans une liste
%%
noc1(Liste,Pairs) :-
  abolish(lfait/1),
  assert(lfait([ ])),
  pourtout(memb(E,Liste),
        (sa((R is E mod 2,
              R==0),         % E est pair
              (retract((lfait(L))),
               assert(lfait([E|L]))
              )
             )
          )
         ),
  retract((lfait(Ps))),
  inv(Ps, Pairs),
  !.

tst2(N) :-
  noc1([97,0,1,4,43,12],N).

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Boucle `FINDALL'
%%
%% findall(+Term,+Condition,-Liste): Liste est la
%% liste des cas particuliers de Term qui satisfont la Condition
%%
%% Exemple : calcul du nombre d'entiers pairs dans une liste
%%
noc2(Entiers,Pairs) :-
   findall(E,
           (memb(E,Entiers),
            R is E mod 2,
            R == 0
            ),
           Pairs).

tst3(N) :-
  noc2([97,0,1,4,43,12],N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% III. Tri rapide "binsort" qui calcule en temps N*logN %%
%% msort(+Liste,?Liste_trie).                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msrt([],[]) :-
  !.
msrt([E],[E]) :-
  !.
msrt(L,S) :-
  part(L,L1,L2),    % repartir L en deux parties L1,L2 de `la meme' longueur
  msrt(L1,S1),
  msrt(L2,S2),
  mrge(S1,S2,S).    % fusionner deux listes triees en mettant leurs elements
                    % aux positions propres.
% part(+List,?Moitie_gauche,?Moitie_droite).
part(L,L1,L2) :-
  length(L,N),       % N est la taille de L (bibl.)
  M is N // 2,       % //  division des entiers
  sect(L,M,L1,L2).   % L1 est le prefixe de L de longueur M ;
                     % L2 est le reste

% sect(+List,+Prefix_length,?Prefix,?Rest).
sect(L,0,[],L) :- !.
sect([E|T],N,[E|R],S) :-
  N1 is N-1,
  sect(T,N1,R,S).

% mrge(+Sorted1,+Sorted2,?Sorted_result).
mrge([],L,L) :- !.
mrge(L,[],L) :- !.
mrge([E|T1],[E|T2],[E|T]) :-
  !,
  mrge(T1,[E|T2],T).
mrge([E1|T1],[E2|T2],[E1|T]) :-     % E1 \== E2
%  E1 < E2,                         % l'ordre des nombres
  E1 @< E2,                         % l'ordre lexicographique
  !,
  mrge(T1,[E2|T2],T).

mrge([E1|T1],[E2|T2],[E2|T]) :-     % E1 \== E2
%  E2 < E1,
  E2 @< E1,
  mrge([E1|T1],T2,T).

tst4 :-
  msrt([9,8,7,6,5,4,4,3,2],L),
  write(L).

%% A comparer avec l'algorithme suivant naif :

bsort([],[]) :- !.
bsort([E|T],S) :-
  bsort(T,S0),
  posit(E,S0,S).  % met E a la position correcte dans S0 pour obtenir S

% posit(+Element,+In_list,?Res_list).
posit(E,[],[E]) :- !.
posit(E,[E1|T],[E,E1|T]) :-
  E =< E1.
posit(E,[E1|T],[E1|R]) :-
  posit(E,T,R).

tst5 :-
  bsort([9,8,7,6,5,4,4,3,2],L),
  write(L).

%% PROGRAMMEZ un autre algorithme de tri des listes d'entiers
%% qui utilise le predicat suivant `split' a la place de part/3 :
%% Division d'une liste List en deux parties : celle des elements
%% precedant Element, et l'autre des elements suivant Element.
%% split(+List,+Element,?Preceeding,?Following).

split([],E,[],[]) :- !.
split([E|T],E0,[E|T1],T2) :-
  E < E0,
  !,
  split(T,E0,T1,T2).
split([E|T],E0,T1,[E|T2]) :-
  split(T,E0,T1,T2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IV. Structures             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1 :-
  functor((a+b),F,A),
  write(F),
  tab(2),
  write(A).
f2 :-
  functor(Terme, h, 2),
  arg(1,Terme,s(1)),
  arg(2,Terme,s(2)),
  write(Terme).
f3 :-
  h(s(1),s(2),s(3)) =.. L,
  write(L).
f4 :-
  H =..[h,s(1),s(2),s(3)],
  write(H).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Predicats preprogrammes:         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sas(C,L1,L2) :-
   C,!,
   L1.
sas(C,L1,L2) :-
   L2.

sa(C,L) :-
   C,!,
   L;
   true.

memb(E,[E|_]).               % PCH
memb(E,[E1|T]) :-
  memb(E,T).

pourtout(C,L) :-
  not((C,not(L))).

inv(L,I) :-
  iv(L,[],I).
iv([],I,I) :- !.
iv([E|R],A,I) :-
  iv(R,[E|A],I).
