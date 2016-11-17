%{

#include <stdio.h>

//#define YYSTYPE char*

extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);

%}

%union {
	char* string;
}

%defines
%token HLT
%type <string> HLT

%%

program: commands
	   ;

commands: 
		| commands command
		;

command: HLT
			{
				puts($1);
			}
	   ;

%%

int main(int argc, char *argv[])
{
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));
}

void yyerror(const char* s)
{
	extern int yylineno;

	fprintf(stderr, "**ERROR** at line %d: %s\n", yylineno, s);
}

