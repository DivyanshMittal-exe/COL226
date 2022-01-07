
val maxMemSize = 64;
type com = int*int*int*int;
exception invalidOP;
exception notNumber;
val mem = Array.array(maxMemSize,0)


fun debugArr (ar, ind:int) = 
      let 
        val a = Array.sub(ar,ind)
        (* val nInd = ind + 1 *)
        val t = print(Int.toString(a))
      in 
        if (ind + 1 < Array.length (ar)) then
          debugArr(ar,ind + 1)
        else 
          print("\n")
      end

fun read file =  
  let
      val codestring = TextIO.openIn file  
      fun getline dat = 
          case TextIO.inputLine dat of 
              SOME l => l :: getline dat 
            | NONE      => []

        fun getCode l =
            let
              val i = String.tokens(fn x => x = #"\n" orelse x = #"(" orelse x = #")" orelse x = #",") l
              fun getInt i = 
                case Int.fromString(i) of 
                  SOME i => i
                | NONE   => 0
              val h = map getInt i 
              val [a,b,c,d] = h
            in
              (a,b,c,d)
            end
        (* let
         fun getF i = hd (String.tokens(fn x => x = #"\n") i)
         fun getI i = String.tokens(fn x => x = #" ") (getF i)
         fun getInt i  = map (fn x => Int.fromString(x)) (getI i)
         fun getS [] = []
            | getS i = 
            case hd(i) of
                  SOME l => l :: getS (tl i)
                | NONE      => []

         fun getT i = 
            let
                val [a,b,c,d] = i
            in
                (a,b,c,d)
            end
        in
            getT((getS  (getInt l)))
        end; *)
      (* fun makeVec [] = nil
        | makeVec lst = hd lst::makeVec tl lst *)

      val code = getline codestring
      val vec = map getCode code      
  in 
    Vector.fromList(vec)
  end ;



fun interpret file = 
    let
        
        val code = read file
        fun eval (loc) =
          let
            val (opc,opd1,opd2,tgt) = Vector.sub(code,loc)
            (* val deb = debugArr(mem,0) *)
           
          in
            if (opc = 0) then 
              print("Program Halting\n")
            
            else if (opc = 1) then 
              let
                val h = print("Inpt: \n")
                val SOME inp = TextIO.inputLine TextIO.stdIn

                fun chomp1 s =  (* to remove newline character on reading *)
                      let val charlist = rev (explode s)
                          fun nibble [] = []
                            | nibble (#"\n"::l) = l
                            | nibble l = l
                      in  implode (rev (nibble charlist))
                      end
                val k = chomp1 inp
                fun getInt i = 
                  case Int.fromString(i) of 
                    SOME i => i
                  | NONE   => raise notNumber
                val numb = getInt k
                val up = Array.update(mem,tgt,numb)
              in
                eval(loc+1)
              end


            
            else if (opc = 2) then 
              let
                val a = Array.sub(mem,opd1)
                val up = Array.update(mem,tgt,a)
              in
                eval(loc+1)
              end


            
            else if (opc = 3) then
            let
                val a = Array.sub(mem,opd1)
                val wa = Word.fromInt(a)
                val wb= Word.notb(wa)
                val wc = Word.toInt(wb)
                val up = Array.update(mem,tgt,wc)
              in
                eval(loc+1)
              end



            else if (opc = 4) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val wa = Word.fromInt(a)
                val wb = Word.fromInt(a)
                val wc= Word.orb(wa,wb)
                val wd = Word.toInt(wc)
                val up = Array.update(mem,tgt,wd)
              in
                eval(loc+1)
              end

            else if (opc = 5) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val wa = Word.fromInt(a)
                val wb = Word.fromInt(a)
                val wc= Word.andb(wa,wb)
                val wd = Word.toInt(wc)
                val up = Array.update(mem,tgt,wd)
              in
                eval(loc+1)
              end

            else if (opc = 6) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val up = Array.update(mem,tgt,a+b)
              in
                eval(loc+1)
              end
            

            else if (opc = 7) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val up = Array.update(mem,tgt,a-b)
              in
                eval(loc+1)
              end

            else if (opc = 8) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val up = Array.update(mem,tgt,a*b)
              in
                eval(loc+1)
              end

            else if (opc = 9) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val up = Array.update(mem,tgt,a div b)
              in
                eval(loc+1)
              end

            else if (opc = 10) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                val up = Array.update(mem,tgt,a mod b)
              in
                eval(loc+1)
              end
            
            else if (opc = 11) then
            let 
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2)
                
                fun f th = 
                  if a = b then
                     1 
                  else  0
                val upd = f 0
                val up = Array.update(mem,tgt,upd)
              in
                eval(loc+1)
              end

            else if (opc = 12) then
            let
                val a = Array.sub(mem,opd1)
                val b = Array.sub(mem,opd2) 
                fun f th = 
                  if a > b then
                     1 
                  else 0
                val upd = f 0
                val up = Array.update(mem,tgt,upd)
              in
                eval(loc+1)
              end
            

            else if (opc = 13) then
            let
                val updloc = 0
                val updB = Array.sub(mem,opd1)
              in
                if (updB = 1) then
                  eval(tgt)
                else eval(loc+1)

              end


            else if (opc = 14) then
              eval(tgt)
            
            else if (opc = 15) then
              let 
                val out = Array.sub(mem,opd1)
                val up = print(Int.toString(out) ^"\n")
              in 
                eval(loc+1)
              end
            
            else if (opc = 16) then
              let 
                val up = Array.update(mem,tgt,opd1)
              in 
                eval(loc+1)
              end
              
            else            
             raise invalidOP
          end
    in 
        eval (0)
    end