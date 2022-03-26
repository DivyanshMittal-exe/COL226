functor WhileLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : While_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct

open AST


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\030\000\002\000\029\000\003\000\028\000\004\000\027\000\
\\018\000\026\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\056\000\000\000\
\\001\000\002\000\086\000\009\000\086\000\010\000\086\000\011\000\086\000\
\\015\000\086\000\040\000\086\000\042\000\086\000\000\000\
\\001\000\002\000\087\000\008\000\008\000\009\000\087\000\010\000\087\000\
\\011\000\087\000\015\000\087\000\040\000\087\000\042\000\087\000\000\000\
\\001\000\002\000\088\000\008\000\088\000\009\000\088\000\010\000\088\000\
\\011\000\088\000\015\000\088\000\040\000\088\000\042\000\088\000\000\000\
\\001\000\002\000\004\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\013\000\095\000\014\000\095\000\015\000\013\000\017\000\095\000\
\\040\000\012\000\041\000\095\000\042\000\095\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\013\000\095\000\015\000\013\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\014\000\095\000\015\000\013\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\017\000\095\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\040\000\012\000\041\000\095\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\040\000\012\000\042\000\095\000\000\000\
\\001\000\002\000\019\000\000\000\
\\001\000\002\000\033\000\000\000\
\\001\000\005\000\061\000\006\000\060\000\000\000\
\\001\000\007\000\003\000\000\000\
\\001\000\012\000\101\000\016\000\101\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\101\000\
\\024\000\101\000\025\000\101\000\026\000\101\000\027\000\101\000\
\\028\000\101\000\031\000\101\000\036\000\101\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\102\000\016\000\102\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\102\000\
\\024\000\102\000\025\000\102\000\026\000\102\000\027\000\102\000\
\\028\000\102\000\031\000\102\000\036\000\102\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\103\000\016\000\103\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\103\000\
\\024\000\103\000\025\000\103\000\026\000\103\000\027\000\103\000\
\\028\000\103\000\031\000\103\000\036\000\103\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\104\000\016\000\104\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\104\000\
\\024\000\104\000\025\000\104\000\026\000\104\000\027\000\104\000\
\\028\000\104\000\031\000\104\000\036\000\104\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\105\000\016\000\105\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\105\000\
\\024\000\105\000\025\000\105\000\026\000\105\000\027\000\105\000\
\\028\000\105\000\031\000\105\000\036\000\105\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\106\000\016\000\106\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\106\000\
\\024\000\106\000\025\000\106\000\026\000\106\000\027\000\106\000\
\\028\000\106\000\031\000\106\000\036\000\106\000\037\000\040\000\
\\038\000\039\000\000\000\
\\001\000\012\000\107\000\016\000\107\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\107\000\
\\024\000\107\000\025\000\107\000\026\000\107\000\027\000\107\000\
\\028\000\107\000\031\000\107\000\036\000\107\000\037\000\107\000\
\\038\000\107\000\000\000\
\\001\000\012\000\108\000\016\000\108\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\108\000\
\\024\000\108\000\025\000\108\000\026\000\108\000\027\000\108\000\
\\028\000\108\000\031\000\108\000\036\000\108\000\037\000\040\000\
\\038\000\108\000\000\000\
\\001\000\012\000\109\000\016\000\109\000\018\000\109\000\019\000\109\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\109\000\
\\024\000\109\000\025\000\109\000\026\000\109\000\027\000\109\000\
\\028\000\109\000\031\000\109\000\036\000\109\000\037\000\109\000\
\\038\000\109\000\000\000\
\\001\000\012\000\110\000\016\000\110\000\018\000\110\000\019\000\110\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\110\000\
\\024\000\110\000\025\000\110\000\026\000\110\000\027\000\110\000\
\\028\000\110\000\031\000\110\000\036\000\110\000\037\000\110\000\
\\038\000\110\000\000\000\
\\001\000\012\000\111\000\016\000\111\000\018\000\111\000\019\000\111\000\
\\020\000\111\000\021\000\111\000\022\000\111\000\023\000\111\000\
\\024\000\111\000\025\000\111\000\026\000\111\000\027\000\111\000\
\\028\000\111\000\031\000\111\000\036\000\111\000\037\000\111\000\
\\038\000\111\000\000\000\
\\001\000\012\000\112\000\016\000\112\000\018\000\112\000\019\000\112\000\
\\020\000\112\000\021\000\112\000\022\000\112\000\023\000\112\000\
\\024\000\112\000\025\000\112\000\026\000\112\000\027\000\112\000\
\\028\000\112\000\031\000\112\000\036\000\112\000\037\000\112\000\
\\038\000\112\000\000\000\
\\001\000\012\000\113\000\016\000\113\000\018\000\113\000\019\000\113\000\
\\020\000\113\000\021\000\113\000\022\000\113\000\023\000\113\000\
\\024\000\113\000\025\000\113\000\026\000\113\000\027\000\113\000\
\\028\000\113\000\031\000\113\000\036\000\113\000\037\000\113\000\
\\038\000\113\000\000\000\
\\001\000\012\000\114\000\016\000\114\000\018\000\114\000\019\000\114\000\
\\020\000\114\000\021\000\114\000\022\000\114\000\023\000\114\000\
\\024\000\114\000\025\000\114\000\026\000\114\000\027\000\114\000\
\\028\000\114\000\031\000\114\000\036\000\114\000\037\000\114\000\
\\038\000\114\000\000\000\
\\001\000\012\000\115\000\016\000\115\000\018\000\115\000\019\000\115\000\
\\020\000\115\000\021\000\115\000\022\000\115\000\023\000\115\000\
\\024\000\115\000\025\000\115\000\026\000\115\000\027\000\115\000\
\\028\000\115\000\031\000\115\000\036\000\115\000\037\000\115\000\
\\038\000\115\000\000\000\
\\001\000\012\000\116\000\016\000\116\000\018\000\116\000\019\000\116\000\
\\020\000\116\000\021\000\116\000\022\000\116\000\023\000\116\000\
\\024\000\116\000\025\000\116\000\026\000\116\000\027\000\116\000\
\\028\000\116\000\031\000\116\000\036\000\116\000\037\000\116\000\
\\038\000\116\000\000\000\
\\001\000\012\000\117\000\016\000\117\000\018\000\117\000\019\000\117\000\
\\020\000\117\000\021\000\117\000\022\000\117\000\023\000\117\000\
\\024\000\117\000\025\000\117\000\026\000\117\000\027\000\117\000\
\\028\000\117\000\031\000\117\000\036\000\117\000\037\000\117\000\
\\038\000\117\000\000\000\
\\001\000\012\000\118\000\016\000\118\000\018\000\118\000\019\000\118\000\
\\020\000\118\000\021\000\118\000\022\000\118\000\023\000\118\000\
\\024\000\118\000\025\000\118\000\026\000\118\000\027\000\118\000\
\\028\000\118\000\031\000\118\000\036\000\118\000\037\000\118\000\
\\038\000\118\000\000\000\
\\001\000\012\000\119\000\016\000\119\000\018\000\119\000\019\000\119\000\
\\020\000\119\000\021\000\119\000\022\000\119\000\023\000\119\000\
\\024\000\119\000\025\000\119\000\026\000\119\000\027\000\119\000\
\\028\000\119\000\031\000\119\000\036\000\119\000\037\000\119\000\
\\038\000\119\000\000\000\
\\001\000\012\000\120\000\016\000\120\000\018\000\120\000\019\000\120\000\
\\020\000\120\000\021\000\120\000\022\000\120\000\023\000\120\000\
\\024\000\120\000\025\000\120\000\026\000\120\000\027\000\120\000\
\\028\000\120\000\031\000\120\000\036\000\120\000\037\000\120\000\
\\038\000\120\000\000\000\
\\001\000\012\000\121\000\016\000\121\000\018\000\121\000\019\000\121\000\
\\020\000\121\000\021\000\121\000\022\000\121\000\023\000\121\000\
\\024\000\121\000\025\000\121\000\026\000\121\000\027\000\121\000\
\\028\000\121\000\031\000\121\000\036\000\121\000\037\000\121\000\
\\038\000\121\000\000\000\
\\001\000\012\000\057\000\018\000\051\000\019\000\050\000\020\000\049\000\
\\021\000\048\000\022\000\047\000\023\000\046\000\024\000\045\000\
\\025\000\044\000\026\000\043\000\027\000\042\000\028\000\041\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\013\000\093\000\014\000\093\000\017\000\093\000\041\000\093\000\
\\042\000\093\000\000\000\
\\001\000\013\000\094\000\014\000\094\000\017\000\094\000\041\000\094\000\
\\042\000\094\000\000\000\
\\001\000\013\000\081\000\000\000\
\\001\000\014\000\083\000\000\000\
\\001\000\016\000\052\000\018\000\051\000\019\000\050\000\020\000\049\000\
\\021\000\048\000\022\000\047\000\023\000\046\000\024\000\045\000\
\\025\000\044\000\026\000\043\000\027\000\042\000\028\000\041\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\017\000\080\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\031\000\077\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\096\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\098\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\032\000\034\000\000\000\
\\001\000\033\000\091\000\035\000\036\000\000\000\
\\001\000\033\000\092\000\000\000\
\\001\000\033\000\035\000\000\000\
\\001\000\034\000\005\000\000\000\
\\001\000\036\000\089\000\000\000\
\\001\000\036\000\090\000\000\000\
\\001\000\036\000\097\000\000\000\
\\001\000\036\000\099\000\000\000\
\\001\000\036\000\100\000\000\000\
\\001\000\036\000\020\000\000\000\
\\001\000\036\000\079\000\000\000\
\\001\000\041\000\038\000\000\000\
\\001\000\042\000\000\000\000\000\
\\001\000\042\000\085\000\000\000\
\"
val actionRowNumbers =
"\015\000\005\000\051\000\003\000\
\\003\000\011\000\012\000\002\000\
\\057\000\061\000\010\000\000\000\
\\000\000\000\000\013\000\047\000\
\\050\000\048\000\006\000\059\000\
\\042\000\000\000\000\000\000\000\
\\001\000\033\000\032\000\036\000\
\\034\000\037\000\046\000\054\000\
\\000\000\014\000\012\000\039\000\
\\038\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\
\\000\000\000\000\009\000\031\000\
\\044\000\030\000\035\000\007\000\
\\045\000\058\000\052\000\053\000\
\\049\000\023\000\022\000\020\000\
\\017\000\019\000\016\000\021\000\
\\018\000\028\000\027\000\026\000\
\\025\000\024\000\043\000\029\000\
\\040\000\004\000\056\000\008\000\
\\041\000\055\000\060\000"
val gotoT =
"\
\\001\000\082\000\000\000\
\\000\000\
\\000\000\
\\002\000\005\000\003\000\004\000\000\000\
\\002\000\007\000\003\000\004\000\000\000\
\\004\000\009\000\005\000\008\000\000\000\
\\006\000\016\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\019\000\005\000\008\000\000\000\
\\008\000\020\000\000\000\
\\008\000\029\000\000\000\
\\008\000\030\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\035\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\008\000\051\000\000\000\
\\008\000\052\000\000\000\
\\008\000\053\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\056\000\000\000\
\\009\000\057\000\000\000\
\\006\000\060\000\000\000\
\\000\000\
\\000\000\
\\008\000\061\000\000\000\
\\008\000\062\000\000\000\
\\008\000\063\000\000\000\
\\008\000\064\000\000\000\
\\008\000\065\000\000\000\
\\008\000\066\000\000\000\
\\008\000\067\000\000\000\
\\008\000\068\000\000\000\
\\008\000\069\000\000\000\
\\008\000\070\000\000\000\
\\008\000\071\000\000\000\
\\008\000\072\000\000\000\
\\008\000\073\000\000\000\
\\004\000\074\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\076\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\080\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 83
val numrules = 37
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | IDENTIFIER of unit ->  (string) | NUMBER of unit ->  (int)
 | Type of unit ->  (dtypes) | expression of unit ->  (Exp)
 | var of unit ->  (string) | varlist of unit ->  (string list)
 | command of unit ->  (CMD) | command_seq of unit ->  (CMD list)
 | decleration of unit ->  (DEC)
 | decleration_seq of unit ->  (DEC list) | srt of unit ->  (PROG)
end
type svalue = MlyValue.svalue
type result = PROG
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 41) => true | _ => false
val showTerminal =
fn (T 0) => "NUMBER"
  | (T 1) => "IDENTIFIER"
  | (T 2) => "BTRUE"
  | (T 3) => "BFALSE"
  | (T 4) => "INT"
  | (T 5) => "BOOL"
  | (T 6) => "PROGRAM"
  | (T 7) => "VAR"
  | (T 8) => "READ"
  | (T 9) => "WRITE"
  | (T 10) => "IF"
  | (T 11) => "THEN"
  | (T 12) => "ELSE"
  | (T 13) => "ENDIF"
  | (T 14) => "WHILE"
  | (T 15) => "DO"
  | (T 16) => "ENDWH"
  | (T 17) => "PLUS"
  | (T 18) => "MINUS"
  | (T 19) => "TIMES"
  | (T 20) => "DIV"
  | (T 21) => "MOD"
  | (T 22) => "EQ"
  | (T 23) => "NEQ"
  | (T 24) => "LT"
  | (T 25) => "GT"
  | (T 26) => "LEQ"
  | (T 27) => "GEQ"
  | (T 28) => "NEG"
  | (T 29) => "LPAREN"
  | (T 30) => "RPAREN"
  | (T 31) => "ASSN"
  | (T 32) => "COLON"
  | (T 33) => "SCOPE"
  | (T 34) => "COMMA"
  | (T 35) => "DELIM"
  | (T 36) => "AND"
  | (T 37) => "OR"
  | (T 38) => "NOT"
  | (T 39) => "LCURL"
  | (T 40) => "RCURL"
  | (T 41) => "EOF"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38) $$ (T 37) $$ (T 36) $$ (T 35)
 $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28)
 $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21)
 $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14)
 $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7)
 $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 3) $$ (T 2)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.command_seq command_seq1, _, 
command_seq1right)) :: ( _, ( MlyValue.decleration_seq 
decleration_seq1, _, _)) :: _ :: ( _, ( MlyValue.IDENTIFIER 
IDENTIFIER1, _, _)) :: ( _, ( _, PROGRAM1left, _)) :: rest671)) => let
 val  result = MlyValue.srt (fn _ => let val  (IDENTIFIER as 
IDENTIFIER1) = IDENTIFIER1 ()
 val  (decleration_seq as decleration_seq1) = decleration_seq1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((PROG(IDENTIFIER,decleration_seq,command_seq)))
end)
 in ( LrTable.NT 0, ( result, PROGRAM1left, command_seq1right), 
rest671)
end
|  ( 1, ( ( _, ( MlyValue.decleration_seq decleration_seq1, _, 
decleration_seq1right)) :: ( _, ( MlyValue.decleration decleration1, 
decleration1left, _)) :: rest671)) => let val  result = 
MlyValue.decleration_seq (fn _ => let val  (decleration as 
decleration1) = decleration1 ()
 val  (decleration_seq as decleration_seq1) = decleration_seq1 ()
 in ((decleration::decleration_seq))
end)
 in ( LrTable.NT 1, ( result, decleration1left, decleration_seq1right)
, rest671)
end
|  ( 2, ( rest671)) => let val  result = MlyValue.decleration_seq (fn
 _ => ([]))
 in ( LrTable.NT 1, ( result, defaultPos, defaultPos), rest671)
end
|  ( 3, ( ( _, ( _, _, DELIM1right)) :: ( _, ( MlyValue.Type Type1, _,
 _)) :: _ :: ( _, ( MlyValue.varlist varlist1, _, _)) :: ( _, ( _, 
VAR1left, _)) :: rest671)) => let val  result = MlyValue.decleration
 (fn _ => let val  (varlist as varlist1) = varlist1 ()
 val  (Type as Type1) = Type1 ()
 in ((DEC(varlist,Type)))
end)
 in ( LrTable.NT 2, ( result, VAR1left, DELIM1right), rest671)
end
|  ( 4, ( ( _, ( _, BOOL1left, BOOL1right)) :: rest671)) => let val  
result = MlyValue.Type (fn _ => ((BOOL)))
 in ( LrTable.NT 8, ( result, BOOL1left, BOOL1right), rest671)
end
|  ( 5, ( ( _, ( _, INT1left, INT1right)) :: rest671)) => let val  
result = MlyValue.Type (fn _ => ((INT)))
 in ( LrTable.NT 8, ( result, INT1left, INT1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, 
IDENTIFIER1right)) :: rest671)) => let val  result = MlyValue.varlist
 (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 in ([IDENTIFIER])
end)
 in ( LrTable.NT 5, ( result, IDENTIFIER1left, IDENTIFIER1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.varlist varlist1, _, varlist1right)) :: _ ::
 ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, _)) :: 
rest671)) => let val  result = MlyValue.varlist (fn _ => let val  (
IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 val  (varlist as varlist1) = varlist1 ()
 in ((IDENTIFIER::varlist))
end)
 in ( LrTable.NT 5, ( result, IDENTIFIER1left, varlist1right), rest671
)
end
|  ( 8, ( ( _, ( _, _, RCURL1right)) :: ( _, ( MlyValue.command_seq 
command_seq1, _, _)) :: ( _, ( _, LCURL1left, _)) :: rest671)) => let
 val  result = MlyValue.command_seq (fn _ => let val  (command_seq as 
command_seq1) = command_seq1 ()
 in ((command_seq))
end)
 in ( LrTable.NT 3, ( result, LCURL1left, RCURL1right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.command_seq command_seq1, _, 
command_seq1right)) :: _ :: ( _, ( MlyValue.command command1, 
command1left, _)) :: rest671)) => let val  result = 
MlyValue.command_seq (fn _ => let val  (command as command1) = 
command1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((command::command_seq))
end)
 in ( LrTable.NT 3, ( result, command1left, command_seq1right), 
rest671)
end
|  ( 10, ( rest671)) => let val  result = MlyValue.command_seq (fn _
 => ([]))
 in ( LrTable.NT 3, ( result, defaultPos, defaultPos), rest671)
end
|  ( 11, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: _ :: ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, _)
) :: rest671)) => let val  result = MlyValue.command (fn _ => let val 
 (IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 val  (expression as expression1) = expression1 ()
 in ((SET(IDENTIFIER,expression)))
end)
 in ( LrTable.NT 4, ( result, IDENTIFIER1left, expression1right), 
rest671)
end
|  ( 12, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, _, IDENTIFIER1right
)) :: ( _, ( _, READ1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = 
IDENTIFIER1 ()
 in ((READ(IDENTIFIER)))
end)
 in ( LrTable.NT 4, ( result, READ1left, IDENTIFIER1right), rest671)

end
|  ( 13, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, WRITE1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((WRITE(expression)))
end)
 in ( LrTable.NT 4, ( result, WRITE1left, expression1right), rest671)

end
|  ( 14, ( ( _, ( _, _, ENDIF1right)) :: ( _, ( MlyValue.command_seq 
command_seq2, _, _)) :: _ :: ( _, ( MlyValue.command_seq command_seq1,
 _, _)) :: _ :: ( _, ( MlyValue.expression expression1, _, _)) :: ( _,
 ( _, IF1left, _)) :: rest671)) => let val  result = MlyValue.command
 (fn _ => let val  (expression as expression1) = expression1 ()
 val  command_seq1 = command_seq1 ()
 val  command_seq2 = command_seq2 ()
 in ((ITE(expression,command_seq1,command_seq2)))
end)
 in ( LrTable.NT 4, ( result, IF1left, ENDIF1right), rest671)
end
|  ( 15, ( ( _, ( _, _, ENDWH1right)) :: ( _, ( MlyValue.command_seq 
command_seq1, _, _)) :: _ :: ( _, ( MlyValue.expression expression1, _
, _)) :: ( _, ( _, WHILE1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (expression as expression1) = 
expression1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((WH(expression,command_seq)))
end)
 in ( LrTable.NT 4, ( result, WHILE1left, ENDWH1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 17, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 18, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((EQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 19, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 21, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((NEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 22, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((AND(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 23, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((OR(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 24, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((PLUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 25, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MINUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 26, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((TIMES(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 27, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((DIV(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 28, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MOD(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 29, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.expression 
expression1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => let val  (expression as 
expression1) = expression1 ()
 in ((expression))
end)
 in ( LrTable.NT 7, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, NEG1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((NEG(expression)))
end)
 in ( LrTable.NT 7, ( result, NEG1left, expression1right), rest671)

end
|  ( 31, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, NOT1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((NOT(expression)))
end)
 in ( LrTable.NT 7, ( result, NOT1left, expression1right), rest671)

end
|  ( 32, ( ( _, ( _, BTRUE1left, BTRUE1right)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => ((BOOLEAN(true))))
 in ( LrTable.NT 7, ( result, BTRUE1left, BTRUE1right), rest671)
end
|  ( 33, ( ( _, ( _, BFALSE1left, BFALSE1right)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => ((BOOLEAN(false))))
 in ( LrTable.NT 7, ( result, BFALSE1left, BFALSE1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.NUMBER NUMBER1, NUMBER1left, NUMBER1right))
 :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  (NUMBER as NUMBER1) = NUMBER1 ()
 in ((NUM(NUMBER)))
end)
 in ( LrTable.NT 7, ( result, NUMBER1left, NUMBER1right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.NUMBER NUMBER1, _, NUMBER1right)) :: ( _, (
 _, PLUS1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (NUMBER as NUMBER1) = NUMBER1 ()
 in ((NUM(NUMBER)))
end)
 in ( LrTable.NT 7, ( result, PLUS1left, NUMBER1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, 
IDENTIFIER1right)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = 
IDENTIFIER1 ()
 in ((VAR(IDENTIFIER)))
end)
 in ( LrTable.NT 7, ( result, IDENTIFIER1left, IDENTIFIER1right), 
rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.srt x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : While_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun NUMBER (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.NUMBER (fn () => i),p1,p2))
fun IDENTIFIER (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.IDENTIFIER (fn () => i),p1,p2))
fun BTRUE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun BFALSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun INT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun BOOL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun PROGRAM (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun READ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun WRITE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun ENDIF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun ENDWH (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun DIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun MOD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun LEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun GEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun NEG (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun SCOPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun DELIM (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun NOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun LCURL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun RCURL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
end
end
