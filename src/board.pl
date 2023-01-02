/*
3*BoardSize + BoardSize --- para o teto
3*BoardSize + BoardSize + 1 -- para as paredes
     ___________________________________
    |___|___|___|___|_x_|___|___|___|___|
    |___|___|___|___|___|___|___|___|___|
    |_o_|___|_x_|___|_x_|___|_x_|___|_o_|
    |___|___|___|___|___|___|___|___|___|
    |___|___|_o_|___|_o_|___|_o_|___|___|
    |___|___|___|___|___|___|___|___|___|
    |___|___|___|___|_o_|___|_o_|___|___|
    |___|___|_x_|___|_x_|___|_x_|___|___|
    |___|___|___|___|___|___|___|___|___|
    
    
*/


/*---- FUNÇÕES QUE AUXILIAM A FORMATAÇÃO DO TABULEIRO NO TERMINAL ----*/

/*--- writeCharNTimes = função que dado um N e um Char, escreve Char N vezes (não insere new line no final) ---*/

writeCharNTimes(N, Char):-
    N > 0,
    write(Char),
    New is N-1,
    writeCharNTimes(New, Char) ;
    N = 0.

/*--- writeColumnNumbers = função que escreve o numero das colunas em cima do tabuleiro ---*/

writeColumnNumbers(N):-
    boardSize(BoardSize),
    N =< BoardSize,
    format('  ~w ', [N]),
    New is N+1,
    writeColumnNumbers(New) ;
    N = BoardSize.

/*--- drawRow = recebe o array que representa uma row e escreve no terminal com o formato desejado ---*/

drawRow([Elem|Row], Count) :-

    Elem \= ' ',
    Elem \= " ",
    format('|_~w_', [Elem]),
    drawRow(Row, Count) ;

    write('|___'),
    drawRow(Row, Count).

drawRow([], Count) :-
    format('|  ~w', [Count]),nl.



/*--- drawBoard = recebe o GameState e chama drawRow para todas as Rows ---*/

drawBoard([Row|GameState], Count) :-
    drawRow(Row, Count),
    NewCount is Count+1,
    drawBoard(GameState, NewCount).

drawBoard([], _).

/*--- getGameState = recebe o tamanho do tabuleiro e povoa GameState ---*/

getGameState(Size, GameState, Aux, Counter) :-
    Counter > 0,
    replicate(Size, ' ', L1),
    append(Aux, [L1], L2),
    New is Counter-1,
    getGameState(Size, GameState, L2, New), !.

getGameState(_, Aux, Aux, 0).


