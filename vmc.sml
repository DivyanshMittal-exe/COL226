open AST

val maxMemSize = 1024

(* val mem = Array.array(maxMemSize,0) *)

datatype command = value of int
                | pointer of int
                | binaryop of bopn * int
                | unaryop of unop * int
                | set 
                | ite 
                | wh
and bopn = PLUS | MINUS | TIMES | DIV | MOD | EQ | NEQ | LT | GT | LEQ | GEQ | NEQ |  AND | OR 
and unop = NOT | NEG

signature VMC =
sig
    type V
    type M
    type C
    type SymbolTable
    exception Error of string
    val rules: (V,M,C) -> (V,M,C)
    val toString : (V,M,C) -> string
    val postfix : (PROG) -> command list
end

structure Vmc :> VMC =
struct
    type V = int FunStack
    type M = Array
    type C = int FunStack
    type SymbolTable = (string*dtype*int) list

    fun postfix (PROG(_,decleration_seq,command_seq)) = 
        let
          assignments,updated_int_index,updated_bool_index = assign(decleration_seq,0,512)
        in
          body
        end
        commandSeqConverter(command_seq,assignments)
    
    fun assign [] = []
        |assign ((DEC(strlist,dtype)):: listLeft,int_index,boolindex) = 
            let
                assignments,updated_int_index,updated_bool_index = assign_variables(strlist,dtype,int_index,bool_index)
            in
                assignments @ assign(listLeft,updated_int_index,updated_bool_index)
            end
             
    fun assign_variables([],dtype,int_index,boolindex) = [],int_index,boolindex
        |assign_variables (str::strlistleft,INT,int_index,boolindex) =
        let
          assignments,updated_int_index,updated_bool_index = assign_variables(strlistleft,INT,int_index + 1,bool_index)
        in
          (str,int_index)::assignments , updated_int_index, updated_bool_index
        end
        |assign_variables (str::strlistleft,BOOL,int_index,boolindex) =
        let
          assignments,updated_int_index,updated_bool_index = assign_variables(strlistleft,INT,int_index ,bool_index + 1)
        in
          (str,int_index)::assignments , updated_int_index, updated_bool_index
        end
    
    fun commandSeqConverter([],assignments) = [] 
    | commandSeqConverter(command:: command_seq,assignments) = 
        case command of
          (SET(id,exp)) => 
          |(READ(variable)) => (print("Input :");updateVlist(variable, getinputval (chomp1 (getText (TextIO.stdIn)),variable,vlist),vlist)) 
          |(WRITE(exp)) => (print(Int.toString(evalexp(exp,vlist))^"\n");vlist)
          |ITE(exp,command_seq1,command_seq2)=>
              if evalexp(exp,vlist) = 1 then evalCommandSeq(command_seq1,vlist) else evalCommandSeq(command_seq2,vlist)
          |WH(exp,command_seq)=> evalLoop (exp,command_seq,vlist)

end