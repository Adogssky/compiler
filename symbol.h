#include <iostream>
#include <vector>
#include <string>
#include "node.h"
using namespace std;



class symbol{
	public:
		char* type;
		double int_value;
		char* name;
		ast *func;
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

symbol *lookup(char*);
vector<symbol> symbol_list;

void symlistfree(vector<symbol> symbol_list);

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
