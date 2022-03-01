all:
	ml-lex while.lex
	ml-yacc while.yacc
	sml load-while.sml
	parseFile "test";

clean:
	-rm -f while.yacc.sml
	-rm -f while.yacc.desc
	-rm -f while.yacc.sig
	-rm -f while.lex.sml
