%{
#include "node.h"
#include "main.h"
vector<int> int_stack;
vector<char*> id_stack;
%}

%union{ 
	double d;
	char* c;
	ast *a;
	symbol *s;
	int cmp;
	int fn;
}
%token <fn> FUNC;
%token PLUSSY; 
%token SUBSY; 
%token EQUSY; 
%token MULSY; 
%token DIVSY; 
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

init: INTSY IDSY EQUSY NUMBER SEMISY { int_stack.push_back($4); id_stack.push_back($2); }
	|	CHARSY IDSY SEMISY {}
	;

calculate: PRINTSY LSARSY IDSY PLUSSY IDSY RSARSY SEMISY 
{int i=0;
int j=0;
double n;
vector<char*>::iterator v;
vector<char*>::iterator m;
for(v = id_stack.begin(); v != id_stack.end(); v++){
	if(*(*v) ==*($3)) break;
	i++;
}
for(m = id_stack.begin(); m != id_stack.end(); m++){
	if(*(*m) == *($5)) break;
	j++;
}
n = int_stack[i] + int_stack[j];
 cout<<n<<endl;
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
