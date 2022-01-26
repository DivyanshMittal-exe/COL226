checkSame(A, B):- (A, B);(not(A),not(B)).
build_tree0(BT):- BT = node(29, node(42, node(1, empty, node(55, node(82, node(21, empty, empty), node(60, empty, empty)), node(5, empty, empty))), node(79, node(68, node(82, empty, empty), node(90, node(61, node(99, empty, empty), node(96, empty, empty)), empty)), node(77, empty, node(2, empty, empty)))), node(65, node(46, node(88, empty, node(69, node(29, empty, empty), empty)), empty), node(4, node(40, empty, node(39, node(79, empty, empty), node(39, empty, empty))), node(18, node(20, empty, node(45, empty, empty)), node(40, empty, empty))))).
get_size0(N):- N = 31.
get_height0(N):- N = 7.
get_inorder0(L):- L = [1, 21, 82, 60, 55, 5, 42, 82, 68, 99, 61, 96, 90, 79, 77, 2, 29, 88, 29, 69, 46, 65, 40, 79, 39, 39, 4, 20, 45, 18, 40].
get_postorder0(L):- L = [21, 60, 82, 5, 55, 1, 82, 99, 96, 61, 90, 68, 2, 77, 79, 42, 29, 69, 88, 46, 79, 39, 39, 40, 45, 20, 40, 18, 4, 65, 29].
get_preorder0(L):- L = [29, 42, 1, 55, 82, 21, 60, 5, 79, 68, 82, 90, 61, 99, 96, 77, 2, 65, 46, 88, 69, 29, 4, 40, 39, 79, 39, 18, 20, 45, 40].
get_tour0(L):- L = [29, 42, 1, 1, 55, 82, 21, 21, 21, 82, 60, 60, 60, 82, 55, 5, 5, 5, 55, 1, 42, 79, 68, 82, 82, 82, 68, 90, 61, 99, 99, 99, 61, 96, 96, 96, 61, 90, 90, 68, 79, 77, 77, 2, 2, 2, 77, 79, 42, 29, 65, 46, 88, 88, 69, 29, 29, 29, 69, 69, 88, 46, 46, 65, 4, 40, 40, 39, 79, 79, 79, 39, 39, 39, 39, 39, 40, 4, 18, 20, 20, 45, 45, 45, 20, 18, 40, 40, 40, 18, 4, 65, 29].
is_balanced0:- fail.
get_string0(S):- S = "(29, (42, (1, (), (55, (82, (21, (), ()), (60, (), ())), (5, (), ()))), (79, (68, (82, (), ()), (90, (61, (99, (), ()), (96, (), ())), ())), (77, (), (2, (), ())))), (65, (46, (88, (), (69, (29, (), ()), ())), ()), (4, (40, (), (39, (79, (), ()), (39, (), ()))), (18, (20, (), (45, (), ())), (40, (), ())))))".
run_test0:-build_tree0(BT),
preorder(BT, L1),
postorder(BT, L2),
inorder(BT, L3),
trPreorder(BT, L4),
trPostorder(BT, L5),
trInorder(BT, L6),
preET(BT, L7),
postET(BT, L8),
inET(BT, L9),
eulerTour(BT, L10),
size(BT, N1),
height(BT, N2), 
get_size0(N1),
toString(BT, S),
get_height0(N2),
get_preorder0(L1),
get_preorder0(L4),
get_preorder0(L7),
get_postorder0(L2),
get_postorder0(L5),
get_postorder0(L8),
get_inorder0(L3),
get_inorder0(L6),
get_inorder0(L9),
get_tour0(L10),
get_string0(S),
checkSame(is_balanced0, isBalanced(BT)).


build_tree1(BT):- BT = node(27, node(23, node(87, node(83, node(40, node(53, empty, empty), empty), node(13, empty, empty)), node(76, node(75, empty, empty), empty)), node(2, node(96, node(97, empty, empty), empty), node(2, empty, empty))), node(31, node(84, node(90, node(99, node(24, empty, empty), empty), node(46, empty, empty)), node(4, node(40, empty, empty), empty)), node(68, node(60, node(62, empty, empty), empty), node(58, empty, empty)))).
get_size1(N):- N = 25.
get_height1(N):- N = 6.
get_inorder1(L):- L = [53, 40, 83, 13, 87, 75, 76, 23, 97, 96, 2, 2, 27, 24, 99, 90, 46, 84, 40, 4, 31, 62, 60, 68, 58].
get_postorder1(L):- L = [53, 40, 13, 83, 75, 76, 87, 97, 96, 2, 2, 23, 24, 99, 46, 90, 40, 4, 84, 62, 60, 58, 68, 31, 27].
get_preorder1(L):- L = [27, 23, 87, 83, 40, 53, 13, 76, 75, 2, 96, 97, 2, 31, 84, 90, 99, 24, 46, 4, 40, 68, 60, 62, 58].
get_tour1(L):- L = [27, 23, 87, 83, 40, 53, 53, 53, 40, 40, 83, 13, 13, 13, 83, 87, 76, 75, 75, 75, 76, 76, 87, 23, 2, 96, 97, 97, 97, 96, 96, 2, 2, 2, 2, 2, 23, 27, 31, 84, 90, 99, 24, 24, 24, 99, 99, 90, 46, 46, 46, 90, 84, 4, 40, 40, 40, 4, 4, 84, 31, 68, 60, 62, 62, 62, 60, 60, 68, 58, 58, 58, 68, 31, 27].
is_balanced1.
get_string1(S):- S = "(27, (23, (87, (83, (40, (53, (), ()), ()), (13, (), ())), (76, (75, (), ()), ())), (2, (96, (97, (), ()), ()), (2, (), ()))), (31, (84, (90, (99, (24, (), ()), ()), (46, (), ())), (4, (40, (), ()), ())), (68, (60, (62, (), ()), ()), (58, (), ()))))".
run_test1:-build_tree1(BT),
preorder(BT, L1),
postorder(BT, L2),
inorder(BT, L3),
trPreorder(BT, L4),
trPostorder(BT, L5),
trInorder(BT, L6),
preET(BT, L7),
postET(BT, L8),
inET(BT, L9),
eulerTour(BT, L10),
size(BT, N1), 
height(BT, N2), 
toString(BT, S),
get_size1(N1),
get_height1(N2),
get_preorder1(L1),
get_preorder1(L4),
get_preorder1(L7),
get_postorder1(L2),
get_postorder1(L5),
get_postorder1(L8),
get_inorder1(L3),
get_inorder1(L6),
get_inorder1(L9),
get_tour1(L10),
get_string1(S),
checkSame(is_balanced1, isBalanced(BT)).
run_all_BT_tests:-run_test0, 
run_test1. 
random_array0(L):- L = [63, 20, 74, 36, 86, 18, 66, 64, 3, 23, 77, 43, 47, 91, 44, 84, 97, 54, 49, 33, 28, 58, 37, 61, 81, 83, 40, 25, 85, 22, 38, 15, 78].
sorted_array0(L):- L = [3, 15, 18, 20, 22, 23, 25, 28, 33, 36, 37, 38, 40, 43, 44, 47, 49, 54, 58, 61, 63, 64, 66, 74, 77, 78, 81, 83, 84, 85, 86, 91, 97].
run_make_bst_test0:- random_array0(L), 
        makeBST(L, BT),
        isBST(BT), 
        isBalanced(BT),
        inorder(BT, Sorted),
        sorted_array0(Sorted).
run_all_make_bst_tests:-run_make_bst_test0. 
build_bst0(BT):- BT = node(31, node(25, node(23, node(11, node(2, node(1, empty, empty), node(8, empty, empty)), empty), empty), node(27, empty, empty)), node(70, node(35, node(34, node(33, empty, empty), empty), node(41, node(38, empty, empty), node(67, node(58, node(48, node(42, empty, node(46, node(45, empty, empty), empty)), node(57, node(56, empty, empty), empty)), node(63, empty, empty)), node(68, empty, empty)))), node(93, node(71, empty, node(79, node(74, empty, empty), node(80, empty, node(88, node(84, empty, empty), node(91, empty, empty))))), node(99, node(98, empty, empty), empty)))).
after_insertion_list0(L):- L = [1, 2, 8, 11, 14, 16, 18, 23, 25, 27, 31, 33, 34, 35, 38, 41, 42, 45, 46, 47, 48, 56, 57, 58, 63, 67, 68, 70, 71, 74, 76, 79, 80, 84, 88, 91, 93, 94, 98, 99].
after_deletion_list0(L):- L = [1, 2, 8, 11, 14, 16, 18, 23, 25, 27, 31, 33, 34, 35, 38, 41, 42, 45, 46, 47, 48, 56, 58, 63, 67, 68, 70, 71, 74, 76, 79, 80, 88, 91, 93, 94, 99].
run_bst_test0:- build_bst0(BT0),
not(lookup(14, BT0)),
not(lookup(47, BT0)),
not(lookup(76, BT0)),
not(lookup(94, BT0)),
not(lookup(18, BT0)),
not(lookup(16, BT0)),
lookup(84, BT0),
lookup(57, BT0),
lookup(98, BT0),
isBST(BT0),
insert(14, BT0, BT1),
insert(47, BT1, BT2),
insert(76, BT2, BT3),
insert(94, BT3, BT4),
insert(18, BT4, BT5),
insert(16, BT5, BT6),
isBST(BT6),
inorder(BT6, L1), 
after_insertion_list0(L1), 
del(84, BT6, BT7), 
del(57, BT7, BT8), 
del(98, BT8, BT9), 
isBST(BT9),
inorder(BT9, L2), 
after_deletion_list0(L2). 
run_all_bst_tests:-run_bst_test0. 
run_tests:- run_all_BT_tests, 
                    write(" size correct
 height correct
 preorder correct
 postorder correct
 inorder correct
 trPreorder correct
 trPostorder correct
 trInorder correct
 eulerTour correct
 preET correct
 inET correct
 postET correct
 toString correct
 isBalanced correct
"), 
                    run_all_make_bst_tests, 
                    write(" makeBST correct 
"),
                    run_all_bst_tests,
                    write(" isBST correct 
 lookup correct 
 insert correct 
 delete correct 
 All correct 
").
