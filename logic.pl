/*

[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]
[" ", " ", " ", " ", " ", " ", " ", " ", " "]

 X € [0,8]*/


howManyFriendsInRow([], _, _, Count, _, Count).

howManyFriendsInRow([ Piece | Row ], Player, X, Count, Index, Answer) :-

    X > Index,
    Piece = Player,
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X, 1, NewIndex, Answer) ;

    X > Index,
    Piece \= Player,
    Piece \= " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X, 0, NewIndex, Answer) ;

    X > Index,
    Piece = " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X, Count, NewIndex, Answer) ;

    X = Index,
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X, Count, NewIndex, Answer) ;

    X < Index,
    Piece = " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X, Count, NewIndex, Answer) ;

    X < Index,
    Piece = Player,
    NewIndex is Index+1,
    NewCount is Count+1,
    howManyFriendsInRow([], Player, X, NewCount, NewIndex, Answer) ;

    X < Index,
    Piece \= Player,
    Piece \= " ",
    NewIndex is Index+1,
    howManyFriendsInRow([], Player, X, Count, NewIndex, Answer) .

    

/* X € [1,9]*/

howManyFriendsInSight([Row | GameState], Player, X, Y) :-
    Row = X,
    X2 is X-1,
    howManyFriendsInRow(Row, Player, X2, 0, 0, Answer).
    
/*howManyFriendsInRow([" ", " ", "x", " ", " ", "x", "!", "x", "o"], "x", 6, 0, 0, Answer).  
*/