(* All original code by Divyansh Mittal, 2020CS10342 *)
open AST
exception undeclared_variable
exception type_mismatch
exception type_incorrect
val maxMemSize = 1024
type hTable = (string, (dtypes * int)) HashTable.hash_table
val SymbolTable : hTable = HashTable.mkTable (HashString.hashString, op=) (maxMemSize, undeclared_variable)

fun makeSymbolTable(declarations: DEC list) : unit list =(HashTable.clear SymbolTable;  (List.mapi (fn (i,(x,y)) => HashTable.insert SymbolTable (x,(y,i))) (List.concatMap (fn DEC(strlist,dtype) => (List.map (fn x => (x,dtype)) strlist)) declarations)))

fun lookUp (locate: string) = 
    case HashTable.find SymbolTable locate  of
        SOME (_,i)     => i  
        | NONE         => raise undeclared_variable

fun lookUpType (locate: string) = 
    case HashTable.find SymbolTable locate of
        SOME (d,_)     => d 
        | NONE         => raise undeclared_variable

fun typecheck (PROG(_,decleration_seq,command_seq)) = (makeSymbolTable(decleration_seq);checkCommandSeq(command_seq))
and checkCommandSeq(commandSequence: CMD list) = List.all checkCommand commandSequence
and checkCommand (com) =
    case com of 
     SET(id,exp)                        => lookUpType(id) = getexptype(exp)
    |READ(_)                            => true
    |WRITE(exp)                         => getexptype(exp) = INT
    |ITE(exp,command_seq1,command_seq2) => getexptype(exp) = BOOL andalso checkCommandSeq(command_seq1) = true andalso checkCommandSeq(command_seq2) = true
    |WH(exp,command_seq)                => getexptype(exp) = BOOL andalso checkCommandSeq(command_seq) = true
and getexptype (expression) = (
    case expression of
      LT(exp1,exp2)     => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | LEQ(exp1,exp2)    => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | EQ(exp1,exp2)     => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | GT(exp1,exp2)     => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | GEQ(exp1,exp2)    => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | NEQ(exp1,exp2)    => if getexptype(exp1) = getexptype(exp2) then  BOOL else raise type_mismatch
    | AND(exp1,exp2)    => if getexptype(exp1) = BOOL andalso getexptype(exp2) = BOOL then BOOL else raise type_incorrect
    | OR(exp1,exp2)     => if getexptype(exp1) = BOOL andalso getexptype(exp2) = BOOL then BOOL else raise type_incorrect
    | PLUS(exp1,exp2)   => if getexptype(exp1) = INT  andalso getexptype(exp2) = INT  then INT  else raise type_incorrect
    | MINUS(exp1,exp2)  => if getexptype(exp1) = INT  andalso getexptype(exp2) = INT  then INT  else raise type_incorrect
    | TIMES(exp1,exp2)  => if getexptype(exp1) = INT  andalso getexptype(exp2) = INT  then INT  else raise type_incorrect
    | DIV(exp1,exp2)    => if getexptype(exp1) = INT  andalso getexptype(exp2) = INT  then INT  else raise type_incorrect
    | MOD(exp1,exp2)    => if getexptype(exp1) = INT  andalso getexptype(exp2) = INT  then INT  else raise type_incorrect
    | NEG(exp)          => if getexptype(exp)  = INT  then INT  else raise type_incorrect
    | NOT(exp)          => if getexptype(exp)  = BOOL then BOOL else raise type_incorrect
    | BOOLEAN(_)        => BOOL
    | NUM(_)            => INT
    | VAR(id)           => lookUpType(id) 
    )
    handle type_mismatch  => (print("There is a type mismatch \n");BOOL)
        |  type_incorrect => (print("Operation and type do not match \n");BOOL)

(* parseFile "test";*)