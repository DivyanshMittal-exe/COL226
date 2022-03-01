open AST

exception Invalid_var
exception type_mismatch
exception type_incorrect
exception notypematch

fun typecheck prog = 
    progcheck prog

and progcheck (Prog(_,decleration_seq,command_seq)) =
    checkCommandSeq(command_seq,getDecList(decleration_seq))

and getDecList [] = []
    |getDecList ((Dec(strlist,dtype)):: listLeft) = 
        varlistmaker(strlist,dtype) @ getDecList(listLeft)
        
and varlistmaker([],dtype) = []
    |varlistmaker (str::strlistleft,dtype) = 
    (str,dtype)::varlistmaker(strlistleft,dtype)

and checkCommandSeq([],vlist) = true
    |checkCommandSeq(command::commandSeqLeft,vlist) = 
        let
          val com_res = checkCommand(command,vlist)
          val com_left_res = checkCommandSeq(commandSeqLeft,vlist) 
        in
          if com_res = true andalso com_left_res = true then
                true
         else
            false   
        end

and getvarType (id,vlist) = 
    case List.find(fn (str, _) => str = id) vlist of
    SOME (_,dtype) => dtype
    | NONE => raise Invalid_var

and checkCommand (com,vlist) =
    case com of 
        (Set(id,exp)) =>
            if getvarType(id,vlist) = getexptype(exp,vlist) then
                true 
            else 
                false
    |(Read(_)) => true
    |(Write(exp)) => 
        if getexptype(exp,vlist) = INTEGER then 
            true
        else 
            false
    |ite(exp,command_seq1,command_seq2)=>
        if getexptype(exp,vlist) = BOOL andalso checkCommandSeq(command_seq1,vlist) = true andalso checkCommandSeq(command_seq2,vlist) = true then
            true 
        else 
            false
    |while_exp(exp,command_seq)=>
        if getexptype(exp,vlist) = BOOL andalso checkCommandSeq(command_seq,vlist) = true then 
            true 
        else 
            false


 and getexptype (expression,vlist) = 
    case expression of
    LT(exp1,exp2) =>
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
        if getexptype(exp1,vlist) = INTEGER andalso getexptype(exp2,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | (MINUS(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INTEGER andalso getexptype(exp2,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | (TIMES(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INTEGER andalso getexptype(exp2,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | (DIV(exp1,exp2)) => 
        if getexptype(exp1,vlist) = INTEGER andalso getexptype(exp2,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | (MOD(exp1,exp2)) =>  
        if getexptype(exp1,vlist) = INTEGER andalso getexptype(exp2,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | (NEG(exp)) => 
        if getexptype(exp,vlist) = INTEGER then 
            INTEGER
        else
            raise type_incorrect
    | NOT(exp) =>         
        if getexptype(exp,vlist) = BOOL then 
            BOOL
        else
            raise type_incorrect
    | BOOLEAN(_) => BOOL
    | NUM(_) => INTEGER
    | VAR(id) => getvarType(id,vlist) 