(* *)

%%

%name While

%pos int

%term
    NUMBER of int| BOOLVAL of bool |IDENTIFIER of string
  |INT|BOOL
  | PROGRAM| VAR
  | READ | WRITE
  |IF|THEN|ELSE|ENDIF|WHILE|DO|ENDWH
  | PLUS | MINUS | MUL | DIV | MOD
  |EQ|NEQ|LT|GT|LE|GE
  |NEGATE
  | LPAREN| RPAREN
  | ASSN|COLON|SCOPE|COMMA|DELIM
  |AND|OR|NOT
  |LCURL|RCURL
  |EOF

%nonterm
    Start of AST.exp
  | Exp of AST.exp
  | Term of AST.exp
  | Factor of AST.exp
  | Unit of AST.exp

%left ADD SUB
%left MUL DIV
%right EXPT
 
%start Start

%keyword

%eop EOF

%noshift EOF

%nodefault

%verbose

%value INT(0)

%%

START: Prog (Prog)

Prog: PROGRAM IDENTIFIER SCOPE BLOCK

/* BLOCK:  */



Exp: Term (Term)
  | Exp ADD Term (AST.BinApp(AST.Add, Exp, Term))
  | Exp SUB Term (AST.BinApp(AST.Sub, Exp, Term))

Term: Factor (Factor)
  | Term MUL Factor (AST.BinApp(AST.Mul, Term, Factor))
  | Term DIV Factor (AST.BinApp(AST.Div, Term, Factor))

Factor: Unit (Unit)
  | Unit EXPT Factor (AST.BinApp(AST.Expt, Unit, Factor))

Unit: INT (AST.Int(INT))
  | LPAREN Exp RPAREN (Exp)