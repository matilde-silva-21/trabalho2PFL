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
### `TO-DO`

## Conclusão
### `TO-DO`

## Fontes
- https://boardgamegeek.com/boardgame/360905/center
  