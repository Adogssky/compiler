%{
#include "main.h"
#include "node.h"
%}

%union{ 
	double d;
	char* c;
	class ast *a;
	class symbol *s;
	int cmp;
	char* fn;
	int cal;
}
%token <fn> FUNC;
%token <cal> CAL; 
%token EQUSY; 
%token LPARSY; 
%token RPARSY; 
%token <d> NUMBER; 
%token CHARSY;
%token INTSY;
%token <c> IDSY;
%token SEMISY;
%token LSARSY;
%token RSARSY;
%token PRINTSY;
%token DOUBLESY;
%token LARGER;
%token SMALLER;
%token IFSY ELSESY WHILESY
%nonassoc <cmp> CMP;
%token EOL;
%token OR;

%%
codelist: {}
	| codelist stmtl EOL {}
	;
stmtl: {}
	|stmt SEMISY stmtl{}
	; 

stmt: IFSY LSARSY exp RSARSY stmtl {}
	| IFSY LSARSY exp RSARSY stmtl ELSESY stmt {}
	| WHILESY LSARSY exp RSARSY stmtl{}
	| exp {}
	;

exp: exp CMP exp {}
	| exp CAL exp {}
	| LSARSY exp RSARSY {}
	| OR exp {} 
	| NUMBER {}
	| FUNC LSARSY explist RSARSY {}
	|

explist: exp {}
	| exp SEMISY exp {}
	;
%%

int main(){
	FILE* fp = fopen("test.txt","r");
	if(fp==NULL)
	{
		cout<<"nothing in the file,sucker"<<endl;
		return -1;
	}
	extern FILE* yyin;
	yyin = fp;
	yyparse();
	fclose(fp);
	return 0;
}

int yyerror(char *s)
{
	cout<<s<<endl;
	return 0;
}
