/*
              A    B    C    D    E    F    G    H    I
        (X)   1    2    3    4    5    6    7    8    9
        (X2)  0    1    2    3    4    5    6    7    8
 (Y) (Y2)
  1   0    [[" ", " ", " ", " ", " ", " ", " ", " ", " "],
  2   1     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  3   2     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  4   3     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  5   4     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  6   5     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  7   6     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  8   7     [" ", " ", " ", " ", " ", " ", " ", " ", " "],
  9   8     [" ", " ", " ", " ", " ", " ", " ", " ", " "]]


display_game(
[
[' ', ' ', 'x', ' ', ' ', ' ', ' ', ' ', ' '],
[' ', ' ', 'o', ' ', ' ', ' ', ' ', ' ', ' '],
[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
[' ', ' ', ' ', ' ', ' ', 'o', ' ', ' ', ' '],
[' ', ' ', ' ', ' ', ' ', ' ', 'x', ' ', ' '],
[' ', ' ', 'o', ' ', 'o', ' ', 'x', ' ', ' '],
[' ', ' ', 'o', ' ', ' ', ' ', ' ', ' ', ' '],
[' ', ' ', ' ', 'x', ' ', ' ', ' ', ' ', ' '],
['x', ' ', 'o', ' ', ' ', ' ', ' ', ' ', ' ']]).

*/



/* ---- FUNÇÕES AUXILIARES ----- */

list_nth([H|_], Index, H) :-
    Index = 0.

list_nth([_|L1], Index, Elem) :-
    Index > 0,
    NewIndex is Index-1,
    list_nth(L1, NewIndex, Elem).


/* -------- */

list_size([], 0).

list_size([_ | Tail], Size) :- 
    list_size(Tail, N),
    Size is N+1.

/* -------- */

list_slice(L1, Index, Size, L2) :-
    list_slice_helper(L1, Index, Size, L2, []).

list_slice_helper(_, 0, 0, L2, L2).

list_slice_helper([H|L1], Index, Size, L2, L3) :-
    Index \= 0,
    Size \= 0,
    New is Index-1,
    list_slice_helper(L1, New, Size, L2, []) ;
    Index = 0,
    Size \= 0,
    New is Size-1,
    append(L3, [H], L4),
    list_slice_helper(L1, Index, New, L2, L4).

/* -------- */

replicate(Amount, Elem, L1) :- replicate_helper(Amount, Elem, [], L1).

replicate_helper(0, _, L1, L1).
replicate_helper(Amount, Elem, L1, L2) :-
    N is Amount-1,
    replicate_helper(N, Elem, [Elem|L1], L2).

/* -------- */

divisible(X,Y) :- 0 is X mod Y, !.

/* -------- */

joinColumnInOneList([Row | GameState], X2, Aux, List) :-
    list_nth(Row, X2, Elem),
    append(Aux, [Elem], L1),
    joinColumnInOneList(GameState, X2, L1, List).

joinColumnInOneList([], _, List, List).

/* -------- */

joinLeftDiagonalInOneList(GameState, X2, Y2, Aux, Diagonal) :-
    boardSize(BoardSize),
    X2 < BoardSize,
    Y2 < BoardSize,
    list_nth(GameState, Y2, Row),
    list_nth(Row, X2, Elem),
    append(Aux, [Elem], L1),
    X3 is X2+1,
    Y3 is Y2+1,
    joinLeftDiagonalInOneList(GameState, X3, Y3, L1, Diagonal), !.

joinLeftDiagonalInOneList(_, X2, Y2, Diagonal, Diagonal) :-
    boardSize(BoardSize),
    X2 = BoardSize ; Y2 = BoardSize.

/* -------- */

joinRightDiagonalInOneList(GameState, X2, Y2, Aux, Diagonal) :-
    list_nth(GameState, Y2, Row),
    list_nth(Row, X2, Elem),
    append(Aux, [Elem], L1),
    X3 is X2+1,
    Y3 is Y2-1,
    joinRightDiagonalInOneList(GameState, X3, Y3, L1, Diagonal), !.

joinRightDiagonalInOneList(_, X2, Y2, Diagonal, Diagonal) :-
    boardSize(BoardSize),
    X2 = BoardSize ; Y2 = -1.

/* -------- */

getVerticalDistance(Y, VerticalDistance) :-
    boardSize(BoardSize),
    D is div(BoardSize, 2),
    Y > D,
    VerticalDistance is BoardSize-Y ;

    boardSize(BoardSize),
    D is div(BoardSize, 2),
    Y =< D,
    VerticalDistance is Y.

/* -------- */

getHorizontalDistance(X, HorizontalDistance) :-
    boardSize(BoardSize),
    D is div(BoardSize, 2),
    X > D,
    HorizontalDistance is BoardSize-X ;

    boardSize(BoardSize),
    D is div(BoardSize, 2),
    X =< D,
    HorizontalDistance is X.


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
    Piece \= ' ',
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, 0, NewIndex, Answer) ;

    X2 > Index,
    (Piece = " " ; Piece = ' '),
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, Count, NewIndex, Answer) ;

    X2 = Index,
    NewIndex is Index+1,
    howManyFriendsInRow(Row, Player, X2, Count, NewIndex, Answer) ;

    X2 < Index,
    (Piece = " " ; Piece = ' '),
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
    Piece \= ' ',
    NewIndex is Index+1,
    howManyFriendsInRow([], Player, X2, Count, NewIndex, Answer) .

/* -- howManyFriendsInColumn = recebe o GameState (Lista de Listas) e junta a coluna X2 (X2 € [0,8]) num único array, depois chama howManyFriendsInRow e determina quantos amigos (0, 1 ou 2) estão à vista nessa Coluna -- */

howManyFriendsInColumn(GameState, Player, X2, Y2, Count, Index, Answer) :-
    joinColumnInOneList(GameState, X2, [], Column),
    howManyFriendsInRow(Column, Player, Y2, Count, Index, Answer).


/* -- howManyFriendsInLeftDiagonal = recebe o GameState (Lista de Listas) e coordenadas de uma posição (X2, Y2 € [0,8]), e transforma a diagonal esquerda num único array, depois chama howManyFriendsInRow e determina quantos amigos (0, 1 ou 2) estão à vista nessa Diagonal -- */

howManyFriendsInLeftDiagonal(GameState, Player, X2, Y2, Answer):-
    X2 > Y2,
    N is X2-Y2,
    joinLeftDiagonalInOneList(GameState, N, 0, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, Y2, 0, 0, Answer) ;

    Y2 > X2,
    N is Y2-X2,
    joinLeftDiagonalInOneList(GameState, 0, N, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, X2, 0, 0, Answer) ;

    Y2 = X2,
    joinLeftDiagonalInOneList(GameState, 0, 0, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, X2, 0, 0, Answer).


/* -- howManyFriendsInRightDiagonal = recebe o GameState (Lista de Listas) e coordenadas de uma posição (X2, Y2 € [0,8]), e transforma a diagonal direita num único array, depois chama howManyFriendsInRow e determina quantos amigos (0, 1 ou 2) estão à vista nessa Diagonal -- */

howManyFriendsInRightDiagonal(GameState, Player, X2, Y2, Answer):-
    boardSize(BoardSize),
    N is X2+Y2,
    P is BoardSize-1,
    N =< P,
    joinRightDiagonalInOneList(GameState, 0, N, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, X2, 0, 0, Answer) ;

    boardSize(BoardSize),
    N is X2+Y2,
    P is BoardSize-1,
    N > P,
    K is N-BoardSize+1,
    J is X2-K,
    joinRightDiagonalInOneList(GameState, K, P, [], Diagonal),
    howManyFriendsInRow(Diagonal, Player, J, 0, 0, Answer) .



/* howManyFriendsInSight = recebe o GameState e coordenadas de posição (X, Y € [1,9]) e calcula quantos amigos estão à vista */

howManyFriendsInSight(GameState, Player, X, Y, Answer) :-
    Y2 is Y-1,
    list_nth(GameState, Y2, Row),
    X2 is X-1,
    howManyFriendsInRow(Row, Player, X2, 0, 0, AnswerRow),
    howManyFriendsInColumn(GameState, Player, X2, Y2, 0, 0, AnswerColumn),
    howManyFriendsInLeftDiagonal(GameState, Player, X2, Y2, AnswerLeftDiagonal),
    howManyFriendsInRightDiagonal(GameState, Player, X2, Y2, AnswerRightDiagonal),
    Answer is (AnswerRow + AnswerColumn + AnswerLeftDiagonal + AnswerRightDiagonal).

/* distanceFromPerimeter = calcula a Distance mais curta das coordenadas dadas (X, Y € [1,9]) até ao perímetro do tabuleiro */

distanceFromPerimeter(X, Y, Distance) :-
    
    getHorizontalDistance(X, HorizontalDistance),
    getVerticalDistance(Y, VerticalDistance),
    VerticalDistance =< HorizontalDistance,
    Distance is VerticalDistance-1 ;

    getHorizontalDistance(X, HorizontalDistance),
    getVerticalDistance(Y, VerticalDistance),
    VerticalDistance > HorizontalDistance,
    Distance is HorizontalDistance-1.


/* legalStonePlacement = recebe o GameState, coordenadas (X, Y € [1,9]) e jogador e verifica se a peça pode ser colocada na posição dita */

legalStonePlacement(GameState, X, Y, Player) :-
    X2 is X-1,
    Y2 is Y-1,
    list_nth(GameState, Y2, Row),
    list_nth(Row, X2, Elem),
    (Elem = ' ' ; Elem = " "),
    howManyFriendsInSight(GameState, Player, X, Y, Friends),
    distanceFromPerimeter(X, Y, Distance),
    Distance =< Friends.


/* placeStone = recebe o GameState, coordenadas (X, Y € [1,9]) e jogador. Primeiro, verifica se a o local de jogada é válido, se for, unifica NewGameState com o tabuleiro atualizado (com a peça nas coordenadas pretendidas) */

placeStone(GameState, Player, X, Y, NewGameState, BoardSize) :-
    legalStonePlacement(GameState, X, Y, Player), !,
    boardSize(BoardSize),
    X2 is X-1,
    Y2 is Y-1,
    L is BoardSize-X,
    K is BoardSize-Y,
    list_nth(GameState, Y2, Row),
    list_slice(Row, 0, X2, Part1), !,
    list_slice(Row, X, L, Part2), !,
    append(Part1, [Player], L1), !,
    append(L1, Part2, NewRow), !,
    list_slice(GameState, 0, Y2, Part3), !,
    list_slice(GameState, Y, K, Part4), !,
    append(Part3, [NewRow], L2), !,
    append(L2, Part4, NewGameState), !.


