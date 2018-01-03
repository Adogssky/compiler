%{
#include "main.h"
#include "node.h"
vector<double> int_stack;
vector<char*> id_stack;
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

%%
statement: FUNC LPARSY body RPARSY {}
	;

body: init {}
	|	body init {}
	|	body calculate {}
	;

init: INTSY IDSY EQUSY NUMBER SEMISY { }
	|	CHARSY IDSY SEMISY {}
	;

calculate: FUNC LSARSY IDSY CAL IDSY RSARSY SEMISY 
{
}
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
