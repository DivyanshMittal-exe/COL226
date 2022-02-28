structure AST =
struct

type id = string

datatype Prog = Prog of id*Block
and      Block = Block of (Dec list)*(Command list)
and      Dec = Dec of (Var list)*dtypes
and      dtypes = INTEGER|BOOL
and      Var = Var of id
and      Command = Set of Var*Exp
                  |Read of Var
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
                Exp of Var

fun print_Program (Prog(id,block):Prog) = (print(id);print_block(block))

and print_block(Block(declist,commseq):Block) = (print_DecList(declist);print_CommandSeq(commseq)) 


and print_DecList(declist) = 
    case declist of 
        [] => print("\n")
        |(Dec(varlist,dtype)):: declistleft => (print_varlist(varlist);print_type(dtype);print_DecList(declistleft))

and print_type(dtype:dtypes) = 
    case dtype of
        INTEGER => print("Int")
        |BOOL => print("Bool")

and print_varlist(varlist:Var list) = 
    case varlist of 
        [] => print(" : ")
        |Var(id)::varlistLeft => (print(id);print_varlist(varlistLeft))

        
and print_CommandSeq(command_seq:(Command list) ) = 
    case command_seq of 
            [] => print("\n")
            |comm::comlistLeft => (print_command(comm);print_CommandSeq(comlistLeft))

and print_command(com:Command) = 
    case com of
        (Set(Var(id),exp)) => (print(id);print_exp(exp))
        |(Read(Var(id))) => print("Read: "^id)
        |(Write(exp)) => (print("Write: ");print_exp(exp))
        |ite(exp,comms1,comms2) => (print_exp(exp);print_CommandSeq(comms1);print_CommandSeq(comms2))
        |while_exp(exp,comms) => (print_exp(exp);print_CommandSeq(comms))

and print_exp(exp) = 
    case exp of 
        LT(exp1,exp2) => (print_exp(exp1);print(" < ");print_exp(exp2))
        |LEQ(exp1,exp2) => (print_exp(exp1);print(" <= ");print_exp(exp2))
        |EQ(exp1,exp2) => (print_exp(exp1);print(" = ");print_exp(exp2))
        |GT(exp1,exp2) => (print_exp(exp1);print(" > ");print_exp(exp2))
        |GEQ(exp1,exp2) => (print_exp(exp1);print(" >= ");print_exp(exp2))
        |NEQ(exp1,exp2) => (print_exp(exp1);print(" <> ");print_exp(exp2))
        |NOT(exp) => (print("!");print_exp(exp))
        |AND(exp1,exp2) => (print_exp(exp1);print("&&");print_exp(exp2))
        |OR(exp1,exp2) => (print_exp(exp1);print("||");print_exp(exp2))
        |PLUS(exp1,exp2) => (print_exp(exp1);print("+");print_exp(exp2))
        |MINUS(exp1,exp2) => (print_exp(exp1);print("-");print_exp(exp2))
        |TIMES(exp1,exp2) => (print_exp(exp1);print("*");print_exp(exp2))
        |DIV(exp1,exp2) => (print_exp(exp1);print("/");print_exp(exp2))
        |MOD(exp1,exp2) => (print_exp(exp1);print("%");print_exp(exp2))
        |NEG(exp) => (print("~");print_exp(exp))
        |NUM(integer) => print(Int.toString(integer))
        |BOOLEAN (boolean) => print(Bool.toString(boolean))

end