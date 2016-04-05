% controlo(+Comando, +Estado, -NovoEstado)
controlo(on, off, on) :- !.
controlo(on, erro, on) :- !.
controlo(lcd, on, lcd) :- !.
controlo(sint, on, sint) :- !.
controlo(pista, lcd, pista) :- !.
controlo(am, sint, am) :- !.
controlo(fm, sint, fm) :- !.
controlo(freq, am, freqAM) :- !.
controlo(freq, fm, freqFM) :- !.
controlo(off, erro, erro) :- !.
controlo(off, off, erro) :- !.
controlo(off, _, off) :- !.
controlo(_, _, erro).
 
estadoMensagem(off, 'aparelho desligado').
estadoMensagem(erro, 'desligado apos erro, sequencia cmds inutil').
estadoMensagem(on, 'ligado, espera comandos').
estadoMensagem(lcd, 'leitor de CDs escolhido, espera seleccao da pista').
estadoMensagem(pista, 'a ouvir CD').
estadoMensagem(sint, 'radio escolhido, espera seleccao da banda').
estadoMensagem(am, 'banda AM escolhida, espera seleccao da frequencia').
estadoMensagem(fm, 'banda FM escolhida, espera seleccao da frequencia').
estadoMensagem(freqAM, 'a ouvir radio, banda AM').
estadoMensagem(freqFM, 'a ouvir radio, banda FM').
 
controlo(Comandos, E) :-
        controloAux(Comandos, off, Estado),
        estadoMensagem(Estado, E).
controloAux([], Estado, Estado).
controloAux([Comando | Comandos], Estado, NovoEstado) :-
        controlo(Comando, Estado, NovoEstado1),
        controloAux(Comandos, NovoEstado1, NovoEstado).