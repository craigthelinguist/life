

size(3).


/** Predicate holds if Matrix2 is the result of performing one
    iteration of the game of life on Matrix. **/
next_gen(Matrix, Matrix2) :-
       findall(Row:Col:State, (elem(Matrix, Row:Col, _), next_gen(Matrix, Row:Col, State)), Updated),
       unflatten(Updated, Matrix2).


/** Predicate holds if Matrix is the result of taking a flat list
    representation of a matrix of the form row:col:entry and turning
    it into the corresponding list of lists. **/
unflatten(Elems, Matrix) :-
       size(N),
       unflatten2(N, Elems, [], Matrix).

unflatten2(0, [], Matrix, Matrix) :- !.

unflatten2(Index, Elems, Acc, Matrix) :-
       size(Len),      
       behead(Len, Elems, Row, RestOfElems),
       maplist(third, Row, Row2),
       prepend(Row2, Acc, Acc2),
       Index2 is Index-1,
       unflatten2(Index2, RestOfElems, Acc2, Matrix).
       
       

/** Predicate holds if Head is the first N elements of List, and Tail
    is the rest. **/
behead(N, List, Head, Tail) :-
       behead2(N, List, [], HeadR, Tail),
       reverse(HeadR, Head).
     
behead2(0, List, Head, Head, List) :- !.

behead2(N, [X|List], Acc, Head, Tail) :-
       N2 is N-1,
       behead2(N2, List, [X|Acc], Head, Tail).


/** Predicate holds if second argument is the third element of the
    triple. **/
third(_:_:Z, Z).

/** Predicate holds if X prepended to List yields the third argument.
    **/
prepend(X, List, [X|List]).

/** Predicate holds if Row:Col should become State (1 or 0) in the
    next generation of Matrix. **/
next_gen(Matrix, Row:Col, State) :-
       adjacency(Row:Col, Adjacency),
       findall(X, (member(X, Adjacency), alive(Matrix, X)), Alive),
       length(Alive, Len),
       GoodNums = [2,3],
       ((member(Len, GoodNums)) -> State=1, !) ; (State = 0, !).

/** Predicate holds if Adjacency is the list of points surrounding
    the specified point Row:Col. **/
adjacency(Row:Col, Adjacency) :-
       size(N),
       Below is mod(Row+1, N), Above is mod(Row-1, N),
       Right is mod(Col+1, N), Left is mod(Col-1, N),
       Adjacency = [ Row:Left, Row:Right, Col:Above, Col:Below ].

/** Predicate holds if the Matrix has 1 as an entry at Row:Col. **/
alive(Matrix, Row:Col) :-
       nth0(Row, Matrix, Line),
       nth0(Col, Line, 1).
       elem(Matrix, Row:Col, 1).

/** Predicate holds if the Matrix contains Elem at Row:Col. **/
elem(Matrix, Row:Col, Elem) :-
       nth0(Row, Matrix, Line),
       nth0(Col, Line, Elem).




