extraer(X, [X|L], L).
extraer(X, [Y|L], [Y|R]):-not(X=Y), extraer(X,L,R).

pertenece(X, [X|_]).
pertenece(X, [_|Y]) :- pertenece(X,Y).
perteneceLista([], _).
perteneceLista([H|T], L):- pertenece(H,L), perteneceLista(T,L).

insertar(X,L,[X|L]).

append([],L,L).
append([H|T],L2,[H|L3]):-append(T,L2,L3).

viajar(OE1,OE2,A,OS1,OS2):-
    extraer(A, OE1, OS1),
    insertar(A, OE2, OS2).

/* Condiciones de Movimientos */
/* IZQUIERDA A DERECHA */

mover(OE1,OE2,OS1,OS2):- pertenece(pastor,OE1), pertenece(oveja,OE1), 
    viajar(OE1,OE2,oveja,Q,P), viajar(Q,P,pastor,OS1,OS2).

mover(OE1,OE2,OS1,OS2):-pertenece(pastor,OE1),pertenece(col,OE1),  
    viajar(OE1,OE2,col,Q,P), viajar(Q,P,pastor,OS1,OS2), 
    not(perteneceLista([oveja,lobo],OE1)).

mover(OE1,OE2,OS1,OS2):-pertenece(pastor,OE1), pertenece(lobo,OE1), 
    viajar(OE1,OE2,lobo,Q,P), viajar(Q,P,pastor,OS1,OS2), 
    not(perteneceLista([oveja,col],OE1)).

mover(OE1,OE2,OS1,OS2):-viajar(OE1,OE2,pastor,OS1,OS2), 
    not(perteneceLista([oveja,col],OE1)) | not(perteneceLista([oveja,lobo],OE1)).

/* DERECHA A IZQUIERDA */

mover(OE1,OE2,OS1,OS2):- pertenece(pastor,OE2), pertenece(oveja,OE2), 
    viajar(OE2,OE1,oveja,Q,P), viajar(Q,P,pastor,OS2,OS1).

mover(OE1,OE2,OS1,OS2):- pertenece(pastor,OE2), pertenece(col,OE2), 
    viajar(OE2,OE1,col,Q,P), viajar(Q,P,pastor,OS2,OS1), 
    not(perteneceLista([oveja,lobo],OE2)).

mover(OE1,OE2,OS1,OS2):- pertenece(pastor,OE2), pertenece(lobo,OE1), 
    viajar(OE2,OE1,lobo,Q,P), viajar(Q,P,pastor,OS2,OS1), 
    not(perteneceLista([oveja,col],OE2)).

mover(OE1,OE2,OS1,OS2):-viajar(OE2,OE1,pastor,OS2,OS1), 
    not(perteneceLista([oveja,col],OE2)) | not(perteneceLista([oveja,lobo],OE2)).

/* Solución */

sol([],_,ACC,ACC).
sol(OE1, OE2, ACC, RESULT):- mover(OE1,OE2,OS1,OS2), not(pertenece([OS1,OS2],ACC)), 
    append(ACC,[[OS1,OS2]],ACC2),sol(OS1,OS2,ACC2,RESULT).