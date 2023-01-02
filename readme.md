# Programação Funcional e Lógica 2022/2023
## Trabalho Prático 2
O jogo realizado pelo nosso grupo no 2º trabalho prático no âmbito da unidade curricula Programação Funcional e Lógica foi o "Center".

- Grupo: Center_5
- Participantes: 
  - up202004656 - Mariana Solange Mariana Rocha (contribuiçao%)
  - up202007928 - Matilde Maria Amaral Silva    (contribuição%)
  
## Instalação e Execução
### 🐧 Execução do jogo em Linux 
Para a correta execução do programa é necesário ter o SICStus 4.7.1 ou uma versão mais recente.

Para correr o programa, é então necessário consultar o ficheiro `main.pl`. Isto pode-se fazer na linha de comandos:
```
  ?- consult('./play.pl').
  ```
  
### 🪟 Execução do jogo em Windows 
Para a correta execução do programa é necessário ter o SICStus Prolog 4.7.1 ou uma versão mais recente.

Os passos para efetuar a execução:
- abrir o interpretador do SICStus;
- consultar (`File` no canto superior direito -> `Consult` -> escolher o ficheiro) o ficheiro `main.pl`;
- após isso, correr no SICStus `play.`;
- finalmente, podemos utilizar o programa.
  
## Descrição do Jogo
### ♟️ Tabuleiro
O tabuleiro do jogo pode ter formato hexagonal ou quadrangular. A lateral do tabuleiro hexagonal tanto pode ter número ímpar como par de casas. Já se se optar pelo tabuleiro quadrangular número de filas deve ser ímpar, de modo a que o tabuleiro tenha centro. Por questões de simplicidade, optamos pelo tabuleiro 
### 🎯 Gameplay
Os jogadores podem jogar com as peças pretas ou com as brancas.
Para efetuar uma jogada é necessário:
-  que o **número de peças visíveis** numa determinada posição (em qualquer uma das 8 direções) seja **igual ou superior** à distância que a peça se encontra à borda do tabuleiro;
-  essas peças têm de ser da mesma cor da peça em questão.
  
🏆 O vencedor é o primeiro jogador a conseguir colocar uma peça no centro do tabuleiro.

## Lógica do Jogo
### Representação interna do estado do jogo
O estado do jogo é composto por:
- o estado atual do tabuleiro:
  - este é representado por uma **lista de listas** em que cada lista representa uma linha no tabuleiro e cada posição da lista representa um quadrado do tabuleiro. Cada quadrado do tabuleiro não tem diferença em cor, visto que não tem relevância para o jogo.
- a cor do jogador atual:
  - é definida pelo uso dos caracteres `x` e `o`, sendo `x` o `Player 1`, podendo ser considerada a peça branca, e `o` o `Player 2`, a peça preta.

### Estado Inicial (5x5)
```
[
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ']
] 
```
![img](images/initial_state.png)

### Estado Intermédio (5x5)
```
[
    ['x', 'o', 'o', ' ', ' '],
    [' ', 'x', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ']
] 
```
![img](images/intermediate_state.png)

### Estado Final (5x5)
```
[
    ['x', 'o', 'o', ' ', ' '],
    [' ', 'x', 'o', ' ', ' '],
    [' ', ' ', 'x', 'o', ' '],
    [' ', 'x', ' ', ' ', ' '],
    [' ', ' ', 'x', ' ', ' ']
] 
```
![img](images/final_state.png)

### Visualização do estado do jogo
Após o ínicio do jogo, correndo o predicado `play.` é apresentado ao jogador um menu com as seguintes opções:
![img](images/menu.png)
Para escolher uma opção, tudo o que o jogador tem de fazer é escrever o número relativo à opção seguido de um ponto final e premir `Enter`.
As opções `1`, `2` e `3` correspoondem ao modos de jogo disponíveis:
```
1 - Player vs Player
2 - Player vs Computer
3 - Computer vs Computer
```
Após a seleção de qualquer uma dessas três opções é apresentado um ecrã para escolher o tamanho do lado do tabuleiro, sendo este arbitrário e sem limite superior desde que seja um número ímpar. 
Quanto maior o tamanho escolhido, mais tempo demorará o jogo.

Para a opção `1 - Player vs Player`:
Após a seleção do tamanho do tabuleiro, dá-se início ao jogo. O primeiro a jogar é o `Player 1`, seguido do `Player 2`, repetidamente, até ao fim do jogo.

Já para a opção `2 - Player vs Computer`:
Após a escolha do tamanho do tabuleiro, escolhe-se o nível de dificuldade do oponente:
  - Nível 1: o computador escolhe uma jogada aleaória;
  - Nível 2: o computador escolhe a melhor jogada.
Novamente, o `Player 1` é quem joga a primeira jogada (sendo o `Player 1` o jogador, e o `Player 2` o computador), seguido do `Player 2`, mantendo-se este ciclo até ao término da partida.

Na opção `3 - Computer vs Computer`:
Após a escolha do tamanho do tabuleiro, escolhe-se o modo de jogo dos dois computadores:
  - Nível 1: ambos os computadores escolhem uma jogada aleaória;
  - Nível 2: ambos os computadores escolhem a melhor jogada.

Ao iniciar umm jogo, é apresentado um tabuleiro, com a medida escolhida. E conforme seja a vez do jogador ou do computador, apresenta um diálogo a pedir input do jogador ou um diálogo com a jogada efetuada pelo computador.

### Processo de execução de uma jogada
`TO-DO`

### Game Over
A estratégia utilizada para verificar se o jogo chegou ao fim está implementada através do predicado `game_over` que verifica se alguma peça está no centro do tabuleiro, se estiver o jogo acabou e a cor dessa peça sai vencedora da partida.

```prolog
game_over(GameState, Winner) :-
    boardSize(BoardSize),
    D is div(BoardSize, 2),
    list_nth(GameState, D, Row),
    list_nth(Row, D, Winner),
    Winner \= ' ',
    Winner \= " ".
```

### Lista das jogadas válidas
A lista de jogadas válidas está implementada no predicado `valid_moves`. Este chama `getListOfMoves` que recebe o estado do jogo (GameState) e o atual jogador. Verifica que coordenadas são válidas para a inserção de uma nova peça percorrendo todas as células do tabuleiro. Para a verificação da validade das jogadas usa o predicado `legalStonePlacement`. 
No fim de percorrer, `getListOfMoves` junta todas as possíveis jogadas em `ListOfMoves` (uma jogada tem a estrutura [Player, X, Y]) e manda para `valid_moves`. Abaixo o código:


```prolog
legalStonePlacement(GameState, X, Y, Player) :-
    X2 is X-1,
    Y2 is Y-1,
    list_nth(GameState, Y2, Row),
    list_nth(Row, X2, Elem),
    (Elem = ' ' ; Elem = " "),
    howManyFriendsInSight(GameState, Player, X, Y, Friends),
    distanceFromPerimeter(X, Y, Distance),
    Distance =< Friends.
 ```

 ```prolog 
getListOfMoves(GameState, Player, X, Y, Aux, ListOfMoves) :-
    
    boardSize(BoardSize),
    X = BoardSize,
    Y =< BoardSize,
    A is 1,
    B is Y+1,
    legalStonePlacement(GameState, X, Y, Player),
    append([], [Player], L1),
    append(L1, [X], L2),
    append(L2, [Y], Move),
    append(Aux, [Move], L3),
    getListOfMoves(GameState, Player, A, B, L3, ListOfMoves) ;

    boardSize(BoardSize),
    Y =< BoardSize,
    X \= BoardSize,
    A is X+1,
    B is Y,
    legalStonePlacement(GameState, X, Y, Player), !,
    append([], [Player], L1),
    append(L1, [X], L2),
    append(L2, [Y], Move),
    append(Aux, [Move], L3),
    getListOfMoves(GameState, Player, A, B, L3, ListOfMoves), ! ;
    
    
    boardSize(BoardSize),
    Y =< BoardSize,
    X \= BoardSize,
    A is X+1,
    B is Y,
    \+ legalStonePlacement(GameState, X, Y, Player), !,
    getListOfMoves(GameState, Player, A, B, Aux, ListOfMoves), ! ;

    boardSize(BoardSize),
    Y =< BoardSize,
    X = BoardSize,
    A is 1,
    B is Y+1,
    \+ legalStonePlacement(GameState, X, Y, Player), !,
    getListOfMoves(GameState, Player, A, B, Aux, ListOfMoves), ! .

getListOfMoves(_, _, X, Y, Aux, Aux) :-
    boardSize(BoardSize),
    K is BoardSize+1,
    X = 1,
    Y = K.
 ```

 ```prolog
 valid_moves(GameState, Player, ListOfMoves) :-
    getListOfMoves(GameState, Player, 1, 1, [], ListOfMoves).
 ```

### Avaliação do estado do jogo
`TO-DO`

### Jogadas do Computador
`TO-DO`

## Conclusão
### `TO-DO`

## Fontes
- https://boardgamegeek.com/boardgame/360905/center
  
