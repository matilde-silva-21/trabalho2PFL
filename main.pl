:-[logic].
:-[board].
:-[menu].

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


/* Turn = 'x' ou 'o' */
personVsPerson(GameState, Turn) :-
    (Turn = 'o' ; Turn = "o"),
    \+ game_over(GameState, Winner),
    display_game(GameState),
    getMoveInput(Move, Turn),   /* "Player 2 it is your turn! What column (X axis) do you want to place the piece (1..BoardSize)? --input-- What row (Y axis) do you want to place the piece (1..BoardSize)? --input-- */
    verifyMove(Move), /* incluir a parte da verificaçao no getMoveInput? */
    move(GameState, Move, NewGameState),
    personVsPerson(NewGameState, 'x') ; 
    
    
    (Turn = 'x' ; Turn = "x"),
    \+ game_over(GameState, W),
    display_game(GameState),
    getMoveInput(Move, Turn),
    verifyMove(),
    move(GameState, Move, NewGameState),
    personVsPerson(NewGameState, 'o') ;

    game_over(GameState, Winner),
    (Winner = 'x' ; Winner = "x"),
    write('Congratulations, Player 1, you won!') ;

    game_over(GameState, Winner),
    (Winner = 'o' ; Winner = "o"),
    write('Congratulations, Player 2, you won!').



/* TODO


value(+GameState, +Player, -Value).

-- computador --

choose_move(+GameState, +Player, +Level, -Move).

O nível 1 deverá devolver uma jogada válida aleatória. O nível 2 deverá
devolver a melhor jogada no momento (algoritmo greedy), tendo em conta a avaliação
do estado de jogo.

*/

