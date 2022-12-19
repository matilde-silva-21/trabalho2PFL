/*

[    (X2)  0    1    2    3    4    5    6    7    8
  (Y2)
   0     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   1     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   2     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   3     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   4     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   5     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   6     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   7     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
   8     [" ", " ", " ", " ", " ", " ", " ", " ", " "]
]

GameState, BoardSize, Player, X2, Y2, Count, Index, Answer

howManyFriendsInLeftDiagonal(
    [
        [" ", " ", "x", " ", " ", " ", " ", " ", " "],
        [" ", " ", "o", " ", " ", " ", " ", " ", " "],
        [" ", " ", "x", " ", "!", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", "o", " ", " ", " "],
        [" ", " ", "x", " ", " ", " ", "x", " ", " "],
        [" ", "x", "!", " ", "o", " ", "x", " ", " "],
        [" ", " ", "o", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", "x", " ", " ", " ", " ", " "],
        [" ", " ", "o", " ", " ", " ", " ", " ", " "]
    ], 9, "x", 4, 2, Diagonal, Answer).

*/



/* ---- FUNÇÕES AUXILIARES ----- */

list_nth([H|_], Index, H) :-
    Index = 0.

list_nth([_|L1], Index, Elem) :-
    Index > 0,
    NewIndex is Index-1,
    list_nth(L1, NewIndex, Elem).



joinColumnInOneList([Row | GameState], X2, Aux, List) :-
    list_nth(Row, X2, Elem),
    append(Aux, [Elem], L1),
    joinColumnInOneList(GameState, X2, L1, List).

joinColumnInOneList([], _, List, List).


joinDiagonalInOneList(GameState, BoardSize, X2, Y2, Aux, Diagonal) :-
    X2 < BoardSize,
    Y2 < BoardSize,
    list_nth(GameState, Y2, Row),
    list_nth(Row, X2, Elem),
    append(Aux, [Elem], L1),
    X3 is X2+1,
    Y3 is Y2+1,
    joinDiagonalInOneList(GameState, BoardSize, X3, Y3, L1, Diagonal).

joinDiagonalInOneList(_, BoardSize, X2, Y2, Diagonal, Diagonal) :-
    X2 = BoardSize ; Y2 = BoardSize.

/* ----- FUNÇÕES QUE INTEGRAM A LÓGICA DO JOGO ----- */


/* -- howManyFriendsInRow = recebe uma lista (que representa uma Row) e um índice de posição (X € [0,8]), e determina quantos amigos (0, 1 ou 2) estão à vista nessa Row -- */

howManyFriendsInRow([], _, _, Count, _, Count).

howManyFriendsInRow([ Piece | Row ], Player, X2, Count, Index, Answer) :-

    X2 > Index,
    Piece = Player,
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, 1, NewIndex, Answer) ;

    X2 > Index,
    Piece \= Player,
    Piece \= " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, 0, NewIndex, Answer) ;

    X2 > Index,
    Piece = " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, Count, NewIndex, Answer) ;

    X2 = Index,
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, Count, NewIndex, Answer) ;

    X2 < Index,
    Piece = " ",
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, Count, NewIndex, Answer) ;

    X2 < Index,
    Piece = Player,
    NewIndex is Index+1,
    NewCount is Count+1,
    howManyFriendsInRow([], Player, X2, NewCount, NewIndex, Answer) ;

    X2 < Index,
    Piece \= Player,
    Piece \= " ",
    NewIndex is Index+1,
    howManyFriendsInRow([], Player, X2, Count, NewIndex, Answer) .

/* -- howManyFriendsInRow = recebe o GameState (Lista de Listas) e junta a coluna X2 (X2 € [0,8]) num único array, depois chama howManyFriendsInRow e determina quantos amigos (0, 1 ou 2) estão à vista nessa Coluna -- */

howManyFriendsInColumn(GameState, Player, X2, Y2, Count, Index, Answer) :-
    joinColumnInOneList(GameState, X2, [], Column),
    howManyFriendsInRow(Column, Player, Y2, Count, Index, Answer).

howManyFriendsInLeftDiagonal(GameState, BoardSize, Player, X2, Y2, Diagonal, Answer):-
    X2 > Y2,
    N is X2-Y2,
    joinDiagonalInOneList(GameState, BoardSize, N, 0, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, Y2, 0, 0, Answer) ;

    Y2 > X2,
    N is Y2-X2,
    joinDiagonalInOneList(GameState, BoardSize, 0, N, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, X2, 0, 0, Answer) ;

    Y2 = X2,
    joinDiagonalInOneList(GameState, BoardSize, 0, 0, [], Diagonal) .


/* X, Y € [1,9] */

howManyFriendsInSight(GameState, Player, X, Y, AnswerRow, AnswerColumn) :-
    Y2 is Y-1,
    list_nth(GameState, Y2, Row),
    X2 is X-1,
    howManyFriendsInRow(Row, Player, X2, 0, 0, AnswerRow),
    howManyFriendsInColumn(GameState, Player, X2, Y2, 0, 0, AnswerColumn).
    