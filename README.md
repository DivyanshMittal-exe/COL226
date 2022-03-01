# COL 226: Programming Languages

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