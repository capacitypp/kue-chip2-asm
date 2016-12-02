%{

#include <stdio.h>
#include <string.h>

#define MAX_MACRO_NUM	256
#define STRING_LENGTH	256

extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
void register_macro(char* label_name, char* label_value);
int srch_macro(char* label_name);
void resolve_macro(char* string);

char label_names[MAX_MACRO_NUM][STRING_LENGTH];
char label_values[MAX_MACRO_NUM][STRING_LENGTH];
int label_idx = 0;

%}

%union {
	char label_name[256];
	char hex[256];
	char decimal[256];
	char number[256];
	char string[256];
	char opcode[256];
	char operand[256];
	char command[256];
}

%defines
%token LABEL
%token COLON
%token EQU
%token HEX DECIMAL
%token OPCODE
%token COMMA
%token PARENTHESIS_BEGIN PARENTHESIS_END
%token BRACKET_BEGIN BRACKET_END
%token PLUS
%token STRING
%token END
%type <label_name> LABEL
%type <hex> HEX
%type <decimal> DECIMAL
%type <number> number
%type <opcode> OPCODE
%type <operand> operand
%type <string> STRING
%type <command> command

%%

program: macros commands END
	   {
		puts("\tEND");
	   }
	   ;

macros: 
	  | macros macro
	  ;

macro: LABEL COLON EQU number
	 {
		register_macro($1, $4);
	 }
	 ;

number: HEX
	  {
		strcpy($$, $1);
	  }
	  | DECIMAL
	  {
		strcpy($$, $1);
	  }
	  ;

commands:
		| commands command
		{
			printf("%s\n", $2);
		}
		| commands LABEL COLON command
		{
			printf("%s:%s\n", $2, $4);
		}
		;

command: OPCODE
	   {
		sprintf($$, "\t%s", $1);
	   }
	   | OPCODE operand
	   {
		sprintf($$, "\t%s %s", $1, $2);
	   }
	   | OPCODE operand COMMA operand
	   {
		sprintf($$, "\t%s %s,%s", $1, $2, $4);
	   }
	   ;

operand : STRING
		{
			resolve_macro($1);
			strcpy($$, $1);
		}
		| number
		{
			strcpy($$, $1);
		}
		| PARENTHESIS_BEGIN number PARENTHESIS_END
		{
			strcpy($$, "(");
			strcat($$, $2);
			strcat($$, ")");
		}
		| PARENTHESIS_BEGIN STRING PARENTHESIS_END
		{
			strcpy($$, "(");
			resolve_macro($2);
			strcat($$, $2);
			strcat($$, ")");
		}
		| BRACKET_BEGIN number BRACKET_END
		{
			strcpy($$, "[");
			strcat($$, $2);
			strcat($$, "]");
		}
		| BRACKET_BEGIN STRING BRACKET_END
		{
			strcpy($$, "[");
			resolve_macro($2);
			strcat($$, $2);
			strcat($$, "]");
		}
		| PARENTHESIS_BEGIN STRING PLUS number PARENTHESIS_END
		{
			strcpy($$, "(");
			strcat($$, $2);
			strcat($$, "+");
			strcat($$, $4);
			strcat($$, ")");
		}
		| PARENTHESIS_BEGIN STRING PLUS STRING PARENTHESIS_END
		{
			strcpy($$, "(");
			strcat($$, $2);
			strcat($$, "+");
			resolve_macro($4);
			strcat($$, $4);
			strcat($$, ")");
		}
		| BRACKET_BEGIN STRING PLUS number BRACKET_END
		{
			strcpy($$, "[");
			strcat($$, $2);
			strcat($$, "+");
			strcat($$, $4);
			strcat($$, "]");
		}
		| BRACKET_BEGIN STRING PLUS STRING BRACKET_END
		{
			strcpy($$, "[");
			strcat($$, $2);
			strcat($$, "+");
			resolve_macro($4);
			strcat($$, $4);
			strcat($$, "]");
		}
	   ;

%%

int main(int argc, char *argv[])
{
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s)
{
	extern int yylineno;

	fprintf(stderr, "**ERROR** at line %d: %s\n", yylineno, s);
}

void register_macro(char* label_name, char* label_value)
{
	strcpy(label_names[label_idx], label_name);
	strcpy(label_values[label_idx], label_value);
	label_idx++;
}

int srch_macro(char* label_name)
{
	int idx;
	for (idx = 0; idx < label_idx; idx++)
		if (!strcmp(label_names[idx], label_name))
		return idx;
	return -1;
}

void resolve_macro(char* string)
{
	int idx = srch_macro(string);
	if (idx != -1)
		strcpy(string, label_values[idx]);
}

