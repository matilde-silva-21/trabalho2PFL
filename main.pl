:-[logic].
:-[board].
:-[menu].

/* Move = [Player, X, Y] */
move(GameState, Move, NewGameState) :-
    list_nth(Move, 0, Player),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    placeStone(GameState, Player, X, Y, NewGameState).


display_game(GameState) :-
    boardSize(BoardSize),
    Size is 3*BoardSize+BoardSize-1,
    write(' '),
    writeCharNTimes(Size, '_'), nl,
    drawBoard(GameState), !.


initial_state(Size, GameState) :-
    \+ divisible(Size, 2),
    retractall(boardSize(_)),
    assert(boardSize(Size)),
    getGameState(Size, GameState, [], Size), !.


valid_moves(GameState, Player, ListOfMoves) :-
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves).



play:-
    write('\n\n----Center Game---\n\n'),
    write('1. Player vs Player\n'),
    write('2. Player vs Computer\n'),
    write('3. Computer vs Computer\n'),
    write('0. Leave Game\n'),
    read(Choice),
    menuChoice(Choice).



game_over(GameState, Winner) :-
    boardSize(BoardSize),
    D is div(BoardSize, 2),
    list_nth(GameState, D, Row),
    list_nth(Row, D, Winner),
    Winner \= ' ',
    Winner \= " ".
    
    

/* Turn = 1 ou 2 */

personVsPerson(GameState, Turn) :-
    \+game_over(GameState, _),
    display_game(GameState),
    getLegalMove(GameState, NewGameState, Turn),
    (
        (Turn = 1,
        personVsPerson(NewGameState, 2));

        (Turn = 2,
        personVsPerson(NewGameState, 1))
    );

    game_over(GameState, Winner),
    (Winner = 'x' ; Winner = "x"),
    nl, write('Congratulations, Player 1, you won!') ;

    game_over(GameState, Winner),
    (Winner = 'o' ; Winner = "o"),
    nl, write('Congratulations, Player 2, you won!').



/* TODO

initial_state(9, G), personVsPerson(G, 1).

value(+GameState, +Player, -Value).

-- computador --

choose_move(+GameState, +Player, +Level, -Move).

O nível 1 deverá devolver uma jogada válida aleatória. O nível 2 deverá
devolver a melhor jogada no momento (algoritmo greedy), tendo em conta a avaliação
do estado de jogo.

*/

