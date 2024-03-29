ibt(empty).
ibt(node(N,L,R)):- integer(N),ibt(L),ibt(R).

size(ibt(empty),0).
size(ibt(node(_,L,R)),Size):-
    Size = 1 + size(L) + size(R).

height(ibt(empty),0).
height(ibt(node(_,L,R)),Height):-
    Height = 1 + max(height(L),height(R)).


preorder(ibt(empty),[]).
preorder(ibt(node(N,L,R)),List):-
    preorder(L,LeftList),
    preorder(R,RightList),  
    append([N|LeftList],RightList,List).

inorder(ibt(empty),[]).
inorder(ibt(node(N,L,R)),List):-
    inorder(L,LeftList),
    inorder(R,RightList),
    append(LeftList,[N],LL), 
    append(LL,RightList,List).
    
postorder(ibt(empty),[]).
postorder(ibt(node(N,L,R)),List):-
    postorder(L,LeftList),
    postorder(R,RightList),
    append(RightList,[N],RR), 
    append(LeftList,RR,List).


toString(ibt(empty),"()").
toString(ibt(node(N,L,R)),S):-
    toString(L,LeftString),
    toString(R,RightString),
    number_string(N,N_String),
    string_concat("(",N_String,S1),
    string_concat(S1,",",S2),
    string_concat(S2,LeftString,S3),
    string_concat(S3,",",S4),
    string_concat(S4,RightString,S5),
    string_concat(S5,")",S).


isBalanced(ibt(empty)).
isBalanced(ibt(node(_,L,R))):-
    isBalanced(L),isBalanced(R),
    height(L,H),
    Hplus is H + 1,
    Hminus is H - 1,
    (height(R,H);height(R,Hplus);height(R,Hminus)).


splitList([B],[],[B]).
splitList([A,B],[A],[B]).
splitList(A,B,C):-
    append(B,C,A),
    length(B,N),
    Nplus is N+1,
    (length(C,N);
    length(C,Nplus)).
    
    
makeSortedBST([],ibt(empty)).
makeSortedBST(L,ibt(node(Ele,LeftBST,RightBST))):-
    splitList(L,LeftList,[Ele|RightList]),
    makeSortedBST(LeftList,LeftBST),
    makeSortedBST(RightList,RightBST).

makeBST(L, BST):-
    sort(L, Sorted),
    makeSortedBST(Sorted,BT),
    BST = BT.

isSorted([_]).
isSorted([A,B|T]):-
    A =< B,
    isSorted([B|T]).


isBST(BT):-
    inorder(BT,List),
    isSorted(List).

lookup(_,ibt(empty)):-
    false.

lookup(F, ibt(node(N,L,R))):-
    F =:= N;
    lookup(F,L);
    lookup(F,R).

insert(I,ibt(empty),ibt(node(I,ibt(empty),ibt(empty)))).

insert(I, ibt(node(N,L,R)), ibt(node(N,L,BST_Ret))):-
    I>N,
    insert(I, R, BST_Ret).

insert(I, ibt(node(N,L,R)), ibt(node(N,BST_Ret,R))):-
    I<N,
    insert(I, L, BST_Ret).


trPreorder(BT,L):-
    trPreorderHelper([BT],[],L).

trPreorderHelper([],X,X).

trPreorderHelper([ibt(empty)|BT_List],Accum,Result):-
    trPreorderHelper(BT_List,Accum,Result).

trPreorderHelper([ibt(node(N,L,R))|BT_List], Accum,Result):-
    append(Accum,[N],A_New),
    trPreorderHelper([L,R|BT_List],A_New,Result).


trInorder(BT,L):-
    trInorderHelper([BT],[],L).

trInorderHelper([],X,X).

trInorderHelper([ibt(empty)|BT_List],Accum,Result):-
    trInorderHelper(BT_List,Accum,Result).

trInorderHelper([N|BT_List], Accum,Result):-
    integer(N),
    trInorderHelper(BT_List,[N|Accum],Result).

trInorderHelper([ibt(node(N,L,R))|BT_List], Accum,Result):-
    trInorderHelper([R,N,L|BT_List],Accum,Result).



trPostorder(BT,L):-
    trPostorderHelper([BT],[],L).

trPostorderHelper([],X,X).

trPostorderHelper([ibt(empty)|BT_List],Accum,Result):-
    trPostorderHelper(BT_List,Accum,Result).

trPostorderHelper([ibt(node(N,L,R))|BT_List], Accum,Result):-
    trPostorderHelper([R,L|BT_List],[N|Accum],Result).

eulerTour(ibt(empty),[]).

eulerTour(ibt(node(N,L,R)), List):-
    eulerTour(L,LeftList),
    eulerTour(R,RightList),
    append([N|LeftList],[N|RightList],MostList),
    append(MostList,[N],List).

eulerSplit(L,N,Left,Right):-
    append(Left,[N|Right],I).
    append(I,[N],L).

eulertoP([N,N,N],[N]).

eulertoP([N|ET],L):-
    eulerSplit(ET,N,LeftET,RightET),
    eulertoP(LeftET,Left),
    eulertoP(RightET,Right),
    append([N|Left],Right,L).

preET(BT, L):-
    eulerTour(BT,ET),
    eulertoP(ET,L).
    