structure AST =
struct
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
end