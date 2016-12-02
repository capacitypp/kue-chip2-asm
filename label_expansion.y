%{

#include <stdio.h>
#include <string.h>

extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
void register_label(char* label);
int srch_label(char* command);
void resolve_label(char* command);
void register_command(char* command);

int address = 0;

int command_idx = 0;
char commands[256][256];

typedef struct {
	char label[256];
	int address;
} LabelDef;

int labeldef_idx = 0;
LabelDef labeldefs[256];

%}

%union	{
	char label_name[256];
	char hex[256];
	char decimal[256];
	char number[256];
	char string[256];
	char opcode[256];
	char command[256];
	int command_size;
}

%defines
%token END
%token LABEL
%token COLON
%token OPCODE OPCODE2
%token COMMA
%token PLUS
%token STRING
%token HEX DECIMAL
%token PARENTHESIS_BEGIN
%token PARENTHESIS_END
%token BRACKET_BEGIN
%token BRACKET_END
%type <hex> HEX
%type <decimal> DECIMAL
%type <number> number
%type <string> STRING bracket_begin bracket_end PARENTHESIS_BEGIN PARENTHESIS_END BRACKET_BEGIN BRACKET_END
%type <opcode> OPCODE OPCODE2
%type <command> command1 command2
%type <label_name> LABEL
%type <command_size> command

%%

program: commands END
	   ;

commands:
		| commands command
		{
			address += $2;
		}
		| commands LABEL COLON command
		{
			register_label($2);
			address += $4;
		}
		;

command: command1
	   {
		register_command($1);
		$$ = 1;
	   }
	   | command2
	   {
		register_command($1);
		$$ = 2;
	   }
	   ;

command1: OPCODE
		{
			strcpy($$, $1);
		}
		| OPCODE STRING
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
		}
		| OPCODE STRING COMMA STRING
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
			strcat($$, ",");
			strcat($$, $4);
		}
		;

command2: OPCODE number
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
		}
		| OPCODE2 number
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
		}
		| OPCODE2 STRING
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
		}
		| OPCODE STRING COMMA number
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
			strcat($$, ",");
			strcat($$, $4);
		}
		| OPCODE STRING COMMA bracket_begin number bracket_end
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
			strcat($$, ",");
			strcat($$, $4);
			strcat($$, $5);
			strcat($$, $6);
		}
		| OPCODE STRING COMMA bracket_begin STRING PLUS number bracket_end
		{
			strcpy($$, $1);
			strcat($$, " ");
			strcat($$, $2);
			strcat($$, ",");
			strcat($$, $4);
			strcat($$, $5);
			strcat($$, "+");
			strcat($$, $7);
			strcat($$, $8);
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

bracket_begin: PARENTHESIS_BEGIN
			 {
				strcpy($$, "(");
			 }
			 | BRACKET_BEGIN
			 {
				strcpy($$, "[");
			 }
			 ;

bracket_end: BRACKET_END
		   {
			strcpy($$, "]");
		   }
		   | PARENTHESIS_END
		   {
			strcpy($$, ")");
		   }
		   ;

%%

int main(int argc, char *argv[])
{
	int idx;

	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	for (idx = 0; idx < command_idx; idx++) {
		resolve_label(commands[idx]);
		puts(commands[idx]);
	}
	puts("END");

	return 0;
}

void yyerror(const char* s)
{
	extern int yylineno;

	fprintf(stderr, "**ERROR** at line %d: %s\n", yylineno, s);
}

void register_label(char* label)
{
	strcpy(labeldefs[labeldef_idx].label, label);
	labeldefs[labeldef_idx].address = address;
	labeldef_idx++;
}

int srch_label(char* command)
{
	int idx;
	for (idx = 0; idx < labeldef_idx; idx++)
		if (strstr(command, labeldefs[idx].label) != NULL)
			return idx;
	return -1;
}

void resolve_label(char* command)
{
	int idx = srch_label(command);
	if (idx == -1)
		return;
	char *ptr = strstr(command, labeldefs[idx].label);
	sprintf(ptr, "%02Xh", labeldefs[idx].address);
}

void register_command(char* command)
{
	strcpy(commands[command_idx], command);
	command_idx++;
}

