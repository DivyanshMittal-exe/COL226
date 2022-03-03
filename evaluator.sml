open AST

exception Invalid_var
exception type_mismatch
exception type_incorrect
exception notypematch
exception notNumber
val varList = []

(* to remove newline character on reading. Taken from profs website, which he has allowed to use*)
fun chomp1 s =  
    let val charlist = rev (explode s)
        fun nibble [] = []
          | nibble (#"\n"::l) = l
          | nibble l = l
    in  implode (rev (nibble charlist))
    end

(* Returns int from string *)
fun getInt i = 
    case Int.fromString(i) of 
      SOME i => i
    | NONE   => raise notNumber

fun getText dat = 
    case TextIO.inputLine dat of 
      SOME l => l
    | NONE   => "" 


fun evaluate prog = 
    evaluateprog prog

and evaluateprog (PROG(_,decleration_seq,command_seq)) =
    
    evalCommandSeq(command_seq,getDecList(decleration_seq))

and getDecList [] = []
    |getDecList ((DEC(strlist,dtype)):: listLeft) = 
        varlistmaker(strlist,dtype) @ getDecList(listLeft)
        
and varlistmaker([],dtype) = []
    |varlistmaker (str::strlistleft,d) = 
    (str,0)::varlistmaker(strlistleft,d)

and evalCommandSeq([],vlist) = vlist
    |evalCommandSeq(command::commandSeqLeft,vlist) = evalCommandSeq(commandSeqLeft,evalCommand(command,vlist)) 
    

and getVarvalue (id,vlist) = 
    case List.find(fn (str, _) => str = id) vlist of
    SOME (_,value_id) => value_id
    | NONE => raise Invalid_var

and updateVlist(id,value_upd,vlist) = 
    List.map (fn (str, val_old) => if str = id then (str,value_upd) else (str, val_old)) vlist

and evalCommand (com,vlist) =
    case com of 
    (SET(id,exp)) => updateVlist(id,evalexp(exp,vlist),vlist)
    |(READ(variable)) => (print("Enter integer :");updateVlist(variable,getInt (chomp1 (getText (TextIO.stdIn))),vlist)) 
    |(WRITE(exp)) => (print(Int.toString(evalexp(exp,vlist))^"\n");vlist)
    |ITE(exp,command_seq1,command_seq2)=>
        if evalexp(exp,vlist) = 1 then evalCommandSeq(command_seq1,vlist) else evalCommandSeq(command_seq2,vlist)
    |WH(exp,command_seq)=> evalLoop (exp,command_seq,vlist)


and evalLoop (exp,command_seq,variableList) = 
    if evalexp(exp,variableList) <> 0 then 
        evalLoop(exp,command_seq,evalCommandSeq(command_seq,variableList))
    else 
        variableList



 and evalexp (expression,vlist) = 
    case expression of
       LT(exp1,exp2) =>if evalexp(exp1,vlist) < evalexp(exp2,vlist) then 1 else 0
    | (LEQ(exp1,exp2)) => if evalexp(exp1,vlist) <= evalexp(exp2,vlist) then 1 else 0
    | (EQ(exp1,exp2)) => if evalexp(exp1,vlist) =  evalexp(exp2,vlist) then 1 else 0
    | (GT(exp1,exp2)) => if evalexp(exp1,vlist) > evalexp(exp2,vlist) then 1 else 0
    | (GEQ(exp1,exp2)) => if evalexp(exp1,vlist) >= evalexp(exp2,vlist) then 1 else 0
    | (NEQ(exp1,exp2)) => if evalexp(exp1,vlist) <> evalexp(exp2,vlist) then 1 else 0
    | (AND(exp1,exp2)) => if evalexp(exp1,vlist) = 1 andalso evalexp(exp2,vlist) = 1 then 1 else 0
    | (OR(exp1,exp2)) => if evalexp(exp1,vlist) = 1 orelse evalexp(exp2,vlist) = 1 then 1 else 0
    | (PLUS(exp1,exp2)) => evalexp(exp1,vlist) + evalexp(exp2,vlist)
    | (MINUS(exp1,exp2)) =>  evalexp(exp1,vlist) - evalexp(exp2,vlist)
    | (TIMES(exp1,exp2)) =>  evalexp(exp1,vlist)*evalexp(exp2,vlist)
    | (DIV(exp1,exp2)) => evalexp(exp1,vlist) div evalexp(exp2,vlist)
    | (MOD(exp1,exp2)) => (evalexp(exp1,vlist)) mod (evalexp(exp2,vlist))
    | (NEG(exp)) => (~1)* evalexp(exp,vlist)
    | NOT(exp) =>  if evalexp(exp,vlist) = 1 then 0 else 1  
    | BOOLEAN(bool_val) => if bool_val = true then 1 else 0
    | NUM(num_val) => num_val
    | VAR(id) => getVarvalue(id,vlist) 