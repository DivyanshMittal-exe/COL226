structure While = struct
structure WhileLrVals = WhileLrValsFun(structure Token = LrParser.Token)
structure WhileLex = WhileLexFun(structure Tokens = WhileLrVals.Tokens);
structure WhileParser =
    Join(structure LrParser = LrParser
    structure ParserData = WhileLrVals.ParserData
    structure Lex = WhileLex)

val invoke = fn lexstream => 
    let val print_error = fn (text,pos,linec) => print(String.concat[ "Error on line", (Int.toString linec),"at position",(Int.toString pos),": ", text, "\n" ])
    in 
        WhileParser.parse(0,lexstream,print_error,())
    end

fun newLexer fcn = 
    let 
        val lexer = WhileParser.makeLexer fcn
        val _ = WhileLex.UserDeclarations.init()
    in 
        lexer
    end
fun fileToLexer filename = 
    let 
        val inStream = TextIO.openIn(filename)
    in 
        newLexer (fn n => TextIO.inputAll(inStream))
    end
fun lexerToParser (lexer) = 
    let 
        val dummyEOF = WhileLrVals.Tokens.EOF(0,0)
        val (result,lexer) = invoke lexer
        val (nextToken,lexer) = WhileParser.Stream.get lexer
    in 
        if WhileParser.sameToken(nextToken,dummyEOF) then
            result
        else 
            (print("Input Not consumed");result)
    end

val parseFile = lexerToParser o fileToLexer

end