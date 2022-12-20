:-[logic].
:-[board].

/* Move = [Player, X, Y] */
move(GameState, Move, NewGameState) :-
    list_nth(Move, 0, Player),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    placeStone(GameState, Player, X, Y, NewGameState, 9).


display_game(GameState) :-
    Size is 3*9+9-1,
    write(' '),
    writeCharNTimes(Size, '_'), nl,
    drawBoard(GameState).




