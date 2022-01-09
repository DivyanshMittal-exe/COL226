val maxMemSize = 64
type com = int*int*int*int;
exception invalid_OP_code;
exception divisionByZeroError;
exception modByZeroError;
exception syntaxError;
exception notNumber;
exception outOfBoundMemoryAccess;
exception outOfBoundCodeAccess;
val mem = Array.array(maxMemSize,0)



(* A function I used to debug and print memory  *)
fun debugArr (ar, ind:int) = 
    let 
      val a = Array.sub(ar,ind)
      val t = print(Int.toString(a)^" ")
    in 
      if (ind + 1 < Array.length (ar)) then
        debugArr(ar,ind + 1)
      else 
        print("\n")
    end


(* to remove newline character on reading. Taken from profs website, which he has allowed to use*)
fun chomp1 s =  
    let val charlist = rev (explode s)
        fun nibble [] = []
          | nibble (#"\n"::l) = l
          | nibble l = l
    in  implode (rev (nibble charlist))
    end

(* Takes in string and returns tuple of code *)
fun getCodeTuple l =
    let
      val i = String.tokens(fn x => x = #"\n" orelse x = #"(" orelse x = #")" orelse x = #",") l
      fun getInt i = 
        case Int.fromString(i) of 
          SOME i => i
        | NONE   => 0
      val h = map getInt i 
      val k = if List.length(h) = 4 then 1 else raise syntaxError 
      val [a,b,c,d] = h
    in
      (a,b,c,d)
    end
            
(* Converts input stream to list of code strings *)
fun getline dat = 
    case TextIO.inputLine dat of 
        SOME l => l :: getline dat 
      | NONE   => []  

(* Returns int from string *)
fun getInt i = 
    case Int.fromString(i) of 
      SOME i => i
    | NONE   => raise notNumber

(* Reads file *)
fun read file = Vector.fromList(map getCodeTuple (getline (TextIO.openIn file)) )

(* Main function to interpret *)
fun interpret file = 
    let
        val mem = Array.array(maxMemSize,0)
        val code = read file

        (* This evals given code line loc *)
        fun eval (loc) =  
          let
              val (opc,opd1,opd2,tgt) = Vector.sub(code,loc)     
              val a = 
                if opc <> 0 andalso  opc <> 1 andalso opc <> 14 andalso opc <> 16 then
                  if opd1 >= maxMemSize orelse opd1 < 0  then 
                    raise outOfBoundMemoryAccess
                  else 
                    Array.sub(mem,opd1)
                else
                  0
              
              val b = 
                if opc <> 0 andalso  opc <> 1 andalso opc <> 2 andalso opc <> 3 andalso opc <> 13 andalso opc <> 14 andalso opc <> 15 andalso opc <> 16 then
                  if opd2 >= maxMemSize orelse opd2 < 0 then 
                    raise outOfBoundMemoryAccess
                  else 
                    Array.sub(mem,opd2)
                else
                  0
                
              val tgtError = 
                if opc <> 0 andalso opc <> 15 then 
                  if (opc = 13 orelse opc = 14) andalso (tgt >= Vector.length(code) orelse tgt < 0) then
                    raise outOfBoundCodeAccess
                  else if tgt >= maxMemSize orelse tgt< 0 then 
                    raise outOfBoundMemoryAccess
                  else
                    0 
                else
                  0
              
              val wa = Word.fromInt(a)
              val wb = Word.fromInt(b)

              (* val debug = debugArr(mem,0) *)

          in
              (* Long ifelse to handle opcodes. Could have also done with case, but this was easier *)
              if (opc = 0) then 
                print("")
              
              else if (opc = 1) then 
                  let
                      val p = print("Input: ")
                      val SOME inp = TextIO.inputLine TextIO.stdIn
                      val numb = getInt (chomp1 inp)
                    in
                      (Array.update(mem,tgt,numb);
                      eval(loc+1))
                    end
                  
              else if (opc = 2) then 
                  (Array.update(mem,tgt,a); 
                  eval(loc+1))

              else if (opc = 3) then
                  let
                      val wb= Word.notb(wa)
                      val c = Word.toInt(wb)
                    in
                      (Array.update(mem,tgt,c);
                      eval(loc+1))
                    end

              else if (opc = 4) then
                  let
                      val wc= Word.orb(wa,wb)
                      val wd = Word.toInt(wc)
                    in
                      (Array.update(mem,tgt,wd);
                      eval(loc+1))
                    end

              else if (opc = 5) then
                  let
                      val wc= Word.andb(wa,wb)
                      val wd = Word.toInt(wc)
                    in
                      (Array.update(mem,tgt,wd);
                      eval(loc+1))
                    end

              else if (opc = 6) then
                  (Array.update(mem,tgt,a+b);
                  eval(loc+1))

              else if (opc = 7) then
                  (Array.update(mem,tgt,a-b);
                  eval(loc+1))

              else if (opc = 8) then
                  (Array.update(mem,tgt,a*b);
                  eval(loc+1))

              else if (opc = 9) then
                  if b <> 0  then
                    (Array.update(mem,tgt,a div b);
                    eval(loc+1))
                  else 
                    raise divisionByZeroError

              else if (opc = 10) then
                  if b <> 0  then
                    (Array.update(mem,tgt,a mod b);
                    eval(loc+1))
                  else 
                    raise modByZeroError

              else if (opc = 11) then
                  if a = b then 
                    (Array.update(mem,tgt,1);
                    eval(loc+1))
                  else
                    (Array.update(mem,tgt,0);
                    eval(loc+1))

              else if (opc = 12) then
                  if a > b then 
                    (Array.update(mem,tgt,1);
                    eval(loc+1))
                  else
                    (Array.update(mem,tgt,0);
                    eval(loc+1))

              else if (opc = 13) then
                  if (a = 1) then
                    eval(tgt)
                  else eval(loc+1)

              else if (opc = 14) then
                  eval(tgt)
              
              else if (opc = 15) then
                  (print(Int.toString(a) ^"\n");
                  eval(loc+1))
              
              else if (opc = 16) then
                  (Array.update(mem,tgt,opd1);
                  eval(loc+1))
              else            
                  raise invalid_OP_code
          end
    in 
        (* To start from eval 0 *)
        eval (0)
    end