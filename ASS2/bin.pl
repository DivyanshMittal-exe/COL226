ibt(empty).
ibt(node(N,L,R)):- integer(N),ibt(L),ibt(R).

size(ibt(empty),0).
size(BT,Size):-
    ibt(node(_,L,R)) = BT,
    Size is 1 + size(L) + size(R).

height(ibt(empty),0).
height(BT,Height):-
    ibt(node(_,L,R)) = BT,
    Height is 1 + max(height(L),height(R)).


preorder(ibt(empty),[]).
preorder(BT,List):-
    ibt(node(N,L,R)) = BT,
    preorder(L,LeftList),
    preorder(R,RightList),  
    append([N|LeftList],RightList,List).

inorder(ibt(empty),[]).
inorder(BT,List):-
    % BT = ibt(node(N,L,R)),
    ibt(node(N,L,R)) = BT,
    inorder(L,LeftList),
    inorder(R,RightList),
    append(LeftList,[N],LL), 
    append(LL,RightList,List).
    
postorder(ibt(empty),[]).
postorder(BT,List):-
    ibt(node(N,L,R)) = BT,
    postorder(L,LeftList),
    postorder(R,RightList),
    append(RightList,[N],RR), 
    append(LeftList,RR,List).


toString(ibt(empty),"()").
toString(BT,S):-
    ibt(node(N,L,R)) = BT,
    toString(L,LeftString),
    toString(R,RightString),
    number_string(N,N_String),
    string_concat("(",N_String,S1),
    string_concat(S1,",",S2),
    string_concat(S2,LeftString,S3),
    string_concat(S3,",",S4),
    string_concat(S4,RightString,S5),
    string_concat(S5,")",S).


isBalanced(BT):-
    ibt(node(_,L,R)) = BT,
    height(L,LeftH),
    height(R,RightH),
    LeftH - RightH =:= 1;
    RightH - LeftH =:= -1;
    RightH - LeftH =:= 0.

removeLast([_],[]).
removeLast([H|T],[H|L]):-
    removeLast(T,L).

splitList([B],[],B,[]):-
    integer(B).

splitList([A,B],[A],B,[]):-
    integer(A),
    integer(B).

last(X,[X]).
last(X,[A|Z]) :- last(X,Z).

splitList([H|L],[H|LeftList],Ele,RightList):-
    last(LastELe,L),
    removeLast(L,LR), 
    splitList(LR,LeftList,Ele,RRemoved),
    append(RRemoved, [LastELe], RightL),
    RightList = RightL.
    
makeSortedBST([],ibt(empty)).

makeSortedBST(L,BST):-
    splitList(L,LeftList,Ele,RightList),
    makeSortedBST(LeftList,LeftBST),
    makeSortedBST(RightList,RightBST),
    BST = ibt(node(Ele,LeftBST,RightBST)).

% makeBST([],ibt(empty)).
% makeBST([NH],ibt(node(NH,ibt(empty),ibt(empty)))).
makeBST(L, BST):-
    sort(L, Sorted),
    makeSortedBST(Sorted,BS),
    BST = BS.

isSorted([A]).
isSorted([A,B|T]):-
    A =< B,
    isSorted([B|T]).


isBST(BT):-
    inorder(BT,List),
    isSorted(List).

lookup(F,ibt(empty)):-
    false.

lookup(F, BST):-
    ibt(node(N,L,R)) = BST,
    F =:= N;
    lookup(F,L);
    lookup(F,R).

insert(I,ibt(empty),ibt(node(I,ibt(empty),ibt(empty)))).

insert(I, BST1, BST2):-
    ibt(node(N,L,R)) = BST1,
    I>N,
    insert(I, R, BST_Ret),
    BST2 = ibt(node(N,L,BST_Ret)).

insert(I, BST1, BST2):-
    ibt(node(N,L,R)) = BST1,
    I<N,
    insert(I, L, BST_Ret),
    BST2 = ibt(node(N,BST_Ret,R)).

    