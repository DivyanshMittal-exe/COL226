open AST
open FunStack

exception Invalid_var
exception notNumber

(* val maxMemSize = 1024 *)

datatype command = value of int
                | pointer of int*dtypes
                | PLUS | MINUS | TIMES | DIV | MOD | EQ | NEQ | LT | GT | LEQ | GEQ |  AND | OR | NOT | NEG
                | SET 
                | ITE 
                | WH
                | READ | WRITE 
                | SEQ
                | cmdexp of command Stack

signature VMC =
sig
    type V
    type M
    type C
    exception Error of string
    val postfix: CMD list ->  C
    val rules:  V*M*C -> V*M*C
    val evaluate: PROG  -> unit
    val toString :  V*M*C -> string
    val ASTtoPostfix : PROG -> command Stack
    val ComStackString: command Stack-> string
end

structure Vmc :> VMC =
struct
    type V = command Stack
    type M = int Array.array
    type C= command Stack
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
          | NONE   =>"" 

      fun getinputval(text, dtype) = 
          case dtype of
             BOOL => (
               case text of 
                  "tt" => 1
                  |"ff" => 0
                  | _ => raise type_mismatch
             )
           | INT => getInt(text)              


      fun ASTtoPostfix(PROG(_,decleration_seq,command_seq)) : C = (makeSymbolTable(decleration_seq);postfix(command_seq)) 

      and postfix ([]) : C = []
        | postfix ([command]) : C  = 
            (case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] 
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] 
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ [cmdexp(postfix(command_seq1))] @ [cmdexp(postfix(command_seq2))] @ [ITE] 
                |AST.WH(expn,command_seq1)                  => [cmdexp(EXPtoPostfix(expn))] @ [cmdexp(postfix(command_seq1))] @ [WH] )
          
          | postfix (command :: command_seq) : C  = 
              case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET] @  postfix(command_seq) @ [SEQ]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] @ postfix(command_seq) @ [SEQ]
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] @ postfix(command_seq) @ [SEQ]
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ [cmdexp(postfix(command_seq1))] @ [cmdexp(postfix(command_seq2))] @ [ITE] @ postfix(command_seq) @ [SEQ]
                |AST.WH(expn,command_seq1)                  => [cmdexp(EXPtoPostfix(expn))] @ [cmdexp(postfix(command_seq1))] @ [WH] @ postfix(command_seq) @ [SEQ]

 
      and EXPtoPostfix(expression : Exp ): C  = 
          case expression of
                AST.LT(expn1,expn2)       => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [LT]
              | (AST.LEQ(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [LEQ]
              | (AST.EQ(expn1,expn2))     => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [EQ]
              | (AST.GT(expn1,expn2))     => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [GT]
              | (AST.GEQ(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [GEQ]
              | (AST.NEQ(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [NEQ]
              | (AST.AND(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [AND]
              | (AST.OR(expn1,expn2))     => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [OR]
              | (AST.PLUS(expn1,expn2))   => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [PLUS]
              | (AST.MINUS(expn1,expn2))  => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [MINUS]
              | (AST.TIMES(expn1,expn2))  => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [TIMES] 
              | (AST.DIV(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [DIV]
              | (AST.MOD(expn1,expn2))    => EXPtoPostfix(expn1) @ EXPtoPostfix(expn2) @ [MOD]
              | (AST.NEG(expn))           => EXPtoPostfix(expn)  @ [NEG]
              | (AST.NOT(expn))           => EXPtoPostfix(expn)  @ [NOT]    
              | BOOLEAN(bool_val)         => if bool_val = true then [value(1)] else [value(0) ]
              | NUM(num_val)              => [value(num_val)]
              | VAR(id)                   => [pointer(lookUp(id),lookUpType(id)) ] 


    fun  rules (Vs,Ms,[]) = (Vs,Ms,[])
        |  rules (value(x)::value(y)::Vs,Ms,PLUS::Cs)             = rules(value(x+y)::Vs,Ms,Cs)
        |  rules (value(x)::value(y)::Vs,Ms,MINUS::Cs)            = rules(value(y-x)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,TIMES::Cs)            = rules(value(x*y)::Vs,Ms,Cs)
        |  rules (value(x)::value(y)::Vs,Ms,DIV::Cs)              = rules(value(y div x)::Vs,Ms,Cs)
        |  rules (value(x)::value(y)::Vs,Ms,MOD::Cs)              = rules(value(y mod x)::Vs,Ms,Cs)
        |  rules (value(x)::value(y)::Vs,Ms,EQ::Cs)               = if y =  x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,NEQ::Cs)              = if y <> x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,LT::Cs)               = if y <  x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,GT::Cs)               = if y >  x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,LEQ::Cs)              = if y <= x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,GEQ::Cs)              = if y >= x then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,AND::Cs)              = if x <> 0 andalso y <> 0 then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::value(y)::Vs,Ms,OR::Cs)               = if  x <> 0 orelse y <> 0 then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(x)::Vs ,Ms,NEG::Cs)                       = rules(value(~1*x)::Vs,Ms,Cs)
        |  rules (value(x)::Vs ,Ms,NOT::Cs)                       = if  x = 0 then rules(value(1)::Vs,Ms,Cs) else rules(value(0)::Vs,Ms,Cs) 
        |  rules (value(m)::value(x)::Vs ,Ms,SET::Cs)             = (Array.update(Ms,x,m);rules(Vs,Ms,Cs))
        |  rules (value(x)::Vs ,Ms,cmdexp(c)::cmdexp(d)::ITE::Cs) = if x = 0 then rules(Vs,Ms, (d @ Cs)) else rules(Vs,Ms, (c @ Cs))
        |  rules (Vs ,Ms,cmdexp(b)::cmdexp(c)::WH::Cs)            = rules(cmdexp(c)::cmdexp(b)::Vs ,Ms, b @ WH::Cs)
        |  rules (value(x)::cmdexp(c)::cmdexp(b)::Vs ,Ms,WH::Cs)  = if x = 0 then rules(Vs,Ms, Cs) else rules(Vs,Ms,c @ cmdexp(b)::cmdexp(c)::WH::Cs)
        |  rules (value(m)::Vs ,Ms,WRITE::Cs)                     = (print(Int.toString(m)^"\n"); rules(Vs,Ms,Cs) )
        |  rules (Vs ,Ms,pointer(x,t)::READ::Cs) = 
            let
              val p = print("Input: \n")
              val inp  = getinputval( (chomp1 (getText (TextIO.stdIn))) , t)
              val upd = Array.update(Ms,x,inp)
            in
                rules(Vs,Ms,Cs)
            end
        | rules (Vs,Ms,value(x)::Cs)                              = rules(value(x)::Vs,Ms,Cs)
        | rules (Vs,Ms,pointer(x,_)::Cs)                          = rules(value(Array.sub(Ms,x))::Vs,Ms,Cs)
        | rules (Vs,Ms,SEQ::Cs)                                   = rules(Vs,Ms,Cs)

        fun COMtoString com = 
          case com of
              value (x) => Int.toString x
              | pointer(x,_) =>"#"^(Int.toString x)
              | PLUS  => "PLUS" 
              | MINUS => "MINUS"    
              | TIMES => "TIMES"
              | DIV   => "DIV" 
              | MOD   => "MOD" 
              | EQ    => "EQ"
              | NEQ   => "NEQ" 
              | LT    => "LT"   
              | GT    => "GT"   
              | LEQ   => "LEQ"    
              | GEQ   => "GEQ"    
              | AND   => "AND"    
              | OR    => "OR"         
              | NOT   => "NOT"    
              | NEG   => "NEG"   
              | SET   => "SET"    
              | ITE   => "ITE"    
              | WH    => "WH"  
              | READ  => "READ"     
              | WRITE => "WRITE"      
              | SEQ   => "SEQ"
              | cmdexp(c) => (FunStack.toString COMtoString c)^"SEQ"
        fun ComStackString(stck: command Stack):string = (FunStack.toString COMtoString stck)^"\n"
        fun MemToString(mem: M):string = (String.concat (List.map (fn (s,(d,i)) =>"#"^Int.toString(i)^" :"^s^" => "^Int.toString(Array.sub(mem,i))^"; ") (HashTable.listItemsi SymbolTable)))^"\n"
        fun toString(v:V,m:M,c:C) : string = ComStackString(v) ^ MemToString(m) ^ ComStackString(c)

        fun evaluate(AST) = 
          let
            val v: V = []
            val m: M = Array.array(maxMemSize,0)
            val c: C = ASTtoPostfix(AST)
          in
            print(toString (rules (v , m ,c)))
          end

end (*Struct end *)
