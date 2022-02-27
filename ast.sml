structure AST =
struct

datatype program = PROG

datatype type = INT|BOOL

datatype Boolop = TT|FF|NOT|AND|OR

datatype Relop = LT|LEQ|EQ|GT|GEQ|NEQ
datatype Intop = PLUS|MINUS|TIMES|DIV|MOD
datatype commands = SET|SEQ|ITE|WH