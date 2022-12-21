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


/* TODO

valid_moves(+GameState, +Player, -ListOfMoves).

game_over(+GameState, -Winner).

value(+GameState, +Player, -Value).

-- computador --

value(+GameState, +Player, -Value).

O nível 1 deverá devolver uma jogada válida aleatória. O nível 2 deverá
devolver a melhor jogada no momento (algoritmo greedy), tendo em conta a avaliação
do estado de jogo. 

*/



