/* writeGameBanner = formata o nome do jogo para ficar com uma aparência bonita */

writeGameBanner:-
    write('   ____           _            '),nl,
    write('  / ___|___ _ __ | |_ ___ _ __ '),nl,
    write(' | |   / _ \\ \'_ \\| __/ _ \\ \'__|'),nl,
    write(' | |__|  __/ | | | ||  __/ |   '),nl,
    write('  \\____\\___|_| |_|\\__\\___|_|   '),nl,
    write('                               '), nl.
                               
                               
% Game Main Menu

menuChoice(1):-
    write('Great choice :)\n'),
    getBoardSizeInput(BoardSize),
    initial_state(BoardSize, GameState),
    personVsPerson(GameState, 1).
menuChoice(2):-
    write('Great choice :)\n'),
    getBoardSizeInput(BoardSize),
    getComputerLevelInput(Level),
    initial_state(BoardSize, GameState),
    personVsComputer(GameState, 1, Level).
menuChoice(3):-
    write('Great choice :)\n'),
    getBoardSizeInput(BoardSize),
    getComputerLevelInput(Level),
    initial_state(BoardSize, GameState),
    computerVsComputer(GameState, 1, Level).
menuChoice(0):-
    write('Leaving so soon :(\nWe\'ll miss you, goodbye...').
menuChoice(_):-
    write('\nInvalid choice. \nPlease choose a valid option.\n'),
    play.


/* getBoardSizeInput = pede ao utilizador o tamanho de tabuleiro pretendido. feito de modo a recuperar de erros de input. */

getBoardSizeInput(BoardSize):-
    write('What size board do you want? Remember the board must have a center so the size will need to be uneven: '),
    read(Size),
    (
        (   \+number(Size),
            nl, write('Sorry, you need to write a number!'), nl,
            getBoardSizeInput(BoardSize)
        );

        (   number(Size),
            divisible(Size, 2),
            nl, write('Sorry, the size can not be even!'), nl,
            getBoardSizeInput(BoardSize)
        );

        (
            number(Size),
            format('You have chosen ~w as your board size! Now, let\'s play!\n', [Size]),
            BoardSize is Size
        ) 
    ).


/* getComputerLevelInput = pede ao utilizador o nível do computador com o qual é pretendido jogar. feito de modo a recuperar de erros de input. */

getComputerLevelInput(Level):-
    write('\nThe Computer plays at 2 distinct levels.\nLevel 1 chooses a move at random, Level 2 chooses the best move. What Level (1 or 2) do you wish to play? '),
    read(Choice),
    (
        (   \+number(Choice),
            nl, write('Sorry, you need to write a number!'), nl,
            getComputerLevelInput(Level)
        );

        (   number(Choice), (Choice < 1 ; Choice > 2),
            nl, write('Sorry, you can only choose 1 or 2!'), nl,
            getComputerLevelInput(Level)
        );

        (
            number(Choice), (Choice = 1 ; Choice = 2),
            format('You have chosen Level ~w! Now, let\'s play!\n', [Level]),
            Level is Choice
        ) 
    ).



/* sanitizeInput = função que recebe a Row e Column do jogador e verifica se foram inseridos números e se esses números estão dentro dos limites do tabuleiro. Se quiser a Row, Column = 0, se quiser Column, Row = 0 */

sanitizeInput(Column, Row, Place) :-
    boardSize(BoardSize),
(   (
        number(Column),
        format('What row (Y axis) do you want to place the piece (1..~w)? Don\'t forget the dot at the end: ', [BoardSize])
    );
    (   number(Row),
        format('What column (X axis) do you want to place the piece (1..~w)? Don\'t forget the dot at the end: ', [BoardSize])
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


/* getMoveInput = chama sanitizeInput e depois cria o array Move */

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

/* getLegalMove = chama o getMoveInput, que garante que o input está sanitizado, e depois verifica se a jogada inserida, além de válida, é legal */

getLegalMove(GameState, NewGameState, Turn) :-
    getMoveInput(Move, Turn),
    (
        (
            move(GameState, Move, NewGameState)
        );
        (
            \+ move(GameState, Move, NewGameState),
            nl, write('Sorry, you can\'t place your stone there!\n'),
            getLegalMove(GameState, NewGameState, Turn)
        )
    ).