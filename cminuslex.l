/* Definitions */
%{

#include <iostream>
#include <string>

using namespace std;

#define YY_DECL extern "C" int yylex()

#include "cminusparser.tab.h"
%}

/* Rules Section */
%%

"else" {printf("TELSE ");return TELSE;}
"if" {printf("TIF ");return TIF;}
"int" {printf("TINT ");return TINT;}
"return" {printf("TRETURN ");return TRETURN;}
"void" {printf("TVOID ");return TVOID;}
"while" {printf("TWHILE ");return TWHILE;}

[a-zA-Z][a-zA-Z]* {printf("ID ");return ID;}
[0-9][0-9]* {printf("NUM ");return NUM;}
[ /t/n] ;

"+" {printf("TPLUS "); return TPLUS;} //plus
"-" {printf("TMINUS ");return TMINUS;} //minus
"*" {printf("TMUL ");return TMUL;} // multiplication
"//" {printf("TDIV ");return TDIV;} // division
"<" {printf("TLT ");return TLT;} // less than
"<=" {printf("TLTE ");return TLTE;} // less than or equal
">" {printf("TGT ");return TGT;} // greater than
">=" {printf("TGTE ");return TGTE;} // greater than or equal
"==" {printf("TEQ ");return TEQ;} // equal
"!=" {printf("TEQ ");return TNEQ;} // not equal
"=" {printf("TASSIGN ");return TASSIGN;} // assignment
";" {printf("TCOL ");return TCOL;} // colon
"," {printf("TCOM ");return TCOM;} // comma
"(" {printf("TLP ");return TLP;} // left paranthesis
")" {printf("TRP ");return TRP;} // right paranthesis
"[" {printf("TLSB ");return TLSB;} // left square bracket
"]" {printf("TRSB ");return TRSB;} // right square bracket
"{" {printf("TLCB ");return TLCB;} // left curly bracket
"}" {printf("TRCB ");return TRCB;} //right curly bracket
"/*" {printf("TCS ");return TCS;} // comment start
"*/" {printf("TCE ");return TCE;} // comment end
"" {printf("TEMPTY ");return TEMPTY;} //empty string
. printf("Invalid TOKEN ");

%%



