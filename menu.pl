% Game Main Menu

menuChoice(1):-
    write('good choice :) pvp').
menuChoice(2):-
    write('ok chice ig... pvc').
menuChoice(3):-
    write('you dont wanna play? cvc').
menuChoice(0):-
    write('byee').
menuChoice(_):-
    write('\nInvalid choice. \nPlease choose a valid option.\n'),
    play.


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
            nl, write('Sorry, you can\'t place your stone there!'),
            getLegalMove(GameState, NewGameState, Turn)
        )
    ).