all:
	ml-lex while.lex
	ml-yacc while.yacc
	sml load-while.sml