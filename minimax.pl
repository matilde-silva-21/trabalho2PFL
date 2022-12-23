
minimax(GameState, Move, Val, Player)  :-
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves), !,
    best(ListOfMoves, Move, Val, GameState, Player).

best([Move], Move, Val, _, _)  :-
    minimax(Move, _, Val), !.

best([Move | ListOfMoves], BestMove, BestVal, GameState, Player)  :-
    move(GameState, Move, NewGameState),
    value(NewGameState, Player, Val1),
    minimax(Move, _, Val1),
    best(ListOfMoves, Move2, Val2, GameState, Player),
    betterof(Move, Val1, Move2, Val2, BestMove, BestVal).

betterof(Move0, Val0, _, Val1, Move0, Val0) :-        % Move0 better than Move1                                    % MIN to move in Move0
    Val0 < Val1, !                                     % MAX prefers the greater value
    ;                                % MAX to move in Move0
    Val0 > Val1, !.                                % MIN prefers the lesser value 

betterof(_, _, Move1, Val1, Move1, Val1).           % Otherwise Move1 better than Move0



