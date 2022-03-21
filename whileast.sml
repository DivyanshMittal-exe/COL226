(* All original code by Divyansh Mittal, 2020CS10342 *)

CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm"); 
use "ast.sml"; 
use "while.yacc.sig"; 
use "while.yacc.sml"; 
use "while.lex.sml";
use "typechecking.sml";
use "evaluator.sml";
use "whileinterface.sml";
use "FunStack.sml";
use "vmc.sml";
Control.Print.printLength := 100; 
Control.Print.printDepth := 100; 
Control.Print.stringDepth := 100;
open While;