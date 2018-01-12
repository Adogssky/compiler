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

%type <a> exp stmt stmtl explist
%type <s> symlist

%start codelist
%%

stmt: IFSY LSARSY exp RSARSY stmtl {$$ = newflow('I',$3,$5,NULL);}
	| IFSY LSARSY exp RSARSY stmtl ELSESY stmt {$$ = newflow('I',$3,$5,$7);}
	| WHILESY LSARSY exp RSARSY stmtl{$$ = newflow('W',$3,$5,NULL);}
	| exp 
	;

stmtl:	/* EMPTY */ {$$ = NULL;}
	|stmt SEMISY stmtl{if($3 == NULL)
				$$ = $1;
			   else
				$$ = newast('l',$1,$3);	}
	; 

exp: exp CMP exp { $$ = newcmp($2,$1,$3);}
	| exp CAL exp {
switch($2){
	case 1: $$ = newast('+',$1,$3); break;
	case 2: $$ = newast('-',$1,$3); break;
	case 3: $$ = newast('*',$1,$3); break;
	case 4: $$ = newast('/',$1,$3); break;
	}
}
	| LSARSY exp RSARSY {$$ = $2;}
	| OR exp {$$ = newast('|',$2,NULL);} 
	| NUMBER {$$ = newnum($1);}
	| FUNC LSARSY explist RSARSY {$$ = newfunc($3);}
	;

explist: exp {}
	| exp SEMISY exp {$$ = newast('L',$1,$3);}
	;

codelist:	 {}
	| codelist stmtl EOL {treefree($2);}
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
