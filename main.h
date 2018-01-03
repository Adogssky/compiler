#include <vector>
#include <iostream>
#include <string>
#include <stdio.h>
using namespace std;
extern "C"
{
	int yywrap(void);
	int yylex(void);
	void yyerror(const char *s);
	extern int yylex(void);
}

