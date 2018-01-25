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
%token <s> IDSY;
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

%nonassoc '|' UMINUS

%type <a> exp stmt stmtl explist

%start codelist
%%

stmt: IFSY LSARSY exp RSARSY LPARSY stmtl RPARSY {$$ = newflow('I',$3,$6,NULL);}
	| IFSY LSARSY exp RSARSY LPARSY stmtl RPARSY ELSESY stmtl {$$ = newflow('I',$3,$6,$9);}
	| WHILESY LSARSY exp RSARSY LPARSY stmtl RPARSY{$$ = newflow('W',$3,$6,NULL);}
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
	| '-' exp %prec UMINUS {$$ = newast('M',$2,NULL);}
	| OR exp {$$ = newast('|',$2,NULL);} 
	| NUMBER {$$ = newnum($1);}
	| IDSY {if(id_excist($1->name)){
			$$ = newref($1);} 
		else{
			yyerror("no id");
			} }
	| INTSY IDSY EQUSY exp {addidlist($2->name);$$ = newasgn($2,$4);}
	| DOUBLESY IDSY EQUSY exp {addidlist($2->name); $$ = newasgn($2,$4);}
	| IDSY EQUSY exp { if(id_excist($1->name)) $$ = newasgn($1,$3);
			else yyerror("no id");}
	;

explist: exp 
	| exp SEMISY explist {$$ = newast('L',$1,$3);}
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
