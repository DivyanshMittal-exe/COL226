structure AST : DATATYPES =
struct

type id = string

datatype Prog = Prog of id*Block
and      Block = Block of DecList*CommandSeq
and      DecList = DecList of Dec list
and      Dec = Dec of VarList*Types
and      Types = INT|BOOL
and      VarList = VarList of Var list
and      Var = Var of id
and      CommandSeq = CommandSeq of Command list
and      Command = Set of Var*Exp
                  |Read of Var
                  |Write of Exp
                  |ite of Exp*CommandSeq*CommandSeq
                  |while of Exp*CommandSeq
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
                BOOL of bool
end;