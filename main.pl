:-[logic].
:-[board].

/* Move = [Player, X, Y] */
move(GameState, Move, NewGameState) :-
    list_nth(Move, 0, Player),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    boardSize(BoardSize),
    placeStone(GameState, Player, X, Y, NewGameState, BoardSize).


display_game(GameState) :-
    boardSize(BoardSize),
    Size is 3*BoardSize+BoardSize-1,
    write(' '),
    writeCharNTimes(Size, '_'), nl,
    drawBoard(GameState).


initial_state(Size, GameState) :-
    \+ divisible(Size, 2),
    retractall(boardSize(_)),
    assert(boardSize(Size)),
    getGameState(Size, GameState, [], Size), !,
    display_game(GameState), !.



