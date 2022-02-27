structure T= Tokens
    type pos = int
    type svalue = T.svalue
    type ('a,'b) token = ('a,'b) T.token  
    type lexresult = (svalue, pos) token
    type lexarg = string
    type arg = lexarg


    val linec= ref 0
    val pos = ref 0
    val eof = fn () => T.EOF(!pos, !linec)

    fun throw (text,linec) = TextIO.output (TextIO.stdOut, String.concat[
            "Error on line", (Int.toString linec),": ", text, "\n"
        ])


  val keywords =
  [
   ("program",T.PROGRAM),
    ("var",T.VAR),
    ("int",T.INT),
    ("bool",T.BOOL),
    ("read",T.READ),
    ("write",T.WRITE),
    ("if",T.IF),
    ("then",T.THEN),
    ("else",T.ELSE),
    ("endif",T.ENDIF),
    ("while",T.WHILE),
    ("do",T.DO),
    ("endwh",T.ENDWH)
   ]
   fun getInt i = 
    case Int.fromString(i) of 
        SOME i => i
        | NONE   => 0

  fun findKeywords(str,pos,linec) =
  case List.find (fn (s, _) => s = str )  keywords of 
    SOME (_, token) => token(pos, linec) 
  | NONE => T.IDENTIFIER (str, pos,linec)

%%
%header (functor WhileLexFun(structure T:While_Tokens));

alpha=[A-Za-z];
digit=[0-9];
ws = [\ \t];
%%
[\n|\r\n]  => (linec := (!linec) + 1; lex());
{ws}+    => (pos := !pos \+ size yytext;  lex());
{digit}+ => (pos := !pos \+ size yytext;  T.NUMBER((getInt yytext), !pos, !linec));
"tt"     => (pos := !pos \+ size yytext;  T.BOOLVAL(true, !pos, !linec));
"ff"     => (pos := !pos \+ size yytext;  T.BOOLVAL(false, !pos, !linec));
"+"      => (pos := !pos \+ size yytext;  T.PLUS(!pos, !linec));
"-"      => (pos := !pos \+ size yytext;  T.MINUS(!pos, !linec)); 
"*"      => (pos := !pos \+ size yytext;  T.MUL(!pos, !linec));
"/"      => (pos := !pos \+ size yytext;  T.DIV(!pos, !linec));
"%"      => (pos := !pos \+ size yytext;  T.MOD(!pos, !linec));
"="      => (pos := !pos \+ size yytext;  T.EQ(!pos, !linec));
"<>"     => (pos := !pos \+ size yytext;  T.NEQ(!pos, !linec));
"<"      => (pos := !pos \+ size yytext;  T.LT(!pos, !linec));
">"      => (pos := !pos \+ size yytext;  T.GT(!pos, !linec));
"<="     => (pos := !pos \+ size yytext;  T.LE(!pos, !linec));
">="     => (pos := !pos \+ size yytext;  T.GE(!pos, !linec));
"~"      => (pos := !pos \+ size yytext;  T.NEGATE(!pos, !linec));
"("      => (pos := !pos \+ size yytext;  T.LPAREN(!pos, !linec));
")"      => (pos := !pos \+ size yytext;  T.RPAREN(!pos, !linec));
":="     => (pos := !pos \+ size yytext;  T.ASSN(!pos, !linec));
":"      => (pos := !pos \+ size yytext;  T.COLON(!pos, !linec));
"::"      => (pos := !pos \+ size yytext;  T.SCOPE(!pos, !linec));
","      => (pos := !pos \+ size yytext;  T.COMMA(!pos, !linec));
";"      => (pos := !pos \+ size yytext;  T.DELIM(!pos, !linec));
"&&"     => (pos := !pos \+ size yytext;  T.AND(!pos, !linec));
"||"     => (pos := !pos \+ size yytext;  T.OR(!pos, !linec));
"!"      => (pos := !pos \+ size yytext;  T.NOT(!pos, !linec));
"{"      => (pos := !pos \+ size yytext;  T.LCURL(!pos, !linec));
"}"      => (pos := !pos \+ size yytext;  T.RCURL(!pos, !linec));
[A-Za-z][A-Za-z0-9]* => (pos := !pos \+ size yytext;  findKeywords(yytext,!pos, !linec));
.      => (throw(yytext, !linec); pos := !pos \+ size yytext;  lex());