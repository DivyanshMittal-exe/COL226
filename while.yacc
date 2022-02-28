open AST

%%

%name While

%pos int

%term
  NUMBER of int|IDENTIFIER of string
  |BTRUE|BFALSE
  |INT|BOOL
  |PROGRAM| VAR
  |READ | WRITE
  |IF|THEN|ELSE|ENDIF|WHILE|DO|ENDWH
  |PLUS | MINUS | MUL | DIV | MOD
  |EQ|NEQ|LT|GT|LE|GE
  |NEGATE
  |LPAREN| RPAREN
  |ASSN|COLON|SCOPE|COMMA|DELIM
  |AND|OR|NOT
  |LCURL|RCURL
  |EOF

%nonterm
    START of Prog
  | block of Block
  | decleration_seq of DecList
  | decleration of Dec 
  | command_seq of CommandSeq
  | command of Command
  | expression of Exp

%left PLUS MINUS
%left TIMES DIV MOD
%right NEG
%left OR
%left AND
%right NOT
%left LT LEQ EQ GT GEQ NEQ 


%start START

%keyword

%eop EOF

%noshift EOF

%nodefault

%verbose

%value INT(0)

%%


START: PROGRAM IDENTIFIER SCOPE block ((Prog(IDENTIFIER,block)))

block: decleration_seq command_seq ((Block(decleration_seq,command_seq)))

decleration_seq: decleration decleration_seq ((decleration::decleration_seq))
      |                      ([])

decleration: VAR VarList COLON Type DELIM ((Dec(VarList,Type)))


VarList : IDENTIFIER ([IDENTIFIER])
        | IDENTIFIER COMMA VarList ((IDENTIFIER::VarList))

command_seq: LCURL command_seq RCURL ((CommandSeq(command_seq)))


command_seq: command DELIM command_seq ((command::command_seq))
            |                           ([])
    
command: IDENTIFIER ASSN expression ((Set(IDENTIFIER,expression)))
        | READ IDENTIFIER ((Read(IDENTIFIER)))
        | WRITE expression ((Write(expression)))
        |IF expression THEN command_seq ELSE command_seq ENDIF ((ite(expression,CommandSeq1,CommandSeq2)))
        |WHILE expression DO command_seq ENDWH ((while_exp
        (expression,command_seq)))


expression:
        expression LT expression ((LT(expression1,expression2)))
      | expression LEQ expression ((LEQ(expression1,expression2)))
      | expression EQ expression ((EQ(expression1,expression2)))
      | expression GT expression ((GT(expression1,expression2)))
      | expression GEQ expression ((GEQ(expression1,expression2)))
      | expression NEQ expression ((NEW(expression1,expression2)))
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
      | IDENTIFIER ((Var(IDENTIFIER)))