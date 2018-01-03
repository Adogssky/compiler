test: lex.l bison.y bison.tab.c lex.yy.c
	bison -d bison.y
	flex  lex.l
	g++ -o output bison.tab.c lex.yy.c node.cpp -ly -lfl
