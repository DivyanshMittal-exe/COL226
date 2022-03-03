structure AST =
struct
datatype PROG = PROG of string*(DEC list)*(CMD list)
and      DEC = DEC of (string list)*dtypes
and      dtypes = INT|BOOL
and      CMD = SET of string*Exp
                  |READ of string
                  |WRITE of Exp
                  |ITE of Exp*(CMD list)*(CMD list)
                  |WH of Exp*(CMD list)
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
end