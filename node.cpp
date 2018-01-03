#include <iostream>
#include <stdio.h>
#include "node.h"
using namespace std;

vector<symbol> symbol_list;
void set_symbolList(char* name,char* type){
	vector<symbol>::iterator v;
	for(v = symbol_list.begin();v!=symbol_list.end();v++){
		if(name == (*v).name && type == (*v).type){
			cout<<name<<"already excist"<<endl;
		}else{
			symbol tmp;
			tmp.set_name(name);
			tmp.set_type(type);
			symbol_list.push_back(tmp);
		}
	}
}

ast *newast(char type, ast *l, ast *r){
	ast *a = new ast();
	a->type = type;
	a->l = l;
	a->r = r;
	return a;
}

ast *newnum(char type, double num_val){
	numval *a = new numval();
	a->type = 'n';
	a->num_val = num_val;
	return (ast *)a;

}

ast *newchar(char type, char char_val ){
	charval *a = new charval();
	a->type = 'c';
	a->char_val = char_val;
	return (ast *)a;
}

ast *newvar(char type, char* var_name){
	var *a = new var();
	a->type = 'v';
	a->var_name = var_name;
	return (ast *)a;
}

ast *newfunc(char type , ast *l){
	fncall *a = new fncall();
	a->type = 'f';
	a->l = l;
	a->functype;
	return (ast *)a;
}

ast *newcall(symbol *s, ast *l){
	ufncall *a = new ufncall();
	a->type = 'C';
	a->l = l;
	a->s = s;
	return (ast *)a;
}

ast *newref(symbol *s){
	symref *a = new symref();
	a->type = 'r';
	a->s = s;	
	return (ast *)a;
}	

ast *newasgn(symbol *s, ast *v){
	symasgn *a = new symasgn();
	a->type = 'e';
	a->s = s;
	a->v = v;
	return (ast *)a;
}

ast *newflow(char type, ast *cond, ast *tl, ast *el){
	flow *a = new flow();
	a->type = type;
	a->cond = cond;
	a->tl = tl;
	a->el = el;
	return (ast *)a;
}

ast *newcmp(char type, ast *l, ast *r){
	ast *a = new ast();
	a->type = type;
	a->l = l;
	a->r = r;
	return a;
}

void treefree(ast *a){
	switch(a->type){
		case '+':
		case '-':
		case '*':
		case '/':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
			treefree(a->r);
		case 'f':
		case 'C':
			treefree(a->l);
		case 'n':
		case 'c':
		case 'v':
		case 'r':
			break;
		case 'e':
			delete ((symasgn *)a)->v; break;
		case 'I':
		case 'W':
			delete ((flow *)a)->cond;
			if(((flow *)a)->tl) delete(((flow *)a)->tl);
			if(((flow *)a)->el) delete(((flow *)a)->el);
			break;
		default:
			cout<<"internal error: free bad node"<<a->type<<endl;
	}
	delete a;
}	

