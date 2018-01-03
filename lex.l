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
"+" {yylval.cal = 1;return CAL;}
"-" {yylval.cal = 2;return CAL;}
"*" {yylval.cal = 3;return CAL;}
"/" {yylval.cal = 4;return CAL;}
"=" {return EQUSY;}
"{" {return LPARSY;}
"}" {return RPARSY;}
"==" {yylval.cmp = 1;return CMP;}
">=" {yylval.cmp = 2;return CMP;}
"<=" {yylval.cmp = 3;return CMP;}
">" {yylval.cmp = 4;return CMP;}
"<" {yylval.cmp = 5;return CMP;}
";" {return SEMISY;}
"printf" {yylval.fn = strdup("printf"); return FUNC;}
"(" {return LSARSY;}
")" {return RSARSY;}
[-+]?[0-9]+ {yylval.d = atof(yytext);return NUMBER;}
[A-Za-z]+[0-9]* { yylval.c = strdup(yytext);return IDSY;}
[-+]?[0-9]+\.?[0-9]* {yylval.d = atof(yytext);return NUMBER;}
[A-Za-z]+[(][)] {yylval.fn = strdup(yytext);return FUNC;}
"#" {return EOL;}
"||" {return OR;}
%%



int yywrap(void){
	return 1;
}


