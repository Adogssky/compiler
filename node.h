#ifndef FUCK
#define FUCK
#include <iostream>
#include <vector>
using namespace std;
class ast;
class numval;
class charval;
class var;
class ufncall;
class fncall;
class flow;
class symref;
class symasgn;
class symbol;

class symbol{
	public:
		char* type;
		double int_value;
		char* name;
		void set_name(char* name){
			this->name = name;
		}
		void set_value(double int_value){
			this->int_value = int_value;
		}
		void set_type(char* type){
			this->type = type;
		}
};


enum inside_func{
	f_print = 1,
};

class ast{
	public:
		char type;
		ast *l;
		ast *r;
};

class numval{
	public:
		char type;
		double num_val;
	
};

class charval{
	public:
		char type;
		char char_val;
};

class var{
	public:
		char type;
		char* var_name;
};

class fncall{
	public:
		char type;
		ast *l;
		enum inside_func functype;
};		

class ufncall{
	public:
		char type;
		ast *l;
		symbol *s;		
};

class flow{
	public:
		char type;
		ast *cond;
		ast *tl;
		ast *el;
};

class symref{
	public:
		char type;
		symbol *s;
};

class symasgn{
	public:
		char type;
		symbol *s;
		ast *v;
};


ast *newast(char type, ast *l, ast *r);
ast *newnum(double num_val);
ast *newchar(char char_val);
ast *newvar(char* var_name);
ast *newfunc(ast *l);
ast *newcall(symbol *s, ast *l);
ast *newref(symbol *s);
ast *newasgn(symbol *s, ast *v);
ast *newflow(char type, ast *cond, ast *tl, ast *el);
ast *newcmp(char type, ast *l, ast *r);

double calNum(ast *);
void treefree(ast *a);

#endif
