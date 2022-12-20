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


/*--- drawRow = recebe o array que representa uma row e escreve no terminal com o formato desejado ---*/

drawRow([Elem|Row]) :-

    Elem \= ' ',
    Elem \= " ",
    format('|_~w_', [Elem]),
    drawRow(Row) ;

    write('|___'),
    drawRow(Row).

drawRow([]) :-
    write('|'), nl.




/*--- drawBoard = recebe o GameState e chama drawRow para todas as Rows ---*/

drawBoard([Row|GameState]) :-
    drawRow(Row),
    drawBoard(GameState).

drawBoard([]).


