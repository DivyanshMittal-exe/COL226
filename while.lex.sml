structure while_lex=
   struct
    structure UserDeclarations =
      struct
structure Tokens= Tokens
    type pos = int
    type svalue = Tokens.svalue
    type ('a,'b) token = ('a,'b) Tokens.token  
    type lexresult = (svalue, pos) token
    type lexarg = string
    type arg = lexarg


    val linec= ref 0
    val eof = fn () => Tokens.EOF(!pos, !linec)

    fun throw (text,linec) = TextIO.output (TextIO.stdOut, String.concat[
            "Error on line", (Int.toString linec),": ", text, "\n"
        ])


  val keywords =
  [
   ("program",Tokens.PROGRAM),
    ("var",Tokens.VAR),
    ("int",Tokens.INT),
    ("bool",Tokens.BOOL),
    ("read",Tokens.READ),
    ("write",Tokens.WRITE),
    ("if",Tokens.IF),
    ("then",Tokens.THEN),
    ("else",Tokens.ELSE),
    ("endif",Tokens.ENDIF),
    ("while",Tokens.WHILE),
    ("do",Tokens.DO),
    ("endwh",Tokens.ENDWH)
   ]
   fun getInt i = 
    case Int.fromString(i) of 
        SOME i => i
        | NONE   => 0

  fun findKeywords(str,pos,linec) =
  case List.find (fn (s, _) => s = str )  keywords of 
    SOME (_, token) => token(pos, linec) 
  | NONE => Tokens.IDENTIFIER (str, pos,linec)

end (* end of user routines *)
exception LexError (* raised if illegal leaf action tried *)
structure Internal =
	struct

datatype yyfinstate = N of int
type statedata = {fin : yyfinstate list, trans: string}
(* transition & final state table *)
val tab = let
val s = [ 
 (0, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (1, 
"\003\003\003\003\003\003\003\003\003\038\041\003\003\040\003\003\
\\003\003\003\003\003\003\003\003\003\003\003\003\003\003\003\003\
\\038\037\003\003\003\036\034\003\033\032\031\030\029\028\003\027\
\\025\025\025\025\025\025\025\025\025\025\022\021\018\017\015\003\
\\003\009\009\009\009\009\009\009\009\009\009\009\009\009\009\009\
\\009\009\009\009\009\009\009\009\009\009\009\003\003\003\003\003\
\\003\009\009\009\009\009\013\009\009\009\009\009\009\009\009\009\
\\009\009\009\009\011\009\009\009\009\009\009\008\006\005\004\003\
\\003"
),
 (6, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\007\000\000\000\
\\000"
),
 (9, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\000\
\\000\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\
\\000\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\
\\000"
),
 (11, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\000\
\\000\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\
\\000\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\012\010\010\010\010\010\010\000\000\000\000\000\
\\000"
),
 (13, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\000\
\\000\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\
\\000\010\010\010\010\010\014\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\000\000\000\000\000\
\\000"
),
 (15, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (18, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\020\019\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (22, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\024\000\000\023\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (25, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\026\026\026\026\026\026\026\026\026\026\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (34, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\035\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (38, 
"\000\000\000\000\000\000\000\000\000\039\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\039\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
(0, "")]
fun f x = x 
val s = List.map f (List.rev (tl (List.rev s))) 
exception LexHackingError 
fun look ((j,x)::r, i: int) = if i = j then x else look(r, i) 
  | look ([], i) = raise LexHackingError
fun g {fin=x, trans=i} = {fin=x, trans=look(s,i)} 
in Vector.fromList(List.map g 
[{fin = [], trans = 0},
{fin = [], trans = 1},
{fin = [], trans = 1},
{fin = [(N 73)], trans = 0},
{fin = [(N 40),(N 73)], trans = 0},
{fin = [(N 68),(N 73)], trans = 0},
{fin = [(N 1),(N 73)], trans = 6},
{fin = [(N 62)], trans = 0},
{fin = [(N 66),(N 73)], trans = 0},
{fin = [(N 71),(N 73)], trans = 9},
{fin = [(N 71)], trans = 9},
{fin = [(N 71),(N 73)], trans = 11},
{fin = [(N 10),(N 71)], trans = 9},
{fin = [(N 71),(N 73)], trans = 13},
{fin = [(N 13),(N 71)], trans = 9},
{fin = [(N 32),(N 73)], trans = 15},
{fin = [(N 38)], trans = 0},
{fin = [(N 25),(N 73)], trans = 0},
{fin = [(N 30),(N 73)], trans = 18},
{fin = [(N 28)], trans = 0},
{fin = [(N 35)], trans = 0},
{fin = [(N 56),(N 73)], trans = 0},
{fin = [(N 49),(N 73)], trans = 22},
{fin = [(N 47)], trans = 0},
{fin = [(N 52)], trans = 0},
{fin = [(N 7),(N 73)], trans = 25},
{fin = [(N 7)], trans = 25},
{fin = [(N 21),(N 73)], trans = 0},
{fin = [(N 17),(N 73)], trans = 0},
{fin = [(N 54),(N 73)], trans = 0},
{fin = [(N 15),(N 73)], trans = 0},
{fin = [(N 19),(N 73)], trans = 0},
{fin = [(N 44),(N 73)], trans = 0},
{fin = [(N 42),(N 73)], trans = 0},
{fin = [(N 73)], trans = 34},
{fin = [(N 59)], trans = 0},
{fin = [(N 23),(N 73)], trans = 0},
{fin = [(N 64),(N 73)], trans = 0},
{fin = [(N 4),(N 73)], trans = 38},
{fin = [(N 4)], trans = 38},
{fin = [(N 1),(N 73)], trans = 0},
{fin = [(N 1)], trans = 0}])
end
structure StartStates =
	struct
	datatype yystartstate = STARTSTATE of int

(* start state definitions *)

val INITIAL = STARTSTATE 1;

end
type result = UserDeclarations.lexresult
	exception LexerError (* raised if illegal leaf action tried *)
end

fun makeLexer yyinput =
let	val yygone0=1
	val yyb = ref "\n" 		(* buffer *)
	val yybl = ref 1		(*buffer length *)
	val yybufpos = ref 1		(* location of next character to use *)
	val yygone = ref yygone0	(* position in file of beginning of buffer *)
	val yydone = ref false		(* eof found yet? *)
	val yybegin = ref 1		(*Current 'start state' for lexer *)

	val YYBEGIN = fn (Internal.StartStates.STARTSTATE x) =>
		 yybegin := x

fun lex () : Internal.result =
let fun continue() = lex() in
  let fun scan (s,AcceptingLeaves : Internal.yyfinstate list list,l,i0) =
	let fun action (i,nil) = raise LexError
	| action (i,nil::l) = action (i-1,l)
	| action (i,(node::acts)::l) =
		case node of
		    Internal.N yyk => 
			(let fun yymktext() = String.substring(!yyb,i0,i-i0)
			     val yypos = i0+ !yygone
			open UserDeclarations Internal.StartStates
 in (yybufpos := i; case yyk of 

			(* Application actions *)

  1 => (linec := (!linec) + 1; pos := 0; lex())
| 10 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.BOOLVAL(true, !pos, !linec) end
| 13 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.BOOLVAL(false, !pos, !linec) end
| 15 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.PLUS(!pos, !linec) end
| 17 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.MINUS(!pos, !linec) end
| 19 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.MUL(!pos, !linec) end
| 21 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.DIV(!pos, !linec) end
| 23 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.MOD(!pos, !linec) end
| 25 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.EQ(!pos, !linec) end
| 28 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.NEQ(!pos, !linec) end
| 30 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.LT(!pos, !linec) end
| 32 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.GT(!pos, !linec) end
| 35 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.LE(!pos, !linec) end
| 38 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.GE(!pos, !linec) end
| 4 => let val yytext=yymktext() in pos := !pos \+ size yytext;  lex() end
| 40 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.NEGATE(!pos, !linec) end
| 42 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.LPAREN(!pos, !linec) end
| 44 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.RPAREN(!pos, !linec) end
| 47 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.ASSN(!pos, !linec) end
| 49 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.COLON(!pos, !linec) end
| 52 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.SCOPE(!pos, !linec) end
| 54 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.COMMA(!pos, !linec) end
| 56 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.DELIM(!pos, !linec) end
| 59 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.AND(!pos, !linec) end
| 62 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.OR(!pos, !linec) end
| 64 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.NOT(!pos, !linec) end
| 66 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.LCURL(!pos, !linec) end
| 68 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.RCURL(!pos, !linec) end
| 7 => let val yytext=yymktext() in pos := !pos \+ size yytext;  Tokens.NUMBER((getInt yytext), !pos, !linec) end
| 71 => let val yytext=yymktext() in pos := !pos \+ size yytext;  findKeywords(yytext,!pos, !linec) end
| 73 => let val yytext=yymktext() in throw(yytext, !linec); pos := !pos \+ size yytext;  lex() end
| _ => raise Internal.LexerError

		) end )

	val {fin,trans} = Unsafe.Vector.sub(Internal.tab, s)
	val NewAcceptingLeaves = fin::AcceptingLeaves
	in if l = !yybl then
	     if trans = #trans(Vector.sub(Internal.tab,0))
	       then action(l,NewAcceptingLeaves
) else	    let val newchars= if !yydone then "" else yyinput 1024
	    in if (String.size newchars)=0
		  then (yydone := true;
		        if (l=i0) then UserDeclarations.eof ()
		                  else action(l,NewAcceptingLeaves))
		  else (if i0=l then yyb := newchars
		     else yyb := String.substring(!yyb,i0,l-i0)^newchars;
		     yygone := !yygone+i0;
		     yybl := String.size (!yyb);
		     scan (s,AcceptingLeaves,l-i0,0))
	    end
	  else let val NewChar = Char.ord(Unsafe.CharVector.sub(!yyb,l))
		val NewChar = if NewChar<128 then NewChar else 128
		val NewState = Char.ord(Unsafe.CharVector.sub(trans,NewChar))
		in if NewState=0 then action(l,NewAcceptingLeaves)
		else scan(NewState,NewAcceptingLeaves,l+1,i0)
	end
	end
(*
	val start= if String.substring(!yyb,!yybufpos-1,1)="\n"
then !yybegin+1 else !yybegin
*)
	in scan(!yybegin (* start *),nil,!yybufpos,!yybufpos)
    end
end
  in lex
  end
end
