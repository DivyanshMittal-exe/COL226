open AST
open FunStack

exception Invalid_var

val maxMemSize = 1024
val m =  Array.array(maxMemSize,0)
(* val mem = Array.array(maxMemSize,0) *)

datatype command = value of int
                | pointer of int*dtypes
                | PLUS | MINUS | TIMES | DIV | MOD | EQ | NEQ | LT | GT | LEQ | GEQ |  AND | OR | NOT | NEG
                | SET 
                | ITE 
                | WH
                | READ | WRITE 
                | SKIP
                | cmdexp of command list

signature VMC =
sig
    type V
    type M
    type C
    type SymbolTable
    exception Error of string
    val makeSymbolTable: DEC list ->  (string*dtypes*int) list
    val ASTtoPostfix: PROG ->  command list
    val rules:int list * int array * command list -> int list * int array * command list
    val evaluate: PROG  -> int list * int array * command list
    (* val toString :  V*M*C-> string
    val postfix : (PROG) -> command list *)
end

structure Vmc :> VMC =
struct
    type V = int Stack
    type M = int Array.array
    type C = command Stack
    type SymbolTable = (string*dtypes*int) list
    exception Error of string

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

      fun lookUp (symbolTable, locate: string) = 
        case List.find (fn (x,_,_) => x = locate ) symbolTable of
           SOME (_,_,i) => i  
         | NONE         => raise Invalid_var

      fun lookUpType (symbolTable, locate: string) = 
        case List.find (fn (x,_,_) => x = locate ) symbolTable of
           SOME (_,d,_) => d 
         | NONE         => raise Invalid_var

      fun getinputval(text, dtype) = 
          case dtype of
             BOOL => (
               case text of 
                  "tt" => 1
                  |"ff" => 0
                  | _ => raise type_mismatch
             )
           | INT => getInt(text)              


      fun makeSymbolTable(declarations: DEC list) : (string*dtypes*int) list = List.mapi (fn (i,(x,y)) => (x,y,i)) (List.concatMap (fn DEC(strlist,dtype) => (List.map (fn x => (x,dtype)) strlist)) declarations)

      fun ASTtoPostfix(PROG(_,decleration_seq,command_seq)) = CMDtoPostfix(command_seq,makeSymbolTable(decleration_seq))

      and CMDtoPostfix ([],symbolTable) = []
          | CMDtoPostfix (command:: command_seq,symbolTable) = 
              case command of
                (AST.SET(id,expn))                       => [pointer(lookUp(symbolTable,id),lookUpType(symbolTable,id))] @ EXPtoPostfix(expn,symbolTable) @ [SET] @  CMDtoPostfix(command_seq,symbolTable)
                |(AST.READ(id))                         => [pointer(lookUp(symbolTable,id),lookUpType(symbolTable,id))] @ [READ] @ CMDtoPostfix(command_seq,symbolTable)
                |(AST.WRITE(expn))                       => EXPtoPostfix(expn,symbolTable) @ [WRITE] @ CMDtoPostfix(command_seq,symbolTable)
                |AST.ITE(expn,command_seq1,command_seq2) => EXPtoPostfix(expn,symbolTable) @ [cmdexp(CMDtoPostfix(command_seq1,symbolTable))] @ [cmdexp(CMDtoPostfix(command_seq2,symbolTable))] @ [ITE] @ CMDtoPostfix(command_seq,symbolTable)
                |AST.WH(expn,command_seq1)                => [cmdexp(EXPtoPostfix(expn,symbolTable))] @ [cmdexp(CMDtoPostfix(command_seq1,symbolTable))] @ [WH] @ CMDtoPostfix(command_seq,symbolTable)


      and EXPtoPostfix(expression : Exp ,symbolTable) = 
          case expression of
                AST.LT(expn1,expn2)       => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [LT]
              | (AST.LEQ(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [LEQ]
              | (AST.EQ(expn1,expn2))     => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [EQ]
              | (AST.GT(expn1,expn2))     => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [GT]
              | (AST.GEQ(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [GEQ]
              | (AST.NEQ(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [NEQ]
              | (AST.AND(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [AND]
              | (AST.OR(expn1,expn2))     => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [OR]
              | (AST.PLUS(expn1,expn2))   => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [PLUS]
              | (AST.MINUS(expn1,expn2))  => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [MINUS]
              | (AST.TIMES(expn1,expn2))  => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [TIMES] 
              | (AST.DIV(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [DIV]
              | (AST.MOD(expn1,expn2))    => EXPtoPostfix(expn1,symbolTable) @ EXPtoPostfix(expn2,symbolTable) @ [MOD]
              | (AST.NEG(expn))           => EXPtoPostfix(expn,symbolTable)  @ [NEG]
              | (AST.NOT(expn))           => EXPtoPostfix(expn,symbolTable)  @ [NOT]  
              | BOOLEAN(bool_val)     => if bool_val = true then [value(1)] else [value(0) ]
              | NUM(num_val)          => [value(num_val)]
              | VAR(id)               => [pointer(lookUp(symbolTable,id),lookUpType(symbolTable,id)) ] 


    fun  rules (Vs,Ms,[]) = (Vs,Ms,[])
        |  rules (x::y::Vs,Ms,PLUS::Cs) = rules((x+y)::Vs,Ms,Cs)
        |  rules (x::y::Vs,Ms,MINUS::Cs) = rules((x-y)::Vs,Ms,Cs)
        |  rules (x::y::Vs,Ms,TIMES::Cs) = rules((x*y)::Vs,Ms,Cs)
        |  rules (x::y::Vs,Ms,DIV::Cs) = rules((x div y)::Vs,Ms,Cs)
        |  rules (x::y::Vs,Ms,MOD::Cs) = rules((x mod y)::Vs,Ms,Cs)
        |  rules (x::y::Vs,Ms,EQ::Cs) = if x = y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,NEQ::Cs) = if x <> y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,LT::Cs) = if x < y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,GT::Cs) = if x > y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,LEQ::Cs) = if x <= y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,GEQ::Cs) = if x >= y then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,AND::Cs) = if x <> 0 andalso y <> 0 then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::y::Vs,Ms,OR::Cs) = if  x <> 0 orelse y <> 0 then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (x::Vs ,Ms,NEG::Cs) = rules(~1*x::Vs,Ms,Cs)
        |  rules (x::Vs ,Ms,NOT::Cs) = if  x = 0 then rules(1::Vs,Ms,Cs) else rules(0::Vs,Ms,Cs) 
        |  rules (m::x::Vs ,Ms,SET::Cs) = (Array.update(Ms,x,m);rules(Vs,Ms,Cs))
        |  rules (x::Vs ,Ms,cmdexp(c)::cmdexp(d)::ITE::Cs) = if x = 1 then rules(Vs,Ms, (c @ Cs)) else rules(Vs,Ms, (d @ Cs))
        |  rules (x::Vs ,Ms,cmdexp(c)::SKIP::ITE::Cs) = if x = 1 then rules(Vs,Ms, (c @ Cs)) else rules(Vs,Ms, Cs)

        |  rules (Vs ,Ms,cmdexp(c)::cmdexp(d)::WH::Cs) = (Vs ,Ms,c @ [cmdexp(d),SKIP,ITE,cmdexp(c),cmdexp(d),WH] @ Cs)

        |  rules (x::Vs ,Ms,cmdexp(d)::WH::Cs) = if x = 1 then rules(Vs,Ms, (d @ Cs)) else rules(Vs,Ms,Cs)
        |  rules (m::Vs ,Ms,WRITE::Cs) = (print(Int.toString(m)^"\n"); rules(Vs,Ms,Cs) )
        |  rules (Vs ,Ms,pointer(x,t)::READ::Cs) = 
            let
              val p = print("Input: \n")
              val inp  = getinputval( (chomp1 (getText (TextIO.stdIn))) , t)
              val upd = Array.update(Ms,x,inp)
            in
                (Vs,Ms,Cs)
            end
        | rules (Vs,Ms,value(x)::Cs) = rules(x::Vs,Ms,Cs)
        | rules (Vs,Ms,pointer(x,_)::Cs) = rules(Array.sub(Ms,x)::Vs,Ms,Cs)


        fun evaluate(AST) = 
          let
            val v: int list = []
            val m = Array.array(maxMemSize,0)
            val c: command list  = ASTtoPostfix(AST)
          in
            rules (v , m ,c)
          end
            (* val v: int Stack = FunStack.create()
            val m: int Array= Array.array(512,0)
            val c: command Stack  = FunStack.list2stack (ASTtoPostfix(AST)) *)

end (*Struct end *)


(*makeSymbolTable([DEC (["a","b","c","ifx"],INT),DEC (["d","e","f"],BOOL)]) *)