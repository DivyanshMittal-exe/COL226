val maxMemSize = 64;
type com = int*int*int*int;


fun interpret file =  
  let
      val codestring = TextIO.openIn file  
      fun getline dat = 
          case TextIO.inputLine dat of 
              SOME l => l :: getline dat 
            | NONE      => []

      fun getCode l =
        let
         fun getF i = hd (String.tokens(fn x => x = #"\n") i)
         fun getI i = String.tokens(fn x => x = #" ") (getF i)
         fun getInt i  = map (fn x => Int.fromString(x)) (getI i)
         fun getS [] = []
            | getS i = 
            case hd(i) of
                  SOME l => l :: getS (tl i)
                | NONE      => []
        in
            Vector.fromList(getS  (getInt l))
        end;
      (* fun makeVec [] = nil
        | makeVec lst = hd lst::makeVec tl lst *)

      val code = getline codestring
      val vec = map getCode code      
  in 
    vec
  end 