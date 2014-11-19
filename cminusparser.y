%{
#include <cstdio>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;


extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int linenum;

int yyerror(const char *s);
%}

%union {
	int ival;
	char* sval;
}

%start program

%token <ival> NUM
%token <sval> ID

%token TELSE
%token TIF
%token TINT
%token TRETURN
%token TVOID
%token TWHILE

%token TPLUS //plus
%token TMINUS //minus
%token TMUL // multiplication
%token TDIV // division
%token TLT // less than
%token TLTE // less than or equal
%token TGT // greater than
%token TGTE // greater than or equal
%token TEQ // equal
%token TNEQ // not equal
%token TASSIGN // assignment
%token TCOL // colon
%token TCOM // comma
%token TLP // left paranthesis
%token TRP // right paranthesis
%token TLSB // left square bracket
%token TRSB // right square bracket
%token TLCB // left curly bracket
%token TRCB //right curly bracket

%%

program:declaration-list {cout << "1"<<endl;}
	;
declaration-list:declaration-list declaration {cout << "2-1"<<endl;}
	|declaration {cout << "2-2"<<endl;}
	;
declaration:var-declaration {cout << "3-1"<<endl;}
	|fun-declaration {cout << "3-2"<<endl;}
	;
type-specifier: TINT {cout << "5-1"<<endl;}
	|TVOID {cout << "5-2"<<endl;}
	;
var-declaration:type-specifier ID TCOL {cout << "4-1"<<endl;}
	|type-specifier ID TLSB NUM TRSB TCOL {cout << "4-2"<<endl;}
	;
fun-declaration:type-specifier ID TLP params TRP compound-stmt {cout << "6"<<endl;}
	;
params:param-list {cout << "7-1"<<endl;}
	|TVOID {cout << "7-2"<<endl;}
	;
param-list:param-list TCOM param {cout << "8-1"<<endl;}
	|param {cout << "8-2"<<endl;}
	;
param:type-specifier ID {cout << "9-1"<<endl;}
	|type-specifier ID TLSB TRSB {cout << "9-2"<<endl;}
	;
compound-stmt:TLCB local-declarations statement-list TRCB {cout << "10"<<endl;}
	;
local-declarations:local-declarations var-declaration {cout << "11-1"<<endl;}
	|EMPTY {cout << "11-2"<<endl;}
	;
statement-list:statement-list statement {cout << "12-1"<<endl;}
	|EMPTY {cout << "12-2"<<endl;}
	;
statement:expression-stmt {cout << "13-1"<<endl;}
	|compound-stmt {cout << "13-2"<<endl;}
	|selection-stmt {cout << "13-3"<<endl;}
	|iteration-stmt {cout << "13-4"<<endl;}
	|return-stmt {cout << "13-5"<<endl;}
	;
expression-stmt:expression TCOL {cout << "14-1"<<endl;}
	|TCOL {cout << "14-2"<<endl;}
	;
selection-stmt:TIF TLP expression TRP statement subselection-stmt {cout << "15"<<endl;}
	;
subselection-stmt:TELSE statement {cout << "16-1"<<endl;}
	|EMPTY {cout << "16-2"<<endl;}
	;
iteration-stmt:TWHILE TLP expression TRP statement {cout << "17-1"<<endl;}
	;
return-stmt:TRETURN TCOL {cout << "18-1"<<endl;}
	|TRETURN expression TCOL {cout << "18-2"<<endl;}
	;
expression:var TASSIGN expression {cout << "19-1"<<endl;}
	|simple-expression {cout << "19-2"<<endl;}
	;
var:ID {cout << "20-1"<<endl;}
	|ID TLSB expression TRSB {cout << "20-2"<<endl;}
	;
simple-expression:additive-expression relop additive-expression {cout << "21-1"<<endl;}
	|additive-expression {cout << "21-2"<<endl;}
	;
relop:TLTE {cout << "22-1"<<endl;}
	|TLT {cout << "22-2"<<endl;}
	|TGT {cout << "22-3"<<endl;}
	|TGTE {cout << "22-4"<<endl;}
	|TEQ {cout << "22-5"<<endl;}
	|TNEQ {cout << "22-6"<<endl;}
	;
additive-expression:additive-expression addop term {cout << "23-1"<<endl;}
	|term {cout << "23-2"<<endl;}
	;
addop:TPLUS {cout << "24-1"<<endl;}
	|TMINUS {cout << "24-2"<<endl;}
	;
term:term mulop factor {cout << "25-1"<<endl;}
	|factor {cout << "25-2"<<endl;}
	;
mulop:TMUL {cout << "26-1"<<endl;}
	|TDIV {cout << "26-2"<<endl;}
	;
factor:TLP expression TRP {cout << "27-1"<<endl;}
	|var {cout << "27-2"<<endl;}
	|call {cout << "27-3"<<endl;}
	|NUM {cout << "27-4"<<endl;}
	;
call:ID TLP args TRP {cout << "28"<<endl;}
	;
args:arg-list {cout << "29-1"<<endl;}
	|EMPTY {cout << "29-2"<<endl;}
	;
arg-list:arg-list TCOM expression {cout << "30-1"<<endl;}
	|expression {cout << "30-2"<<endl;}
	;

EMPTY: {;}
%%

int readfile(){
	string filename;
	ifstream infile;
	infile.open("input.config");
	getline(infile,filename);
	FILE *source = fopen(filename.c_str(),"r");
	if(source){
		yyin = source;
		return 0;
	}else{
		cout << "Cannot Read source.cm\n" << endl;
		return -1;
	}
}

int main(){
	readfile();
	do{
		yyparse();
	}while(!feof(yyin));
	return 0;
}

int yyerror(const char *s){
	cout << "Parse ERROR! : " << s << " at Line: "<<linenum<< endl;
	return -1; // for now, we stop at the first error
}
