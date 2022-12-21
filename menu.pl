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


