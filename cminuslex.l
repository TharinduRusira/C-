/* Definitions */
%{

#include <iostream>
#include <cstdio>
#include <string>
#include <fstream>
using namespace std;

#define YY_DECL extern "C" int yylex()

#include "cminusparser.tab.h"
%}

letter [a-zA-Z]
digit [0-9]
ID [letter][letter]* 
NUM [digit][digit]*


/* Rules Section */
%%
[\t\n] ;

"else" return TELSE;
"if" return TIF;
"int" return TINT;
"return" return TRETURN;
"void" return TVOID;
"while" return TWHILE;

"+" return TPLUS; //plus
"-" return TMINUS; //minus
"*" return TMUL; // multiplication
"/" return TDIV; // division
"<" return TLT; // less than
"<=" return TLTE; // less than or equal
">" return TGT; // greater than
">=" return TGTE; // greater than or equal
"==" return TEQ; // equal
"!=" return TNEQ; // not equal
"=" return TASSIGN; // assignment
";" return TCOL; // colon
"," return TCOM; // comma
"(" return TLP; // left paranthesis
")" return TRP; // right paranthesis
"[" return TLSB; // left square bracket
"]" return TRSB; // right square bracket
"{" return TLCB; // left curly bracket
"}" return TRCB; //right curly bracket
"/*" return TCS; // comment start
"*/" return TCE; // comment end
"" return TEMPTY; //empty string
. printf("Unknown Token!");

%%



