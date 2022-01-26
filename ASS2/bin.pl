ibt(empty).
ibt(node(N,L,R)):- integer(N),ibt(L),ibt(R).


size(empty,0).
size(node(_,L,R),Size):-
    size(L,LeftS),
    size(R,RightS),
    Size is 1 + LeftS + RightS.

height(empty,0).
height(node(_,L,R),Height):-
    height(L,LeftH),
    height(R,RightH),
    Height is 1 + max(LeftH,RightH).


preorder(empty,[]).
preorder(node(N,L,R),List):-
    preorder(L,LeftList),
    preorder(R,RightList),  
    append([N|LeftList],RightList,List).

inorder(empty,[]).
inorder(node(N,L,R),List):-
    inorder(L,LeftList),
    inorder(R,RightList),
    append(LeftList,[N],LL), 
    append(LL,RightList,List).
    
postorder(empty,[]).
postorder(node(N,L,R),List):-
    postorder(L,LeftList),
    postorder(R,RightList),
    append(RightList,[N],RR), 
    append(LeftList,RR,List).


% Essentially for tail recursion, we need to have a lost of Binary Trees to have tail recursion. It is similar to iterative graph search algorithms.
trPreorder(BT,L):-
    trPreorderHelper([BT],[],L).
trPreorderHelper([],X,X).
trPreorderHelper([empty|BT_List],Accum,Result):-
    trPreorderHelper(BT_List,Accum,Result).
trPreorderHelper([node(N,L,R)|BT_List], Accum,Result):-
    append(Accum,[N],A_New),
    trPreorderHelper([L,R|BT_List],A_New,Result).



trInorder(BT,L):-
    trInorderHelper([BT],[],L).
trInorderHelper([],X,X).
trInorderHelper([empty|BT_List],Accum,Result):-
    trInorderHelper(BT_List,Accum,Result).
trInorderHelper([N|BT_List], Accum,Result):-
    integer(N),
    trInorderHelper(BT_List,[N|Accum],Result).
trInorderHelper([node(N,L,R)|BT_List], Accum,Result):-
    trInorderHelper([R,N,L|BT_List],Accum,Result).



trPostorder(BT,L):-
    trPostorderHelper([BT],[],L).
trPostorderHelper([],X,X).
trPostorderHelper([empty|BT_List],Accum,Result):-
    trPostorderHelper(BT_List,Accum,Result).
trPostorderHelper([node(N,L,R)|BT_List], Accum,Result):-
    trPostorderHelper([R,L|BT_List],[N|Accum],Result).



eulerTour(empty,[]).
eulerTour(node(N,L,R), List):-
    eulerTour(L,LeftList),
    eulerTour(R,RightList),
    append([N|LeftList],[N|RightList],MostList),
    append(MostList,[N],List).


remo([_], []).
remo([X|L], [X|Y]) :- 
    remo(L, Y).

eSplit([Ele|List],Ele,[],RightL):-
    remo(List,RightL).

eSplit([X|List],Ele,[X|LeftList],RightL):-
    X=\=Ele,
    eSplit(List,Ele,LeftList,RightL).



% eulerSplit(ET,N,LeftET,RightET):-
%     append(LeftET,[N|RightET],Inter),
%     append(Inter,[N],ET).

eulertoPre([],[]).

eulertoPre([N,N,N],[N]):-
    integer(N).
eulertoPre([N|ET],L):-
    eSplit(ET,N,LeftET,RightET),
    eulertoPre(LeftET,Left),
    eulertoPre(RightET,Right),
    append([N|Left],Right,L).
preET(BT, L):-
    eulerTour(BT,ET),
    eulertoPre(ET,L).


eulertoIn([],[]).

eulertoIn([N,N,N],[N]):-
    integer(N).
eulertoIn([N|ET],L):-
    eSplit(ET,N,LeftET,RightET),
    eulertoIn(LeftET,Left),
    eulertoIn(RightET,Right),
    append(Left,[N|Right],L).
inET(BT, L):-
    eulerTour(BT,ET),
    eulertoIn(ET,L).

eulertoPost([],[]).

eulertoPost([N,N,N],[N]):-
    integer(N).
eulertoPost([N|ET],L):-
    eSplit(ET,N,LeftET,RightET),
    eulertoPost(LeftET,Left),
    eulertoPost(RightET,Right),
    append(Left,Right,Inter),
    append(Inter,[N],L).
postET(BT, L):-
    eulerTour(BT,ET),
    eulertoPost(ET,L).


toString(empty,"()").
toString(node(N,L,R),S):-
    toString(L,LeftString),
    toString(R,RightString),
    number_string(N,N_String),
    string_concat("(",N_String,S1),
    string_concat(S1,",",S2),
    string_concat(S2,LeftString,S3),
    string_concat(S3,",",S4),
    string_concat(S4,RightString,S5),
    string_concat(S5,")",S).


isBalanced(empty).
isBalanced(node(_,empty,empty)).
isBalanced(node(_,L,R)):-
    isBalanced(L),isBalanced(R),
    height(L,H),
    Hplus is H + 1,
    Hminus is H - 1,
    (height(R,H);height(R,Hplus);height(R,Hminus)).


isSorted([_]).
isSorted([A,B|T]):-
    A =< B,
    isSorted([B|T]).

isBST(BT):-
    inorder(BT,List),
    isSorted(List).


splitList([B],[],[B]).
splitList([A,B],[A],[B]).
splitList(A,B,C):-
    append(B,C,A),
    length(B,N),
    Nplus is N+1,
    (length(C,N);
    length(C,Nplus)).
    
% makeSortedBST takes in a sorted list to make BST
makeSortedBST([],empty).
makeSortedBST(L,node(Ele,LeftBST,RightBST)):-
    splitList(L,LeftList,[Ele|RightList]),
    makeSortedBST(LeftList,LeftBST),
    makeSortedBST(RightList,RightBST).

% Essentially sort given list and split in 3 parts. Make middle elemnt node, and recursively apply makeSortedBST
makeBST(L, BST):-
    sort(L, Sorted),
    makeSortedBST(Sorted,BST).



lookup(_,empty):- false.
lookup(F, node(N,L,R)):-
    F =:= N;
    lookup(F,L);
    lookup(F,R).


insert(I,empty,node(I,empty,empty)).
insert(I, node(N,L,R), node(N,L,BST_Ret)):-
    I>N,
    insert(I, R, BST_Ret).
insert(I, node(N,L,R), node(N,BST_Ret,R)):-
    I<N,
    insert(I, L, BST_Ret).

getMin(node(N,empty,_),N).
getMin(node(_,L,_),E):-
    getMin(L,E).

del(_, empty, empty).
del(N, node(N,empty,R),R).
del(N, node(N,L,empty),L).


del(N,node(N,L,R),node(E,L,R_New)):-
    getMin(R,E),
    del(E,R,R_New).


del(N,node(K,L,R),node(K,L,R_N)):-
    N > K,
    del(N,R,R_N).

del(N,node(K,L,R),node(K,L_N,R)):-
    N < K,
    del(N,L,L_N).



% node(4, node(2, node(1, empty, empty), node(3, empty, empty)), node(6, node(5, empty, empty), node(7, empty, empty)))