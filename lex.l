%{
#include "main.h"
#include "bison.tab.h"
%}

%%

"if" {return IFSY;}
"else" {return ELSESY;}
"while" {return WHILESY;}
"double" {return DOUBLESY;}
"char" {return CHARSY;}
"int" {return INTSY;}
"+" {return PLUSSY;}
"-" {return SUBSY;}
"=" {return EQUSY;}
"*" {return MULSY;}
"/" {return DIVSY;}
"{" {return LPARSY;}
"}" {return RPARSY;}
"==" {yylval.cmp = 1;return CMP;}
">=" {yylval.cmp = 2;return CMP;}
"<=" {yylval.cmp = 3;return CMP;}
">" {yylval.cmp = 4;return CMP;}
"<" {yylval.cmp = 5;return CMP;}
";" {return SEMISY;}
"printf" {yylval.fn = 1; return FUNC;}
"(" {return LSARSY;}
")" {return RSARSY;}
[0-9]+ {yylval.d = atof(yytext);return NUMBER;}
[A-Za-z]+ { yylval.c = strdup(yytext);return IDSY;}



%%



int yywrap(void){
	return 1;
}


