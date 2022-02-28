structure WhileLrVals = WhileLrValsFun(structure Token = LrParser.Token)
structure WhileLex = WhileLexFun(structure Tokens = WhileLrVals.Tokens);
structure WhileParser =
	  Join(structure LrParser = LrParser
     	       structure ParserData = WhileLrVals.ParserData
     	       structure Lex = WhileLex)
     
fun invoke lexstream =
		let fun print_error (s, pos, col) =
		    	TextIO.output(TextIO.stdOut, "Syntax Error: " ^ (Int.toString pos) ^ ":" ^ (Int.toString col) ^ ":" ^ s ^ "\n")
		in
		    WhileParser.parse(0,lexstream,print_error,())
		end

fun stringToLexer str =
    let val done = ref false
    	val lexer =  WhileParser.makeLexer (fn _ => if (!done) then "" else (done:=true;str))
    in
	lexer
    end	
		
fun parse (lexer) =
    let val dummyEOF = WhileLrVals.Tokens.EOF(0,0)
    	val (result, lexer) = invoke lexer
	val (nextToken, lexer) = WhileParser.Stream.get lexer
    in
        if WhileParser.sameToken(nextToken, dummyEOF) then result
 	else (TextIO.output(TextIO.stdOut, "Warning: Unconsumed input \n"); result)
    end

val parseString = parse o stringToLexer


fun parseFile (file) = 
	let
		val In = TextIO.openIn(file)
		val s = TextIO.inputAll(In)
		val tree = parseString s;
		val _ = TextIO.closeIn(In)

	in
		print_Program(tree)
end 

val args = CommandLine.arguments()
val file = List.nth(args, 0)

fun main() = (parseFile(file))

val _ = main()