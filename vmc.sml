open AST
open FunStack
exception Invalid_var
exception notNumber
exception Unmatched

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
    val postfix: CMD list ->  C
    val rules:  V*M*C -> V*M*C
    val evaluate: PROG  -> V*M*C
    val toString :  V*M*C -> string
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
        (case Int.fromString(i) of 
            SOME i => i
          | NONE   => raise notNumber)
         handle notNumber =>(print("Entered value is not an integer"); 0)

      fun getText dat = 
          case TextIO.inputLine dat of 
            SOME l => l
          | NONE   =>"" 

      fun getinputval(text, dtype) = 
(          case dtype of
             BOOL => (
               case text of 
                  "tt" => 1
                  |"ff" => 0
                  | _ => raise type_mismatch
             )
           | INT => getInt(text)      )      

           handle type_mismatch =>(print("Entered value not bool"); 0)  


      (* Converts AST to postfix *)
      fun ASTtoPostfix(PROG(_,decleration_seq,command_seq)) : command Stack = (makeSymbolTable(decleration_seq);postfix(command_seq)) 

      and postfix ([]) : command Stack = [EMPTYCOM]
        | postfix ([command]) : command Stack  = 
            (case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] 
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] 
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ postfix(command_seq1) @ postfix(command_seq2) @ [ITE] 
                |AST.WH(expn,command_seq1)                  => EXPtoPostfix(expn)@ postfix(command_seq1) @ [WH] )
          
          | postfix (command :: command_seq) : command Stack  = (
              case command of
                (AST.SET(id,expn))                          => [value(lookUp(id))] @ EXPtoPostfix(expn) @ [SET] @  postfix(command_seq) @ [SEQ]
                |(AST.READ(id))                             => [pointer(lookUp(id),lookUpType(id))] @ [READ] @ postfix(command_seq) @ [SEQ]
                |(AST.WRITE(expn))                          => EXPtoPostfix(expn) @ [WRITE] @ postfix(command_seq) @ [SEQ]
                |AST.ITE(expn,command_seq1,command_seq2)    => EXPtoPostfix(expn) @ postfix(command_seq1) @ postfix(command_seq2) @ [ITE]  @ postfix(command_seq) @ [SEQ]
                |AST.WH(expn,command_seq1)                  =>  EXPtoPostfix(expn) @ postfix(command_seq1) @ [WH]@ postfix(command_seq) @ [SEQ])

 
      and EXPtoPostfix(expression : Exp ): command Stack  = 
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

    (* Top 2 values of Stack *)
    fun get2val(Vs) = 
(    let
      val SOME (value(x),xs) = FunStack.poptop Vs
      val SOME (value(y),ys) = FunStack.poptop xs
    in
        (x,y,ys)
    end)

    (* Concats List with Stack *)
    fun concat (list,stck) = FunStack.list2stack(list@FunStack.stack2list(stck))

    fun getLast(com) = 
      let
        val x = List.rev (FunStack.stack2list com)
      in
        FunStack.top x
      end

    and remlast(com) = List.rev (FunStack.pop (List.rev (FunStack.stack2list com)))
    
    and 
       splitCommand([],count,left) = ([],left)
      |splitCommand(x::xs,count,left) =
        if count = 1  then 
          (List.rev left, List.rev (x::xs))
        else 
          splitCommand(xs,updCount(x,count),left @ [x])

    and rules(Vs,Ms,[]) = (Vs,Ms,[])
      |rules(Vs,Ms,Cs) =
(        case getLast Cs of
           READ => let
              val pointer(x,t) = FunStack.top Cs
              val p = print("Input: \n")
              val inp  = getinputval( (chomp1 (getText (TextIO.stdIn))) , t)
              val upd = Array.update(Ms,x,inp)
            in
                (Vs,Ms,[])
            end
           
         | WRITE => let
           val exp = (remlast(Cs))
           val (Vn,Mn,Cn) = ruleseval(Vs,Ms,exp)
           val value(ac) = FunStack.top Vn 
           val p = print(Int.toString(ac)^"\n")
         in
            (FunStack.pop Vn,Mn,Cn) 
         end
         | SET => let
           val exp = FunStack.pop(remlast(Cs))
           val value(loc) = FunStack.top(Cs)

           val (v,m,c) = ruleseval (Vs,Ms,exp) 
           val value(ac) = FunStack.top v 
           val up = Array.update(Ms,loc,ac)
         in
           (FunStack.pop v,m,c)
         end 
         |ITE => let
           val (c1,c_process) = (splitCommand(List.rev( remlast(Cs)),0,[]))
           val (c2,expLeft) = (splitCommand(List.rev (c_process),0,[]))
           val (valst,mem,con) = ruleseval (Vs,Ms,expLeft)
           val value(doweeval) = FunStack.top valst

          in
            if doweeval = 1 then 
                (FunStack.pop valst,mem, c2)
              else
                (FunStack.pop valst,mem, c1)
              
          end
          | WH => let
            val (c1,expLeft) = (splitCommand(List.rev (remlast(Cs)),0,[]))
            val (valst,mem,con) = ruleseval (Vs,Ms,expLeft)
            val value(doweeval) = FunStack.top valst
          in
            if doweeval = 1 then 
                (FunStack.pop valst,mem, c1 @ Cs)
              else
                (FunStack.pop valst,mem, [])
          end
          |  EMPTYCOM => 
             (Vs,Ms,FunStack.pop Cs)
            | _ => raise Unmatched
          
            )
          handle Bind => (print("Non binding error");([],Ms,[]))
                |EmptyStack => (print("Stack is empty");([],Ms,[]))
                |Unmatched => (print("Invalid command");([],Ms,[]))


    and ruleseval (Vs: V,Ms: M,Cs: C) =
        (case FunStack.poptop Cs of
          NONE => (Vs,Ms,Cs)
        | SOME (commandpopped,xs) => (
          case commandpopped of 
             value(x) => ruleseval(FunStack.push(value(x),Vs),Ms,xs)
            | PLUS  => let val (x,y,Vn) = get2val(Vs) in ruleseval(FunStack.push(value(x+y),Vn),Ms,xs) end
            | MINUS => let val (x,y,Vn) = get2val(Vs) in ruleseval(FunStack.push(value(y-x),Vn),Ms,xs) end 
            | TIMES => let val (x,y,Vn) = get2val(Vs) in ruleseval(FunStack.push(value(x*y),Vn),Ms,xs) end
            | DIV   => let val (x,y,Vn) = get2val(Vs) in ruleseval(FunStack.push(value(y div x),Vn),Ms,xs) end
            | MOD   => let val (x,y,Vn) = get2val(Vs) in ruleseval(FunStack.push(value(y mod x),Vn),Ms,xs) end
            | EQ    => let val (x,y,Vn) = get2val(Vs) in if y =  x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | NEQ   => let val (x,y,Vn) = get2val(Vs) in if y <> x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | LT    => let val (x,y,Vn) = get2val(Vs) in if y <  x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | GT    => let val (x,y,Vn) = get2val(Vs) in if y >  x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | LEQ   => let val (x,y,Vn) = get2val(Vs) in if y <= x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | GEQ   => let val (x,y,Vn) = get2val(Vs) in if y >= x then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | AND   => let val (x,y,Vn) = get2val(Vs) in if x <> 0 andalso y <> 0 then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | OR    => let val (x,y,Vn) = get2val(Vs) in if x <> 0 orelse y <> 0 then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs) end
            | NEG   => let val SOME (value(x),Vn) =  FunStack.poptop(Vs) in ruleseval(FunStack.push(value(~1*x),Vn),Ms,xs) end
            | NOT   => let val SOME (value(x),Vn) =  FunStack.poptop(Vs) in if  x = 0 then ruleseval(FunStack.push(value(1),Vn),Ms,xs) else ruleseval(FunStack.push(value(0),Vn),Ms,xs)   end
            |pointer(a,_) => ruleseval(FunStack.push(value(Array.sub(Ms,a)),Vs),Ms,xs)
            | EMPTYCOM => (Vs,Ms,xs)
            | _ => raise Unmatched
        )) 
        handle Div => (print("Division by zero");([],Ms,[]))
            |Unmatched => (print("Invalid expression");([],Ms,[]))

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
            val (valst,mem,con) = rules (v,m,ex)
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
            executer (v , m ,c)
          end

end (*Struct end *)
