:-[logic].
:-[board].
:-[menu].
:-[minimax].
:-[playing_mode].
:-use_module(library(random)).

/* Move = [Player, X, Y] */
move(GameState, Move, NewGameState) :-
    list_nth(Move, 0, Player),
    list_nth(Move, 1, X),
    list_nth(Move, 2, Y),
    placeStone(GameState, Player, X, Y, NewGameState).


display_game(GameState) :-
    boardSize(BoardSize),
    Size is 3*BoardSize+BoardSize-1,
    nl, writeColumnNumbers(1), nl,
    write(' '),
    writeCharNTimes(Size, '_'), nl,
    drawBoard(GameState, 1), !.


initial_state(Size, GameState) :-
    \+ divisible(Size, 2),
    retractall(boardSize(_)),
    assert(boardSize(Size)),
    getGameState(Size, GameState, [], Size), !.


valid_moves(GameState, Player, ListOfMoves) :-
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves).


game_over(GameState, Winner) :-
    boardSize(BoardSize),
    D is div(BoardSize, 2),
    list_nth(GameState, D, Row),
    list_nth(Row, D, Winner),
    Winner \= ' ',
    Winner \= " ".
    

/* Value = o número de amigos que nos faltam ver (do ponto de vista do centro), para poder vencer o jogo. Quanto mais pequeno o valor melhor */

value(GameState, Player, Value) :-
    boardSize(BoardSize),
    Middle is div(BoardSize, 2)+1,
    howManyFriendsInSight(GameState, Player, Middle, Middle, Answer),
    distanceFromPerimeter(Middle, Middle, Distance),
    Value is Distance-Answer.


choose_move(GameState, Player, Level, Move) :-
    Level = 1,
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves),
    length(ListOfMoves, Size),
    random(0,Size,Random),
    list_nth(ListOfMoves, Random, Move) ;

    Level = 2,
    chooseBestMove(GameState, Player, Move).


play:-
    writeGameBanner,
    write('Please choose one of the playing modes:\n'),
    write('     1. Player vs Player\n'),
    write('     2. Player vs Computer\n'),
    write('     3. Computer vs Computer\n'),
    write('     0. Leave Game\n'),
    read(Choice),
    menuChoice(Choice).



/*

initial_state(5, G), personVsPerson(G, 1).

initial_state(7, GameState), computerVsComputer(GameState, 1, 1).

initial_state(5, G), chooseBestMove(G, 'x', BestMove).
__P1__|__P2__
(5,1) | (1,3)
(5,8) | (9,3)
(5,3) | (5,7)
(8,8) | (7,5)
(2,8) | (7,7)
(7,3) | (3,5)
(3,3) | (5,5)

-- computador --

choose_move(+GameState, +Player, +Level, -Move).

O nível 2 deverá devolver a melhor jogada no momento (algoritmo greedy), tendo em conta a avaliação do estado de jogo.

*/

