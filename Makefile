all:
	ml-lex while.lex
	ml-yacc while.yacc
	sml load-while.sml
	parseFile "test";

clean:
	rm -rf while.yacc.sml
	rm -rf while.yacc.desc
	rm -rf while.yacc.sig
	rm -rf while.lex.sml
