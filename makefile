test: lex.l bison.y bison.tab.c lex.yy.c
	bison -d bison.y
	flex lex.l
	g++ -o output node.cpp lex.yy.c bison.tab.c -ly -lfl
