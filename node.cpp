#include <iostream>
#include <stdio.h>
#include "node.h"
using namespace std;
map<string,int> hashlist;
vector<symbol*> symbol_list;
vector<string> idlist;

/*void set_symbolList(char* name,char* type){
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
*/
symbol* lookup(char* sym){
	string tmp = sym;
	if(hashlist.find(tmp) == hashlist.end()){
		cout<<tmp<<"can not be found"<<"create new record"<<endl;
		symbol *newSym = new symbol();
		newSym->set_name(sym);
		symbol_list.push_back(newSym);
		int index = symbol_list.size();
		hashlist[tmp] = index - 1;
		return newSym;
	}else{
		cout<<tmp<<"is already excist"<<endl;
		cout<<tmp<<"index is"<<hashlist[tmp]<<endl;
		return symbol_list[hashlist[tmp]]; 
	}

}

bool id_excist(char* name){
	for(auto v : idlist){
		if(v == name)
			return true;	
	}
	return false;
}

void addidlist(char* name){
	idlist.push_back(name);
	return;
}

ast *newast(char type, ast *l, ast *r){
	ast *a = new ast();
	a->type = type;
	a->l = l;
	a->r = r;
	return a;
}

ast *newnum(double num_val){
	numval *a = new numval();
	a->type = 'n';
	a->num_val = num_val;
	return (ast *)a;

}

ast *newchar(char char_val ){
	charval *a = new charval();
	a->type = 'c';
	a->char_val = char_val;
	return (ast *)a;
}

ast *newvar(char* var_name){
	var *a = new var();
	a->type = 'v';
	a->var_name = var_name;
	return (ast *)a;
}

ast *newfunc(ast *l){
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

