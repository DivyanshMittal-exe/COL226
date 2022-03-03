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
  |PLUS | MINUS | TIMES | DIV | MOD
  |EQ|NEQ|LT|GT|LEQ|GEQ
  |NEG
  |LPAREN| RPAREN
  |ASSN|COLON|SCOPE|COMMA|DELIM
  |AND|OR|NOT
  |LCURL|RCURL
  |EOF

%nonterm
    srt of PROG
  | decleration_seq of DEC list
  | decleration of DEC 
  | command_seq of CMD list
  | command of CMD
  | varlist of string list
  | var of string
  | expression of Exp
  | Type of dtypes

%left OR
%left AND
%left LT LEQ EQ GT GEQ NEQ 
%left PLUS MINUS
%left TIMES DIV MOD
%right NEG NOT
%left LPAREN RPAREN

%start srt

%eop EOF

%noshift EOF

%nodefault


%%


srt: PROGRAM IDENTIFIER SCOPE decleration_seq command_seq ((PROG(IDENTIFIER,decleration_seq,command_seq)))

decleration_seq: decleration decleration_seq ((decleration::decleration_seq))
      |                      ([])

decleration: VAR varlist COLON Type DELIM ((DEC(varlist,Type)))

Type: BOOL ((BOOL))
      |INT ((INT))

varlist : IDENTIFIER ([IDENTIFIER])
        | IDENTIFIER COMMA varlist ((IDENTIFIER::varlist))

command_seq: LCURL command_seq RCURL ((command_seq))


command_seq: command DELIM command_seq ((command::command_seq))
            |                           ([])
    
command: IDENTIFIER ASSN expression ((SET(IDENTIFIER,expression)))
        | READ IDENTIFIER ((READ(IDENTIFIER)))
        | WRITE expression ((WRITE(expression)))
        |IF expression THEN command_seq ELSE command_seq ENDIF ((ITE(expression,command_seq1,command_seq2)))
        |WHILE expression DO command_seq ENDWH ((WH(expression,command_seq)))


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