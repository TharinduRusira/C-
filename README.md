M.P. Tharindu Rusira Kumara 100277E
Department of Computer Science and Engineering, 
University of Moratuwa.

This folder contains lex/yacc based parser to parse C- language specification. 

Two important files are 
	1. cminuslex.l
	2. cminusparser.y

Run following commands in bash to generate necessary source files. 
	1. flex cminuslex.l
	2. bison -d -v cminusparser.y - lfl -o parser

Specify the name of the source file to be read, in input.config file.

Now the executable "parser" file should be generated. Run it.
	./parser
