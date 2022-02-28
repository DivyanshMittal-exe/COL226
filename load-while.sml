CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm"); 
use "ast.sml"; 
use "while.yacc.sig"; 
use "while.yacc.sml"; 
use "while.lex.sml";
use "whileinterface.sml";
Control.Print.printLength := 1000; (* set printing parameters so that *)
Control.Print.printDepth := 1000; (* we’ll see all details of parse trees *)
Control.Print.stringDepth := 1000; (* and strings *)
open While;
