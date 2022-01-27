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
build_tree1(BT):- BT = node(27, node(23, node(90, node(36, empty, node(47, empty, empty)), empty), node(2, node(54, empty, empty), node(62, empty, node(36, empty, empty)))), node(87, node(2, node(86, node(3, empty, empty), node(64, node(58, empty, empty), empty)), node(40, node(58, node(70, empty, empty), empty), node(83, empty, node(71, empty, empty)))), node(13, empty, node(44, node(80, node(11, empty, empty), empty), node(57, empty, empty))))).
get_size1(N):- N = 25.
get_height1(N):- N = 6.
get_inorder1(L):- L = [36, 47, 90, 23, 54, 2, 62, 36, 27, 3, 86, 58, 64, 2, 70, 58, 40, 83, 71, 87, 13, 11, 80, 44, 57].
get_postorder1(L):- L = [47, 36, 90, 54, 36, 62, 2, 23, 3, 58, 64, 86, 70, 58, 71, 83, 40, 2, 11, 80, 57, 44, 13, 87, 27].
get_preorder1(L):- L = [27, 23, 90, 36, 47, 2, 54, 62, 36, 87, 2, 86, 3, 64, 58, 40, 58, 70, 83, 71, 13, 44, 80, 11, 57].
get_tour1(L):- L = [27, 23, 90, 36, 36, 47, 47, 47, 36, 90, 90, 23, 2, 54, 54, 54, 2, 62, 62, 36, 36, 36, 62, 2, 23, 27, 87, 2, 86, 3, 3, 3, 86, 64, 58, 58, 58, 64, 64, 86, 2, 40, 58, 70, 70, 70, 58, 58, 40, 83, 83, 71, 71, 71, 83, 40, 2, 87, 13, 13, 44, 80, 11, 11, 11, 80, 80, 44, 57, 57, 57, 44, 13, 87, 27].
is_balanced1:- fail.
get_string1(S):- S = "(27, (23, (90, (36, (), (47, (), ())), ()), (2, (54, (), ()), (62, (), (36, (), ())))), (87, (2, (86, (3, (), ()), (64, (58, (), ()), ())), (40, (58, (70, (), ()), ()), (83, (), (71, (), ())))), (13, (), (44, (80, (11, (), ()), ()), (57, (), ())))))".
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
toString(BT, S),
get_size0(N1),
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
build_tree2(BT):- BT = node(38, node(56, node(33, node(76, node(18, node(61, node(73, empty, empty), empty), node(14, empty, empty)), node(17, node(93, empty, empty), empty)), node(57, node(89, node(29, empty, empty), empty), node(78, empty, empty))), node(47, node(84, node(41, node(67, empty, empty), empty), node(15, empty, empty)), node(68, node(89, empty, empty), empty))), node(74, node(14, node(94, node(15, node(58, empty, empty), empty), node(13, empty, empty)), node(16, node(96, node(79, empty, empty), empty), node(56, empty, empty))), node(47, node(98, node(42, node(9, empty, empty), empty), node(31, empty, empty)), node(16, node(58, empty, empty), empty)))).
get_size2(N):- N = 38.
get_height2(N):- N = 7.
get_inorder2(L):- L = [73, 61, 18, 14, 76, 93, 17, 33, 29, 89, 57, 78, 56, 67, 41, 84, 15, 47, 89, 68, 38, 58, 15, 94, 13, 14, 79, 96, 16, 56, 74, 9, 42, 98, 31, 47, 58, 16].
get_postorder2(L):- L = [73, 61, 14, 18, 93, 17, 76, 29, 89, 78, 57, 33, 67, 41, 15, 84, 89, 68, 47, 56, 58, 15, 13, 94, 79, 96, 56, 16, 14, 9, 42, 31, 98, 58, 16, 47, 74, 38].
get_preorder2(L):- L = [38, 56, 33, 76, 18, 61, 73, 14, 17, 93, 57, 89, 29, 78, 47, 84, 41, 67, 15, 68, 89, 74, 14, 94, 15, 58, 13, 16, 96, 79, 56, 47, 98, 42, 9, 31, 16, 58].
get_tour2(L):- L = [38, 56, 33, 76, 18, 61, 73, 73, 73, 61, 61, 18, 14, 14, 14, 18, 76, 17, 93, 93, 93, 17, 17, 76, 33, 57, 89, 29, 29, 29, 89, 89, 57, 78, 78, 78, 57, 33, 56, 47, 84, 41, 67, 67, 67, 41, 41, 84, 15, 15, 15, 84, 47, 68, 89, 89, 89, 68, 68, 47, 56, 38, 74, 14, 94, 15, 58, 58, 58, 15, 15, 94, 13, 13, 13, 94, 14, 16, 96, 79, 79, 79, 96, 96, 16, 56, 56, 56, 16, 14, 74, 47, 98, 42, 9, 9, 9, 42, 42, 98, 31, 31, 31, 98, 47, 16, 58, 58, 58, 16, 16, 47, 74, 38].
is_balanced2.
get_string2(S):- S = "(38, (56, (33, (76, (18, (61, (73, (), ()), ()), (14, (), ())), (17, (93, (), ()), ())), (57, (89, (29, (), ()), ()), (78, (), ()))), (47, (84, (41, (67, (), ()), ()), (15, (), ())), (68, (89, (), ()), ()))), (74, (14, (94, (15, (58, (), ()), ()), (13, (), ())), (16, (96, (79, (), ()), ()), (56, (), ()))), (47, (98, (42, (9, (), ()), ()), (31, (), ())), (16, (58, (), ()), ()))))".
build_tree3(BT):- BT = node(46, node(6, node(21, node(96, node(69, node(80, node(70, empty, empty), empty), node(20, empty, empty)), node(4, node(69, empty, empty), empty)), node(70, node(27, node(28, empty, empty), empty), node(49, empty, empty))), node(51, node(69, node(57, node(64, empty, empty), empty), node(8, empty, empty)), node(24, node(29, empty, empty), empty))), node(74, node(98, node(82, node(29, node(90, empty, empty), empty), node(48, empty, empty)), node(72, node(87, empty, empty), empty)), node(90, node(15, node(8, empty, empty), empty), node(46, node(48, empty, empty), empty)))).
get_size3(N):- N = 34.
get_height3(N):- N = 7.
get_inorder3(L):- L = [70, 80, 69, 20, 96, 69, 4, 21, 28, 27, 70, 49, 6, 64, 57, 69, 8, 51, 29, 24, 46, 90, 29, 82, 48, 98, 87, 72, 74, 8, 15, 90, 48, 46].
get_postorder3(L):- L = [70, 80, 20, 69, 69, 4, 96, 28, 27, 49, 70, 21, 64, 57, 8, 69, 29, 24, 51, 6, 90, 29, 48, 82, 87, 72, 98, 8, 15, 48, 46, 90, 74, 46].
get_preorder3(L):- L = [46, 6, 21, 96, 69, 80, 70, 20, 4, 69, 70, 27, 28, 49, 51, 69, 57, 64, 8, 24, 29, 74, 98, 82, 29, 90, 48, 72, 87, 90, 15, 8, 46, 48].
get_tour3(L):- L = [46, 6, 21, 96, 69, 80, 70, 70, 70, 80, 80, 69, 20, 20, 20, 69, 96, 4, 69, 69, 69, 4, 4, 96, 21, 70, 27, 28, 28, 28, 27, 27, 70, 49, 49, 49, 70, 21, 6, 51, 69, 57, 64, 64, 64, 57, 57, 69, 8, 8, 8, 69, 51, 24, 29, 29, 29, 24, 24, 51, 6, 46, 74, 98, 82, 29, 90, 90, 90, 29, 29, 82, 48, 48, 48, 82, 98, 72, 87, 87, 87, 72, 72, 98, 74, 90, 15, 8, 8, 8, 15, 15, 90, 46, 48, 48, 48, 46, 46, 90, 74, 46].
is_balanced3.
get_string3(S):- S = "(46, (6, (21, (96, (69, (80, (70, (), ()), ()), (20, (), ())), (4, (69, (), ()), ())), (70, (27, (28, (), ()), ()), (49, (), ()))), (51, (69, (57, (64, (), ()), ()), (8, (), ())), (24, (29, (), ()), ()))), (74, (98, (82, (29, (90, (), ()), ()), (48, (), ())), (72, (87, (), ()), ())), (90, (15, (8, (), ()), ()), (46, (48, (), ()), ()))))".
run_test2:-build_tree2(BT),
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
get_size2(N1),
get_height2(N2),
get_preorder2(L1),
get_preorder2(L4),
get_preorder2(L7),
get_postorder2(L2),
get_postorder2(L5),
get_postorder2(L8),
get_inorder2(L3),
get_inorder2(L6),
get_inorder2(L9),
get_tour2(L10),
get_string2(S),
checkSame(is_balanced2, isBalanced(BT)).
run_test3:-build_tree3(BT),
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
get_size3(N1),
get_height3(N2),
get_preorder3(L1),
get_preorder3(L4),
get_preorder3(L7),
get_postorder3(L2),
get_postorder3(L5),
get_postorder3(L8),
get_inorder3(L3),
get_inorder3(L6),
get_inorder3(L9),
get_tour3(L10),
get_string3(S),
checkSame(is_balanced3, isBalanced(BT)).
run_all_BT_tests:-run_test0, 
run_test1, 
run_test2, 
run_test3. 
random_array0(L):- L = [59, 75, 38, 37, 3, 43, 11, 56, 19, 53, 18, 76, 93, 22, 33, 85, 21, 16, 77, 92, 80, 30, 69, 97, 71, 89, 98, 58, 42, 83, 54, 24, 82, 25, 84, 47, 52, 67, 1, 99].
sorted_array0(L):- L = [1, 3, 11, 16, 18, 19, 21, 22, 24, 25, 30, 33, 37, 38, 42, 43, 47, 52, 53, 54, 56, 58, 59, 67, 69, 71, 75, 76, 77, 80, 82, 83, 84, 85, 89, 92, 93, 97, 98, 99].
run_make_bst_test0:- random_array0(L), 
        makeBST(L, BT),
        isBST(BT), 
        isBalanced(BT),
        inorder(BT, Sorted),
        sorted_array0(Sorted).
random_array1(L):- L = [78, 71, 41, 28, 26, 63, 54, 36, 18, 87, 83, 5, 99, 55, 93, 60, 10, 89, 19, 65, 90, 14, 57, 53, 67, 66, 11, 20, 84, 29, 82, 70].
sorted_array1(L):- L = [5, 10, 11, 14, 18, 19, 20, 26, 28, 29, 36, 41, 53, 54, 55, 57, 60, 63, 65, 66, 67, 70, 71, 78, 82, 83, 84, 87, 89, 90, 93, 99].
run_make_bst_test1:- random_array1(L), 
        makeBST(L, BT),
        isBST(BT), 
        isBalanced(BT),
        inorder(BT, Sorted),
        sorted_array1(Sorted).
run_all_make_bst_tests:-run_make_bst_test0, 
run_make_bst_test1. 
build_bst0(BT):- BT = node(3, node(1, empty, empty), node(47, node(45, node(20, node(13, node(6, empty, node(7, empty, node(9, empty, empty))), node(15, empty, node(19, empty, empty))), node(44, node(43, node(30, node(28, node(22, node(21, empty, empty), node(25, empty, empty)), empty), node(35, node(32, node(31, empty, empty), empty), node(38, empty, empty))), empty), empty)), empty), node(87, node(83, node(81, node(69, node(62, node(51, node(48, empty, empty), node(58, node(54, empty, empty), empty)), node(66, node(63, empty, empty), node(68, empty, empty))), node(79, empty, node(80, empty, empty))), empty), node(85, empty, empty)), node(88, empty, node(94, node(90, empty, empty), empty))))).
after_insertion_list0(L):- L = [1, 3, 6, 7, 9, 13, 15, 19, 20, 21, 22, 23, 25, 27, 28, 30, 31, 32, 34, 35, 38, 43, 44, 45, 47, 48, 51, 54, 57, 58, 62, 63, 66, 68, 69, 79, 80, 81, 83, 85, 87, 88, 90, 91, 94].
after_deletion_list0(L):- L = [1, 3, 6, 7, 9, 13, 15, 19, 20, 21, 22, 23, 25, 27, 28, 30, 31, 32, 34, 38, 43, 44, 45, 47, 48, 54, 57, 58, 62, 63, 66, 68, 69, 79, 81, 83, 85, 87, 88, 90, 91, 94].
run_bst_test0:- build_bst0(BT0),
not(lookup(27, BT0)),
not(lookup(34, BT0)),
not(lookup(57, BT0)),
not(lookup(91, BT0)),
not(lookup(23, BT0)),
lookup(80, BT0),
lookup(35, BT0),
lookup(51, BT0),
isBST(BT0),
insert(27, BT0, BT1),
insert(34, BT1, BT2),
insert(57, BT2, BT3),
insert(91, BT3, BT4),
insert(23, BT4, BT5),
isBST(BT5),
inorder(BT5, L1), 
after_insertion_list0(L1), 
delete(80, BT5, BT6), 
delete(35, BT6, BT7), 
delete(51, BT7, BT8), 
isBST(BT8),
inorder(BT8, L2), 
after_deletion_list0(L2). 
build_bst1(BT):- BT = node(52, node(46, node(15, node(5, empty, node(11, node(9, empty, empty), empty)), node(29, node(21, node(16, empty, node(18, empty, empty)), node(22, empty, node(27, node(24, empty, empty), node(28, empty, empty)))), node(38, node(35, empty, empty), node(44, node(42, node(41, empty, empty), empty), empty)))), node(47, empty, node(49, node(48, empty, empty), empty))), node(81, node(69, node(68, node(65, node(63, node(61, empty, node(62, empty, empty)), empty), empty), empty), node(70, empty, node(80, node(79, node(78, node(77, empty, empty), empty), empty), empty))), node(88, node(85, node(83, empty, empty), empty), node(97, node(93, empty, empty), empty)))).
after_insertion_list1(L):- L = [5, 9, 11, 15, 16, 18, 21, 22, 24, 27, 28, 29, 34, 35, 36, 38, 41, 42, 44, 46, 47, 48, 49, 52, 53, 54, 55, 61, 62, 63, 65, 68, 69, 70, 77, 78, 79, 80, 81, 83, 85, 88, 92, 93, 97].
after_deletion_list1(L):- L = [5, 9, 11, 15, 16, 18, 22, 24, 27, 28, 29, 34, 35, 36, 41, 44, 46, 48, 49, 52, 53, 54, 55, 61, 62, 63, 65, 68, 69, 70, 77, 78, 79, 80, 81, 83, 85, 88, 92, 93, 97].
run_bst_test1:- build_bst1(BT0),
not(lookup(34, BT0)),
not(lookup(92, BT0)),
not(lookup(55, BT0)),
not(lookup(53, BT0)),
not(lookup(36, BT0)),
not(lookup(54, BT0)),
lookup(47, BT0),
lookup(42, BT0),
lookup(21, BT0),
lookup(38, BT0),
isBST(BT0),
insert(34, BT0, BT1),
insert(92, BT1, BT2),
insert(55, BT2, BT3),
insert(53, BT3, BT4),
insert(36, BT4, BT5),
insert(54, BT5, BT6),
isBST(BT6),
inorder(BT6, L1), 
after_insertion_list1(L1), 
delete(47, BT6, BT7), 
delete(42, BT7, BT8), 
delete(21, BT8, BT9), 
delete(38, BT9, BT10), 
isBST(BT10),
inorder(BT10, L2), 
after_deletion_list1(L2). 
run_all_bst_tests:-run_bst_test0, 
run_bst_test1. 
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
