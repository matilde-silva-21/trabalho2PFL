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
    









/* se quiser a Row, Column = 0, se quiser Column, Row = 0 */
sanitizeInput(Column, Row, Place) :-
    boardSize(BoardSize),
(   (
        number(Column),
        format('What row (Y axis) do you want to place the piece (1..~w)? ', [BoardSize])
    );
    (   number(Row),
        format('What column (X axis) do you want to place the piece (1..~w)? ', [BoardSize])
    )
),
    read(Choice),

(   
    (\+number(Choice),
    nl, write('Mmmmm... That wasn\'t what I was looking for. Let\'s try again'), nl,
    sanitizeInput(Column, Row, Place)) ;


    (number(Choice),
        (
            (Choice > 0,
            Choice =< BoardSize,
            Place is Choice) ;

            (Choice =< 0,
            nl, write('Try a little bit higher. '),
            sanitizeInput(Column, Row, Place)) ;

            (Choice > BoardSize,
            nl, write('That number is out of bonds. '),
            sanitizeInput(Column, Row, Place))

        )
    )
).


getMoveInput(Move, Turn) :-

    nl, format('Player ~w it is your turn!', [Turn]), nl,
    sanitizeInput(_, 0, X), !,
    sanitizeInput(0, _, Y), !,

(
    (   Turn = 2,
        append([], ['o'], L3),
        append(L3, [X], L4),
        append(L4, [Y], Move)
    ) ;

    (   Turn = 1,
        append([], ['x'], L1),
        append(L1, [X], L2),
        append(L2, [Y], Move)
    )
).



    


/* Turn = 1 ou 2 */
/* TODO é preciso ainda recuperar de uma jogada que nao e legal */
personVsPerson(GameState, Turn) :-
    \+game_over(GameState, _),
    display_game(GameState),
    getMoveInput(Move, Turn),
    move(GameState, Move, NewGameState),
    (
        (Turn = 1,
        personVsPerson(NewGameState, 2));

        (Turn = 2,
        personVsPerson(NewGameState, 1))
    );

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

