ibt(empty).
ibt(node(N, L, R)):- integer(N), ibt(L), ibt(R).

size(empty,0).
size(ibt(node(N, L, R)),S):-
            size(ibt(L),A),
            size(ibt(R),B),
            S is 1+A+B.

height(empty,0).
height(ibt(node(N, L, R)),S):-
        height(ibt(L),A),
        height(ibt(R),B),
        S is 1 + max(A, B).

preorder(empty,[]).
preorder(ibt(node(N, L, R)), List):-
    preorder(ibt(L),LList),  
    preorder(ibt(R),RList),  
    List is [N|LList|RList].