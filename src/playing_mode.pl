/* Este ficheiro contém os playing modes possíveis */
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
    display_game(GameState),
    (Winner = 'x' ; Winner = "x"),
    nl, write('Congratulations, Player 1, you won!') ;

    game_over(GameState, Winner),
    display_game(GameState),
    (Winner = 'o' ; Winner = "o"),
    nl, write('Congratulations, Player 2, you won!').


personVsComputer(GameState, Turn, Level):-
    
    \+game_over(GameState, _),
    display_game(GameState),
    (
        (Turn = 1) ;

        (Turn = 2,
        choose_move(GameState, 'o', Level, Move),
        move(GameState, Move, NewGameState),
        list_nth(Move, 1, X),
        list_nth(Move, 2, Y),
        nl, format('The computer placed a piece on column number ~w and row number ~w!', [X, Y]),nl) 
    ),

    (
        (Turn = 1,
        getLegalMove(GameState, NewGameState, Turn),
        personVsComputer(NewGameState, 2, Level)) ;

        (Turn = 2,
        personVsComputer(NewGameState, 1, Level))
    );

    game_over(GameState, Winner),
    display_game(GameState),
    (Winner = 'x' ; Winner = "x"),
    nl, write('Congratulations, you won!') ;

    game_over(GameState, Winner),
    display_game(GameState),
    (Winner = 'o' ; Winner = "o"),
    nl, write('Sorry, the computer won :(').



computerVsComputer(GameState, Turn, Level):-
    \+game_over(GameState, _),
    display_game(GameState),
    (
        (Turn = 1,
        choose_move(GameState, 'x', Level, Move),
        NewTurn is 2);

        (Turn = 2,
        choose_move(GameState, 'o', Level, Move),
        NewTurn is 1)
    ),
    move(GameState, Move, NewGameState),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    format('\nComputer ~w placed a piece on column number ~w and row number ~w!\n', [Turn, X, Y]),
    computerVsComputer(NewGameState, NewTurn, Level) ;


    game_over(GameState, Winner),
    display_game(GameState),
    (Winner = 'x' ; Winner = "x"),
    nl, write('Computer 1 won!') ;

    game_over(GameState, Winner),
    display_game(GameState),
    (Winner = 'o' ; Winner = "o"),
    nl, write('Computer 2 won!').