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

fun print_Program (Prog(id,block):Prog) = (print(id);print_block(block))

fun print_block(block(DecList,CommandSeq):Block) = (print_DecList(DecList);print_CommandSeq(CommandSeq)) 


fun print_DecList(declist:DecList) = 
    case declist of 
        [] => print("\n")
        |Dec(varlist,type)::DecListLeft => (print_varlist(varlist);print_type(type);print_DecList(DecListLeft))

fun print_type(type:Types) = 
    case type of
        INT => print("Int")
        |BOOL => print("Bool")

fun print_varlist(varlist:VarList) = 
    case varlist of 
        [] => print(" : ")
        |Var(id)::varlistLeft => (print(id);print_varlist(varlistLeft))

        
fun print_CommandSeq(command_seq:CommandSeq ) = 
    case command_seq of 
            [] => print("\n")
            |comm::comlistLeft => (print_command(comm);print_CommandSeq(comlistLeft))

fun print_command(com:Command) = 
    case com of
        Command(Set(Var(id),Exp)) => (print(id);print_exp(Exp))
        |Command(Read(Var(id))) => print("Read: "^id)
        |Command(Write(Exp)) => (print("Write: ");print_exp(Exp))
        |ite(exp,comms1,comms2) => (print_exp(exp);print_CommandSeq(comms1);print_CommandSeq(comms2))
        |while(exp,comms) => (print_exp(exp);print_CommandSeq(comms))

fun print_exp(exp) = 
    case exp of 
        LT(exp1,exp2) => (print_exp(exp1);print(" < ");print(exp2))
        |LEQ(exp1,exp2) => (print_exp(exp1);print(" <= ");print(exp2))
        |EQ(exp1,exp2) => (print_exp(exp1);print(" = ");print(exp2))
        |GT(exp1,exp2) => (print_exp(exp1);print(" > ");print(exp2))
        |GEQ(exp1,exp2) => (print_exp(exp1);print(" >= ");print(exp2))
        |NEQ(exp1,exp2) => (print_exp(exp1);print(" <> ");print(exp2))
        |NOT(exp) => (print("!");print(exp))
        |AND(exp1,exp2) => (print_exp(exp1);print("&&");print(exp2))
        |OR(exp1,exp2) => (print_exp(exp1);print("||");print(exp2))
        |PLUS(exp1,exp2) => (print_exp(exp1);print("+");print(exp2))
        |MINUS(exp1,exp2) => (print_exp(exp1);print("_");print(exp2))
        |TIMES(exp1,exp2) => (print_exp(exp1);print("*");print(exp2))
        |DIV(exp1,exp2) => (print_exp(exp1);print("/");print(exp2))
        |MOD(exp1,exp2) => (print_exp(exp1);print("%");print(exp2))
        |NEG(exp) => (print("~");print(exp))
        |NUM(integer) => print(Int.toString(integer))
        |BOOL (boolean) => print(Bool.toString(boolean))

end;