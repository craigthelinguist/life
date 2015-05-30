




size(10).

next_gen(Matrix, Matrix2) :-
       findall(Row:Col, elem(Matrix, Row:Col, _), Elements),
       

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
       elem(Matrix, Row:Col, 1).

/** Predicate holds if the Matrix contains Elem at Row:Col. **/
elem(Matrix, Row:Col, Elem) :-
       nth0(Row, Matrix, Line),
       nth0(Col, Line, Elem).



/*


[ [1,0,0,0],
  [0,0,0,0],
  [0,1,1,0],
  [1,1,0,0] ]


*/




