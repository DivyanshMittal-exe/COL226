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
%%
%header (functor WhileLexFun(structure Tokens : While_TOKENS));

alpha=[A-Za-z];
digit=[0-9];
ws = [\ |\t];

%%
[\n|\r\n] => (linec := (!linec) + 1; lex());
{ws}+    => (pos := !pos + size yytext;  lex());
{digit}+ => (pos := !pos + size yytext;  Tokens.NUMBER((getInt yytext), !pos, !linec));
"+"      => (pos := !pos + size yytext;  Tokens.PLUS(!pos, !linec));
"-"      => (pos := !pos + size yytext;  Tokens.MINUS(!pos, !linec)); 
"*"      => (pos := !pos + size yytext;  Tokens.TIMES(!pos, !linec));
"/"      => (pos := !pos + size yytext;  Tokens.DIV(!pos, !linec));
"%"      => (pos := !pos + size yytext;  Tokens.MOD(!pos, !linec));
"="      => (pos := !pos + size yytext;  Tokens.EQ(!pos, !linec));
"<>"     => (pos := !pos + size yytext;  Tokens.NEQ(!pos, !linec));
"<"      => (pos := !pos + size yytext;  Tokens.LT(!pos, !linec));
">"      => (pos := !pos + size yytext;  Tokens.GT(!pos, !linec));
"<="     => (pos := !pos + size yytext;  Tokens.LEQ(!pos, !linec));
">="     => (pos := !pos + size yytext;  Tokens.GEQ(!pos, !linec));
"~"      => (pos := !pos + size yytext;  Tokens.NEG(!pos, !linec));
"("      => (pos := !pos + size yytext;  Tokens.LPAREN(!pos, !linec));
")"      => (pos := !pos + size yytext;  Tokens.RPAREN(!pos, !linec));
":="     => (pos := !pos + size yytext;  Tokens.ASSN(!pos, !linec));
":"      => (pos := !pos + size yytext;  Tokens.COLON(!pos, !linec));
"::"     => (pos := !pos + size yytext;  Tokens.SCOPE(!pos, !linec));
","      => (pos := !pos + size yytext;  Tokens.COMMA(!pos, !linec));
";"      => (pos := !pos + size yytext;  Tokens.DELIM(!pos, !linec));
"&&"     => (pos := !pos + size yytext;  Tokens.AND(!pos, !linec));
"||"     => (pos := !pos + size yytext;  Tokens.OR(!pos, !linec));
"!"      => (pos := !pos + size yytext;  Tokens.NOT(!pos, !linec));
"{"      => (pos := !pos + size yytext;  Tokens.LCURL(!pos, !linec));
"}"      => (pos := !pos + size yytext;  Tokens.RCURL(!pos, !linec));
[A-Za-z][A-Za-z0-9]* => (pos := !pos + size yytext;  findKeywords(yytext,!pos, !linec));
.      => (throw(yytext, !pos, !linec); pos := !pos + size yytext;  lex());