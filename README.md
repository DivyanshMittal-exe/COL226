# COL 226: Programming Languages

## Design and Implementation Decisions
Since the given EBNF has reduce reduce conflicts, for a) bool exp and int exp , b) negation of a number become ambigous . Along with it, since we need to support expressions like tt < ff, we need to modify the language The concept of having bool exp,bool factor, int exp etc have all been changed to one single "expression". To check the validity of a statement, I have implemented a type checker. It essentially keeps a list of tuple of (variable name, type) and makes sure that when a binary operation or unary operation is done on an expression then that is correct type. Eg if we have Expression + Expression, where one is of integer type and other a bool, this throws an error. To remove the negation problem, any integer is read as it is, and if a ~ character is present in front, it gets read seperately as a NEG token. Thus both these conflicts are resolved. 

To make sure precedence is followed, that the grammar given specifies, we use the Yacc's feature of specifying precedence. 

## Running the code

To parse and create an AST file run 
    ```
        make

        parseFile "filename";
    ```

To parse and create an AST file without type checking run 
    ```
        make

        parseFileNTC "filename";
    ```


## Context Free Grammar

Below is the EBNF of the grammar I implement as EBNF

```
Program="program", identifier, "::", Block;
Block=DeclarationSeq, CommandSeq;
DeclarationSeq={Declaration};
Declaration="var", VariableList, ":",Type,";";
Type = "int"|"bool";
VariableList = Variable, {",", Variable};
CommandSeq="{",{Command,";"},"}" ;

Command=
    Variable,":=",Expression|
    "read", Variable|
    "write", Expression|
    "if", Expression, "then", CommandSeq|
    "else", CommandSeq|
    "endif"|
    "while", Expression, "do", CommandSeq|
    "endwh" ;

Expression=
    Expression, "+", Expression|
    Expression, "-", Expression|
    Expression, "*", Expression|
    Expression, "/", Expression|
    Expression, "%", Expression|
    "~", Expression |
    Expression, "||", Expression| 
    Expression, "&&", Expression| 
    "(",Expression, ")"|
    "!",Expression|
    Variable|
    Comparison|
    Numeral|
    "tt"|
    "ff";


Comparison=
    Expression, "<",  Expression|
    Expression, "<=", Expression|
    Expression, "=",  Expression|
    Expression, ">",  Expression|
    Expression, ">=", Expression|
    Expression, "<>", Expression;

Variable = Identifier;
Identifier=Letter,{Letter|Digit} ;
Numeral=Digit,{Digit} ;
Character=Letter|Digit;
Letter=UpperCase|LowerCase;

UpperCase="A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|
"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|
"R"|"S"|"T"|"U"|"V "|"W"|"X"|"Y "|"Z";
LowerCase="a"|"b"|"c"|"d"|"e"|"f"|"g"|"h"|
"i"|"j"|"k"|"l"|"m"|"n"|"o"|"p"|"q"|
"r"|"s"|"t"|"u"|"v"|"w"|"x"|"y"|"z";
Digit="0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
```

## Railroad
<img src = "ebnfrailroad.png" width = "700px">

## AST datatype definition
 
```
datatype Prog = Prog of string*(Dec list)*(Command list)
and      Dec = Dec of (string list)*dtypes
and      dtypes = INTEGER|BOOL
and      Command = Set of string*Exp
                  |Read of string
                  |Write of Exp
                  |ite of Exp*(Command list)*(Command list)
                  |while_exp of Exp*(Command list)
and      Exp =  LT of Exp*Exp|
                LEQ of Exp*Exp|
                EQ of Exp*Exp|
                GT of Exp*Exp|
                GEQ of Exp*Exp|
                NEQ of Exp*Exp|
                NOT of Exp|
                AND of Exp*Exp|
                OR of Exp*Exp|
                PLUS of Exp*Exp|
                MINUS of Exp*Exp|
                TIMES of Exp*Exp|
                DIV of Exp*Exp|
                MOD of Exp*Exp|
                NEG of Exp|
                NUM of int|
                BOOLEAN of bool|
                VAR of string
```
## Semantic directed translations
```
srt: PROGRAM IDENTIFIER SCOPE decleration_seq command_seq ((Prog(IDENTIFIER,decleration_seq,command_seq)))

decleration_seq: decleration decleration_seq ((decleration::decleration_seq))
      |                      ([])

decleration: VAR varlist COLON Type DELIM ((Dec(varlist,Type)))

Type: BOOL ((BOOL))
      |INTEGER ((INTEGER))

varlist : IDENTIFIER ([IDENTIFIER])
        | IDENTIFIER COMMA varlist ((IDENTIFIER::varlist))

command_seq: LCURL command_seq RCURL ((command_seq))


command_seq: command DELIM command_seq ((command::command_seq))
            |                           ([])
    
command: IDENTIFIER ASSN expression ((Set(IDENTIFIER,expression)))
        | READ IDENTIFIER ((Read(IDENTIFIER)))
        | WRITE expression ((Write(expression)))
        |IF expression THEN command_seq ELSE command_seq ENDIF ((ite(expression,command_seq1,command_seq2)))
        |WHILE expression DO command_seq ENDWH ((while_exp
        (expression,command_seq)))


expression:
        expression LT expression ((LT(expression1,expression2)))
      | expression LEQ expression ((LEQ(expression1,expression2)))
      | expression EQ expression ((EQ(expression1,expression2)))
      | expression GT expression ((GT(expression1,expression2)))
      | expression GEQ expression ((GEQ(expression1,expression2)))
      | expression NEQ expression ((NEQ(expression1,expression2)))
      | expression AND expression ((AND(expression1,expression2)))
      | expression OR expression ((OR(expression1,expression2)))
      | expression PLUS expression ((PLUS(expression1,expression2)))
      | expression MINUS expression ((MINUS(expression1,expression2)))
      | expression TIMES expression ((TIMES(expression1,expression2)))
      | expression DIV expression ((DIV(expression1,expression2)))
      | expression MOD expression ((MOD(expression1,expression2)))

      | LPAREN expression RPAREN ((expression))

      | NEG expression ((NEG(expression)))
      | NOT expression ((NOT(expression)))
      | BTRUE ((BOOLEAN(true)))
      | BFALSE ((BOOLEAN(false)))
      | NUMBER ((NUM(NUMBER)))
      | IDENTIFIER ((VAR(IDENTIFIER)))
```

## Test Code
### While code
```
    program chad :: 

    var a,b,c : int ;var d,e,f : bool;
    {   
        b := 0;
        while  b <> 5 do { write b; b := b + 1;} endwh;
    }
```
### AST OutpuT
```
val it =
  Prog
    ("chad",[Dec (["a","b","c"],INTEGER),Dec (["d","e","f"],BOOL)],
     [Set ("b",NUM 0),
      while_exp
        (NEQ (VAR "b",NUM 5),[Write (VAR "b"),Set ("b",PLUS (VAR "b",NUM 1))])])
  : WhileParser.result
```



## Acknowledgements

While no code has been copied from any source as such, to learn about ml-yacc and ml-lex, I followed 2 pdfs, and a lot of my design choices have been influenced by their examples. The 2 pdfs were [Pdf from profs Website](http://rogerprice.org/ug/ug.pdf) and [This pdf on ml-yacc](http://cs.wellesley.edu/~cs235/fall08/lectures/35_YACC_revised.pdf). For the glue code that is whileinterface.sml and for loading sml in ```load-while.sml``` I took how to write the syntax from the second pdf. Nothing was blindly copy pasted though. To convert my ebnf to railroad, I used this [website](https://matthijsgroen.github.io/ebnf2railroad/)