somePredicate(_, B) :-
    arbitraryPredicate(A, _variable, 1, 2),
    predicateWithAtom(someAtom),
    anotherPredicate(B, someAtom, myPredicate(A, _)),
    findall(X, ('testString'(X), myPredicate(A, X)), L1),
    member(A, L1),
    !.
    /*
    block comment: blah blah blah
    */
    % to-end-of-line comment: blah blah blah
