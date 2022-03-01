open AST

%%

%name While

%pos int

%term
  NUMBER of int|IDENTIFIER of string
  |BTRUE|BFALSE
  |INTEGER|BOOL
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
    srt of Prog
  | decleration_seq of Dec list
  | decleration of Dec 
  | command_seq of Command list
  | command of Command
  | varlist of string list
  | var of string
  | expression of Exp
  | Type of dtypes

%left OR
%left AND
%right NOT
%left LT LEQ EQ GT GEQ NEQ 
%left PLUS MINUS
%left TIMES DIV MOD
%right NEG

%start srt

%keyword

%eop EOF

%noshift EOF

%nodefault

%verbose


%%


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