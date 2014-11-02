%{
#include <cstdio>
#include <iostream>

using namespace std;


extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

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
%token TCS // comment start
%token TCE // comment end
%token TEMPTY //empty string

%%

program:declaration-list
	;
declaration-list:declaration-list declaration 
	| declaration;
	;
declaration:var-declaration
	|fun-declaration;
	;
var-declaration:type-specifier ID TCOL
	|type-specifier ID TLSB NUM TLSB TCOL
	;
type-specifier: TINT
	|TVOID
	;
fun-declaration:type-specifier ID TLP params TRP compound-stmt
	;
params:param-list
	|TVOID
	;
param-list:param-list TCOM param
	|param
	;
param:type-specifier ID
	|type-specifier ID TLSB TRSB
	;
compound-stmt:TLCB local-declarations statement-list TRCB
	;
local-declarations:local-declarations var-declaration
	|TEMPTY
	;
statement-list:statement-list statement
	|TEMPTY
	;
statement:expression-stmt
	|compound-stmt
	|selection-stmt
	|iteration-stmt
	|return-stmt
	;
expression-stmt:expression TCOL
	|TCOL
	;
selection-stmt:TIF TLP expression TRP statement subselection-stmt
	;
subselection-stmt:TEMPTY
	|TELSE statement
	;
iteration-stmt:TWHILE TLP expression TRP statement
	;
return-stmt:TRETURN TCOL
	|TRETURN expression TCOL
	;
expression:var TASSIGN expression
	|simple-expression
	;
var:ID
	|ID TLSB expression TRSB
	;
simple-expression:additive-expression relop additive-expression
	|additive-expression
	;
relop:TLTE
	|TLT
	|TGT
	|TGTE
	|TEQ
	|TNEQ
	;
additive-expression:additive-expression addop term
	|term
	;
addop:TPLUS
	|TMINUS
	;
term:term mulop factor
	|factor
	;
mulop:TMUL
	|TDIV
	;
factor:TLP expression TRP
	|var
	|call
	|NUM
	;
call:ID TLP args TRP
	;
args:arg-list
	|TEMPTY
	;
arg-list:arg-list TCOM expression
	|expression
	;
%%

int readfile(){
	FILE *source = fopen("source.cm","r");
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
	
	//return yyparse();
}

int yyerror(const char *s){
	cout << "Error While Parsing! : " << s << endl;
	return -1; // for now, we stop at the first error
}
