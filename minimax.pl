/* getListOfScores = recebe ListOfMoves e GameState atual. Para cada Move, calcula o Value de NewGameState (obtido após executar Move) */

getListOfScores(_, [], _).

getListOfScores(GameState, [Move|ListOfMoves], [Value|ListOfScores]):-
    list_nth(Move, 0, Player),
    move(GameState, Move, NewGameState),
    value(NewGameState, Player, Value),
    getListOfScores(GameState, ListOfMoves, ListOfScores).


/* evaluateInTwos = recebe lista de Values (ListOfScores) e avalia o Min ou Max de cada dois elementos da lista. Se lista for ímpar, o último valor é colocado na lista Reduced sem critério de seleção */

evaluateInTwos([], [], [], [], _).

evaluateInTwos([M|[]], [S|[]], [M|[]], [S|[]], _).

evaluateInTwos([M1, M2 | ListOfMoves], [S1, S2 | ListOfScores], [MoveOption | ReducedMoves], [ScoreOption | ReducedScores], Criteria) :-
    ((Criteria = 0,
    (
        S1 >= S2,
        ScoreOption is S1,
        clone(M1, MoveOption) ;

        S2 > S1,
        ScoreOption is S2,
        clone(M2, MoveOption)
    )) ;

    (Criteria = 1,
    (
        S1 =< S2,
        ScoreOption is S1,
        clone(M1, MoveOption) ;

        S2 < S1,
        ScoreOption is S2,
        clone(M2, MoveOption)
    )
    )),
    evaluateInTwos(ListOfMoves, ListOfScores, ReducedMoves, ReducedScores, Criteria).



/* minimax = chama recursivamente evaluateInTwos e alterna entre seleção de Min values ou Max values */

minimax(ListOfMoves, ListOfScores, Criteria, BestMove) :-
    ((Criteria = 0, NewCriteria is 1) ; (Criteria = 1, NewCriteria is 0)),
    length(ListOfMoves, L),
    L \= 1,
    evaluateInTwos(ListOfMoves, ListOfScores, ReducedMoves, ReducedScores, Criteria),
    minimax(ReducedMoves, ReducedScores, NewCriteria, BestMove).

minimax([Move|[]], ListOfScores, _, Move) :-
    length(ListOfScores, L),
    L = 1.



/* chooseBestMove = recebe GameState e Player e, através do algoritmo Minimax, decide a melhor jogada */

chooseBestMove(GameState, Player, BestMove):-
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves),
    boardSize(BoardSize),
    D is div(BoardSize, 2)+1,
    append([], [Player], L1),
    append(L1, [D], L2),
    append(L2, [D], Move),
    count(Move, ListOfMoves, N),

    ((N > 0,
    clone(Move, BestMove)) ;

    (N = 0,
    getListOfScores(GameState, ListOfMoves, ListOfScores),
    length(ListOfScores, L),
    (
        divisible(L, 2),
        Levels is div(L, 2) ;

        \+divisible(L, 2),
        Levels is div(L, 2)+1
    ),

    (
        divisible(Levels, 2),
        minimax(ListOfMoves, ListOfScores, 0, BestMove), ! ;

        \+divisible(Levels, 2),
        minimax(ListOfMoves, ListOfScores, 1, BestMove), !
    ))).

