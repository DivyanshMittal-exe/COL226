functor WhileLexFun(structure Tokens : While_TOKENS)=
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
    val pos = ref 0
    val eof = fn () => Tokens.EOF(!pos, !linec)

    fun throw (text,pos,linec) = print(String.concat[ "Error on line", (Int.toString linec),"at position",(Int.toString pos),": ", text, "\n" ])


  val keywords =
  [
   ("program",Tokens.PROGRAM),
    ("var",Tokens.VAR),
    ("int",Tokens.INTEGER),
    ("bool",Tokens.BOOL),
    ("read",Tokens.READ),
    ("write",Tokens.WRITE),
    ("if",Tokens.IF),
    ("then",Tokens.THEN),
    ("else",Tokens.ELSE),
    ("endif",Tokens.ENDIF),
    ("while",Tokens.WHILE),
    ("do",Tokens.DO),
    ("endwh",Tokens.ENDWH),
    ("tt",Tokens.BTRUE),
    ("ff",Tokens.BFALSE)
   ]

   fun getInt i = 
    case Int.fromString(i) of 
        SOME i => i
        | NONE   => 0

  fun findKeywords(match,pos,linec) =
  case List.find (fn (s, _) => s = match )  keywords of 
    SOME (_, token) => token(pos, linec) 
  | NONE => Tokens.IDENTIFIER (match, pos,linec)

fun init() = ()
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
"\003\003\003\003\003\003\003\003\003\035\037\003\003\036\003\003\
\\003\003\003\003\003\003\003\003\003\003\003\003\003\003\003\003\
\\035\034\003\003\003\033\031\003\030\029\028\027\026\025\003\024\
\\022\022\022\022\022\022\022\022\022\022\019\018\015\014\012\003\
\\003\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\003\003\003\003\003\
\\003\010\010\010\010\010\010\010\010\010\010\010\010\010\010\010\
\\010\010\010\010\010\010\010\010\010\010\010\009\006\005\004\003\
\\003"
),
 (6, 
"\000\000\000\000\000\000\000\000\000\008\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\008\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\007\000\000\000\
\\000"
),
 (7, 
"\000\000\000\000\000\000\000\000\000\008\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\008\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\008\000\000\000\
\\000"
),
 (10, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\011\011\011\011\011\011\011\011\011\011\000\000\000\000\000\000\
\\000\011\011\011\011\011\011\011\011\011\011\011\011\011\011\011\
\\011\011\011\011\011\011\011\011\011\011\011\000\000\000\000\000\
\\000\011\011\011\011\011\011\011\011\011\011\011\011\011\011\011\
\\011\011\011\011\011\011\011\011\011\011\011\000\000\000\000\000\
\\000"
),
 (12, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\013\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (15, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\017\016\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (19, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\021\000\000\020\000\000\
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
\\023\023\023\023\023\023\023\023\023\023\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
),
 (31, 
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\032\000\000\000\000\000\000\000\000\000\
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
{fin = [(N 67)], trans = 0},
{fin = [(N 34),(N 67)], trans = 0},
{fin = [(N 62),(N 67)], trans = 0},
{fin = [(N 1),(N 4),(N 67)], trans = 6},
{fin = [(N 4),(N 56)], trans = 7},
{fin = [(N 4)], trans = 7},
{fin = [(N 60),(N 67)], trans = 0},
{fin = [(N 65),(N 67)], trans = 10},
{fin = [(N 65)], trans = 10},
{fin = [(N 26),(N 67)], trans = 12},
{fin = [(N 32)], trans = 0},
{fin = [(N 19),(N 67)], trans = 0},
{fin = [(N 24),(N 67)], trans = 15},
{fin = [(N 22)], trans = 0},
{fin = [(N 29)], trans = 0},
{fin = [(N 50),(N 67)], trans = 0},
{fin = [(N 43),(N 67)], trans = 19},
{fin = [(N 41)], trans = 0},
{fin = [(N 46)], trans = 0},
{fin = [(N 7),(N 67)], trans = 22},
{fin = [(N 7)], trans = 22},
{fin = [(N 15),(N 67)], trans = 0},
{fin = [(N 11),(N 67)], trans = 0},
{fin = [(N 48),(N 67)], trans = 0},
{fin = [(N 9),(N 67)], trans = 0},
{fin = [(N 13),(N 67)], trans = 0},
{fin = [(N 38),(N 67)], trans = 0},
{fin = [(N 36),(N 67)], trans = 0},
{fin = [(N 67)], trans = 31},
{fin = [(N 53)], trans = 0},
{fin = [(N 17),(N 67)], trans = 0},
{fin = [(N 58),(N 67)], trans = 0},
{fin = [(N 4),(N 67)], trans = 7},
{fin = [(N 1),(N 67)], trans = 0},
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

  1 => (linec := (!linec) + 1; lex())
| 11 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.MINUS(!pos, !linec) end
| 13 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.TIMES(!pos, !linec) end
| 15 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.DIV(!pos, !linec) end
| 17 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.MOD(!pos, !linec) end
| 19 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.EQ(!pos, !linec) end
| 22 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.NEQ(!pos, !linec) end
| 24 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.LT(!pos, !linec) end
| 26 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.GT(!pos, !linec) end
| 29 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.LEQ(!pos, !linec) end
| 32 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.GEQ(!pos, !linec) end
| 34 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.NEG(!pos, !linec) end
| 36 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.LPAREN(!pos, !linec) end
| 38 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.RPAREN(!pos, !linec) end
| 4 => let val yytext=yymktext() in pos := !pos + size yytext;  lex() end
| 41 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.ASSN(!pos, !linec) end
| 43 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.COLON(!pos, !linec) end
| 46 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.SCOPE(!pos, !linec) end
| 48 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.COMMA(!pos, !linec) end
| 50 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.DELIM(!pos, !linec) end
| 53 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.AND(!pos, !linec) end
| 56 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.OR(!pos, !linec) end
| 58 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.NOT(!pos, !linec) end
| 60 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.LCURL(!pos, !linec) end
| 62 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.RCURL(!pos, !linec) end
| 65 => let val yytext=yymktext() in pos := !pos + size yytext;  findKeywords(yytext,!pos, !linec) end
| 67 => let val yytext=yymktext() in throw(yytext, !pos, !linec); pos := !pos + size yytext;  lex() end
| 7 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.NUMBER((getInt yytext), !pos, !linec) end
| 9 => let val yytext=yymktext() in pos := !pos + size yytext;  Tokens.PLUS(!pos, !linec) end
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
