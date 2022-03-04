(* All original code by Divyansh Mittal, 2020CS10342 *)

open AST

exception undeclared_variable;
exception type_mismatch;
exception type_incorrect;
exception notypematch;

fun typecheck (PROG(_,decleration_seq,command_seq)) =
    checkCommandSeq(command_seq,getDecList(decleration_seq))

and getDecList [] = []
    |getDecList ((DEC(strlist,dtype)):: listLeft) = 
        varlistmaker(strlist,dtype) @ getDecList(listLeft)
        
and varlistmaker([],dtype) = []
    |varlistmaker (str::strlistleft,dtype) = 
    (str,dtype)::varlistmaker(strlistleft,dtype)

and checkCommandSeq([],vlist) = true
    |checkCommandSeq(command::commandSeqLeft,vlist) = 
        case (checkCommand(command,vlist),checkCommandSeq(commandSeqLeft,vlist)) of 
            (true,true) => true
            | _ => false

and getvarType (id,vlist) = 
    case List.find(fn (str, _) => str = id) vlist of
        SOME (_,dtype) => dtype
        | NONE => raise undeclared_variable

and checkCommand (com,vlist) =
    case com of 
    (SET(id,exp)) =>(getvarType(id,vlist) = getexptype(exp,vlist))
    |(READ(_)) => true
    |(WRITE(exp)) => 
        (case getexptype(exp,vlist) of
            INT => true
            | _ => false)
    |ITE(exp,command_seq1,command_seq2)=>
        (case (getexptype(exp,vlist),checkCommandSeq(command_seq1,vlist),checkCommandSeq(command_seq2,vlist)) of
            (BOOL,true,true) => true
            | _ => false)
    |WH(exp,command_seq)=>
        (case (getexptype(exp,vlist),checkCommandSeq(command_seq,vlist)) of
                (BOOL,true) => true
                | _ => false)


 and getexptype (expression,vlist) = 
    case expression of
        LT(exp1,exp2)  =>
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch

    | (LEQ(exp1,exp2)) =>
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch
    | (EQ(exp1,exp2)) => 
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch
    | (GT(exp1,exp2)) => 
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch
    | (GEQ(exp1,exp2)) => 
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch
    | (NEQ(exp1,exp2)) => 
        if getexptype(exp1,vlist) = getexptype(exp2,vlist) then 
            BOOL
        else
            raise type_mismatch
    | (AND(exp1,exp2)) =>
        if getexptype(exp1,vlist) = BOOL andalso getexptype(exp2,vlist) = BOOL then 
            BOOL
        else
            raise type_incorrect
    | (OR(exp1,exp2)) => 
        if getexptype(exp1,vlist) = BOOL andalso getexptype(exp2,vlist) = BOOL then 
            BOOL
        else
            raise type_incorrect
    | (PLUS(exp1,exp2)) => 
        if getexptype(exp1,vlist) = INT andalso getexptype(exp2,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | (MINUS(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INT andalso getexptype(exp2,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | (TIMES(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INT andalso getexptype(exp2,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | (DIV(exp1,exp2)) => 
        if getexptype(exp1,vlist) = INT andalso getexptype(exp2,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | (MOD(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INT andalso getexptype(exp2,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | (NEG(exp)) => 
        if getexptype(exp,vlist) = INT then 
            INT
        else
            raise type_incorrect
    | NOT(exp) =>         
        if getexptype(exp,vlist) = BOOL then 
            BOOL
        else
            raise type_incorrect
    | BOOLEAN(_) => BOOL
    | NUM(_) => INT
    | VAR(id) => getvarType(id,vlist) 

    handle type_mismatch => (print("There is a type mismatch \n");BOOL)
        |  type_incorrect =>( print("Operation and type do not match \n");BOOL)