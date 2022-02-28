structure While = struct 
structure WhileLrVals = WhileLrValsFun(structure Token = LrParser.Token)
structure WhileLex = WhileLexFun(structure Tokens = WhileLrVals.Tokens);
structure WhileParser =
Join(structure LrParser = LrParser
structure ParserData = WhileLrVals.ParserData
structure Lex = WhileLex)
val invoke = fn lexstream => (* The invoke function invokes the parser given a lexer *)
let val print_error = fn (str,pos,_) =>
TextIO.output(TextIO.stdOut,
"***While Parser Error at character position " ^ (Int.toString pos)
^ "***\n" ^ str^ "\n")
in WhileParser.parse(0,lexstream,print_error,())
end
fun newLexer fcn = (* newLexer creates a lexer from a given input-reading function *)
let val lexer = WhileParser.makeLexer fcn
val _ = WhileLex.UserDeclarations.init()
in lexer
end

fun stringToLexer str = (* creates a lexer from a string *)
let val done = ref false
in newLexer (fn n => if (!done) then "" else (done := true; str))
end
fun fileToLexer filename = (* creates a lexer from a file *)
let val inStream = TextIO.openIn(filename)
in newLexer (fn n => TextIO.inputAll(inStream))
end
fun lexerToParser (lexer) = (* creates a parser from a lexer *)
let val dummyEOF = WhileLrVals.Tokens.EOF(0,0)
val (result,lexer) = invoke lexer
val (nextToken,lexer) = WhileParser.Stream.get lexer
in if WhileParser.sameToken(nextToken,dummyEOF) then
result
else (TextIO.output(TextIO.stdOut,
"*** While PARSER WARNING -- unconsumed input ***\n");
result)
end
val parseString = lexerToParser o stringToLexer (* parses a string *)
val parseFile = lexerToParser o fileToLexer (* parses a file *)
end (* struct *)