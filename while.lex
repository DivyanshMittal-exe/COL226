structure Tokens= Tokens
    type pos = int
    type svalue = Tokens.svalue
    type ('a,'b) token = ('a,'b) Tokens.token  
    type lexresult = (svalue, pos) token
    val linec= ref 0
    val pos = ref 0
    val eof = fn () => Tokens.EOF(!pos, !linec)

    fun throw (text,pos,linec) = print(String.concat[ "Error on line", (Int.toString linec),"at position",(Int.toString pos),": ", text, "\n" ])

    fun getInt i = 
      case Int.fromString(i) of 
          SOME i => i
          | NONE => 0


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
"program"=> (pos := !pos + size yytext;  Tokens.PROGRAM(!pos, !linec));
"var"    => (pos := !pos + size yytext;  Tokens.VAR(!pos, !linec));
"int"    => (pos := !pos + size yytext;  Tokens.INTEGER(!pos, !linec));
"bool"   => (pos := !pos + size yytext;  Tokens.BOOL(!pos, !linec));
"read"   => (pos := !pos + size yytext;  Tokens.READ(!pos, !linec));
"write"  => (pos := !pos + size yytext;  Tokens.WRITE(!pos, !linec));
"if"     => (pos := !pos + size yytext;  Tokens.IF(!pos, !linec));
"then"   => (pos := !pos + size yytext;  Tokens.THEN(!pos, !linec));
"else"   => (pos := !pos + size yytext;  Tokens.ELSE(!pos, !linec));
"endif"  => (pos := !pos + size yytext;  Tokens.ENDIF(!pos, !linec));
"while"  => (pos := !pos + size yytext;  Tokens.WHILE(!pos, !linec));
"do"     => (pos := !pos + size yytext;  Tokens.DO(!pos, !linec));
"endwh"  => (pos := !pos + size yytext;  Tokens.ENDWH(!pos, !linec));
"tt"     => (pos := !pos + size yytext;  Tokens.BTRUE(!pos, !linec));
"ff"     => (pos := !pos + size yytext;  Tokens.BFALSE(!pos, !linec));
[A-Za-z][A-Za-z0-9]* => (pos := !pos + size yytext;  Tokens.IDENTIFIER(yytext,!pos, !linec));
.      => (throw(yytext, !pos, !linec); pos := !pos + size yytext;  lex());