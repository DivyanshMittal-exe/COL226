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
                | EMPTYCOM

signature VMC =
sig
    type V
    type M
    type C
    exception Error of string
    val ASTtoPostfix: PROG -> C
    val postfix: CMD list ->  C
    val rules:  V*M*C -> V*M*C
    val evaluate: PROG  -> unit
    val toString :  V*M*C -> string
    val ComStackString: C -> string 
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

      and postfix ([]) : C = [EMPTYCOM]
        | postfix ([command]) : C  = 
            (case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] 
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] 
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ postfix(command_seq1) @ postfix(command_seq2) @ [ITE] 
                |AST.WH(expn,command_seq1)                  => EXPtoPostfix(expn) @ postfix(command_seq1) @ [WH] )
          
          | postfix (command :: command_seq) : C  = 
              case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET] @  postfix(command_seq) @ [SEQ]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] @ postfix(command_seq) @ [SEQ]
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] @ postfix(command_seq) @ [SEQ]
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ postfix(command_seq1) @ postfix(command_seq2) @ [ITE]  @ postfix(command_seq) @ [SEQ]
                |AST.WH(expn,command_seq1)                  => EXPtoPostfix(expn) @ postfix(command_seq1) @ [WH] @ postfix(command_seq) @ [SEQ]

 
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

    fun getLast(com) = 
      let
        val x = List.rev com
      in
        hd x
      end

    and remlast(com) = List.rev (tl (List.rev com))


    and 
       splitCommand([],count,left) = ([],left)
      |splitCommand(x::xs,count,left) =
        if count = 1  then 
          (List.rev left, List.rev (x::xs))
        else 
          splitCommand(xs,updCount(x,count),left @ [x])

    and rules(Vs,Ms,[]) = (Vs,Ms,[])
      |rules(Vs,Ms,Cs) =
        case getLast Cs of
           READ => let
              val pointer(x,t) = hd Cs
              val p = print("Input: \n")
              val inp  = getinputval( (chomp1 (getText (TextIO.stdIn))) , t)
              val upd = Array.update(Ms,x,inp)
            in
                (Vs,Ms,[])
            end
           
         | WRITE => let
           val exp = (remlast(Cs))
           val (Vn,Mn,Cn) = ruleseval(Vs,Ms,exp)
           (* val p = print(ComStackString(remlast(Cs))) *)
           val value(ac) = hd Vn 
           val p = print(Int.toString(ac)^"\n")
         in
            (tl Vn,Mn,Cn) 
         end
         | SET => let
           val exp = tl(remlast(Cs))
           val value(loc) = hd(Cs)

           val (v,m,c) = ruleseval (Vs,Ms,exp) 
           val value(ac) = hd v 
           val up = Array.update(Ms,loc,ac)
           (* val p = print(ComStackString(exp))
           val p = print(ComStackString(v))
           val p = print(ComStackString(c))
           val p = print("ss") *)
           (*val p = print(ComStackString(c))*)
         in
           (tl v,m,c)
         end 
         |ITE => let
           val (c1,c_process) = (splitCommand(List.rev( remlast(Cs)),0,[]))
           val (c2,expLeft) = (splitCommand(List.rev (c_process),0,[]))
           val (valst,mem,con) = ruleseval (Vs,Ms,expLeft)
           val value(doweeval) = hd valst

          in
            if doweeval = 1 then 
                (tl valst,mem, c2)
              else
                (tl valst,mem, c1)
              
          end
          | WH => let
            val (c1,expLeft) = (splitCommand(List.rev (remlast(Cs)),0,[]))
            (* val p = print("Am here\n")
            val p = print(ComStackString(c1))
            val p = print(ComStackString(expLeft)) *)
            val (valst,mem,con) = ruleseval (Vs,Ms,expLeft)
            val value(doweeval) = hd valst
            (* val p = print(Int.toString(doweeval)^"\n") *)


          in
            if doweeval = 1 then 
                (tl valst,mem, c1 @ Cs)
              else
                (tl valst,mem, [])
          end
          |  EMPTYCOM => 
             (Vs,Ms,tl Cs)

          (* | SEQ => executer(Vs,Ms,remlast(Cs))
            let
              val (c1,expLeft) = (splitCommand(List.rev (remlast(Cs)),0,[]))
              val (valst,mem,con) = rules (Vs,Ms,c1)
            in
              (valst,mem,con@expLeft)
            end *)
          (* |x => (print(COMtoString(x));raise Error("s")) *)
        
         

    and  ruleseval (Vs,Ms,[]) = (Vs,Ms,[])
        |  ruleseval (value(x)::value(y)::Vs,Ms,PLUS::Cs)             = ruleseval(value(x+y)::Vs,Ms,Cs)
        |  ruleseval (value(x)::value(y)::Vs,Ms,MINUS::Cs)            = ruleseval(value(y-x)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,TIMES::Cs)            = ruleseval(value(x*y)::Vs,Ms,Cs)
        |  ruleseval (value(x)::value(y)::Vs,Ms,DIV::Cs)              = ruleseval(value(y div x)::Vs,Ms,Cs)
        |  ruleseval (value(x)::value(y)::Vs,Ms,MOD::Cs)              = ruleseval(value(y mod x)::Vs,Ms,Cs)
        |  ruleseval (value(x)::value(y)::Vs,Ms,EQ::Cs)               = if y =  x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,NEQ::Cs)              = if y <> x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,LT::Cs)               = if y <  x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,GT::Cs)               = if y >  x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,LEQ::Cs)              = if y <= x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,GEQ::Cs)              = if y >= x then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,AND::Cs)              = if x <> 0 andalso y <> 0 then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::value(y)::Vs,Ms,OR::Cs)               = if  x <> 0 orelse y <> 0 then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        |  ruleseval (value(x)::Vs ,Ms,NEG::Cs)                       = ruleseval(value(~1*x)::Vs,Ms,Cs)
        |  ruleseval (value(x)::Vs ,Ms,NOT::Cs)                       = if  x = 0 then ruleseval(value(1)::Vs,Ms,Cs) else ruleseval(value(0)::Vs,Ms,Cs) 
        (* |  rules (value(m)::value(x)::Vs ,Ms,SET::Cs)             = (Array.update(Ms,x,m);rules(Vs,Ms,Cs))
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
            end *)
        | ruleseval (Vs,Ms,value(x)::Cs)                              = ruleseval(value(x)::Vs,Ms,Cs)
        | ruleseval (Vs,Ms,pointer(x,_)::Cs)                          = ruleseval(value(Array.sub(Ms,x))::Vs,Ms,Cs)
        | ruleseval (Vs,Ms,EMPTYCOM::Cs)                              = (Vs,Ms,Cs)
        (* | rules (Vs,Ms,SEQ::Cs)                                   = rules(Vs,Ms,Cs) *)

        
        and getCommand([],count,left) =  (left,[])
          |getCommand(SEQ::xs,0,left) = getCommand(xs,0,left)
          |getCommand(x::xs,count,left) =

          if ((x = READ orelse x = WRITE ) andalso count = 1 ) orelse  ((x = SET orelse x = SEQ orelse x = WH) andalso count = 2 ) orelse  ((x = ITE) andalso count = 3 ) orelse (x = EMPTYCOM andalso count = 0) then 
           (left @ [x],xs)
          else 
            (getCommand(xs,updCount(x,count),left @ [x]))

        and updCount(com,count) = 
          case com of
              value(_) => count + 1
            | pointer(_,_) => count + 1
            | PLUS  => count - 1     
            | MINUS => count - 1         
            | TIMES => count - 1     
            | DIV   => count - 1    
            | MOD   => count - 1    
            | EQ    => count - 1  
            | NEQ   => count - 1    
            | LT    => count - 1     
            | GT    => count - 1     
            | LEQ   => count - 1       
            | GEQ   => count - 1       
            | AND   => count - 1       
            | OR    => count - 1           
            | NOT   => count        
            | NEG   => count     
            | SET   => count - 1
            | ITE   => count - 2 
            | WH    => count - 1     
            | READ  => count         
            | WRITE => count           
            | SEQ   => count - 1
            | EMPTYCOM => count + 1
        
        and executer (v,m,c) = 
          let
            val (ex,com_left) = (getCommand(c,0,[]))
            (* val e = print("Strt\n")
            val p = print(ComStackString(c))
            val p = print(ComStackString(ex))
            val d = print(ComStackString(com_left))
            val f = print("ef\n") *)



            (* val l = length ex
            val com_left = FunStack.drop(com,l) *)
            val (valst,mem,con) = rules (v,m,ex)

            (* val p = print(ComStackString(valst))
            val p = print(ComStackString(con @ com_left))
            val p = print("Done") *)

          in
            if con @ com_left <> [] then
              executer(valst,mem,con @ com_left)
            else 
              (valst,mem,con @ com_left)
          end

        and COMtoString com = 
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
              | EMPTYCOM => "EMPTYCOM"

        and ComStackString(stck: command Stack):string = (FunStack.toString COMtoString stck)^"\n"
        fun MemToString(mem: M):string = (String.concat (List.map (fn (s,(d,i)) =>"#"^Int.toString(i)^" :"^s^" => "^Int.toString(Array.sub(mem,i))^"; ") (HashTable.listItemsi SymbolTable)))^"\n"
        fun toString(v:V,m:M,c:C) : string = ComStackString(v) ^ MemToString(m) ^ ComStackString(c)

        fun evaluate(AST) = 
          let
            val v: V = []
            val m: M = Array.array(maxMemSize,0)
            val c: C = ASTtoPostfix(AST)
          in
            print(toString (executer (v , m ,c)))
          end

end (*Struct end *)
