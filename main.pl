:-[logic].

/* Move = [Player, X, Y] 
move(GameState, Move, NewGameState) :-
    list_nth(Move, 0, Player),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    legalStonePlacement(GameState, 9, X, Y, Player),
    placeStone(GameState, Player, X, Y, NewGameState, 9).*/

