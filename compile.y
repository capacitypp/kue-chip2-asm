%{

#include <stdio.h>
#include <string.h>

extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);

%}

%union {
	char string[256];
}

%defines
%token HLT NOP IN OUT SCF RCF
%token LD ST
%token ADD ADC SUB SBC CMP AND OR EOR
%token SRA SLA SRL SLL
%token RRA RLA RRL RLL
%token BA BVF BNZ BZ BZP BN BP BZN BNI BNO BNC BC BGE BLT BGT BLE
%token END
%token COMMA
%token ACC IX
%token PARENTHESIS_BEGIN PARENTHESIS_END
%token BRACKET_BEGIN BRACKET_END
%token PLUS
%token HEX DECIMAL
%type <string> HLT NOP IN OUT SCF RCF
%type <string> LD ST
%type <string> ADD ADC SUB SBC CMP AND OR EOR
%type <string> SRA SLA SRL SLL
%type <string> RRA RLA RRL RLL
%type <string> BA BVF BNZ BZ BZP BN BP BZN BNI BNO BNC BC BGE BLT BGT BLE
%type <string> Ssm Rsm Bcc
%type <string> ld st add adc sub sbc cmp and or eor ssm rsm bcc
%type <string> ea reg imm ma
%type <string> number
%type <string> HEX DECIMAL
%type <string> ACC IX
%type <string> command

%%

program: commands END
	   {
		puts("END");
	   }
	   ;

commands:
		| commands command
		{
			puts($2);
		}
		;

command: HLT
	   | NOP
	   | IN
	   | OUT
	   | SCF
	   | RCF
	   | ld
	   | st
	   | add
	   | adc
	   | sub
	   | sbc
	   | cmp
	   | and
	   | or
	   | eor
	   | ssm
	   | rsm
	   | bcc
	   ;

ld: LD reg COMMA ea
  {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
  }
  ;

st: ST reg COMMA ma
  {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
  }
  ;

add: ADD reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

adc: ADC reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

sub: SUB reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

sbc: SBC reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

cmp: CMP reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

and: AND reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

or: OR reg COMMA ea
  {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
  }
  ;

eor: EOR reg COMMA ea
   {
	strcpy($$, $1);
	strcat($$, $2);
	strcat($$, $4);
   }
   ;

reg: ACC
   | IX
   ;

ea: reg
  | imm
  {
	strcpy($$, " ");
	strcat($$, $1);
  }
  | ma
  ;

ma: PARENTHESIS_BEGIN number PARENTHESIS_END
  {
	strcpy($$, "D ");
	strcat($$, $2);
  }
  | BRACKET_BEGIN number BRACKET_END
  {
	strcpy($$, "P ");
	strcat($$, $2);
  }
  | PARENTHESIS_BEGIN IX PLUS number PARENTHESIS_END
  {
	strcpy($$, "IXD ");
	strcat($$, $4);
  }
  | BRACKET_BEGIN IX PLUS number BRACKET_END
  {
	strcpy($$, "IXP ");
	strcat($$, $4);
  }
  ;

imm: number
   ;

bcc: Bcc imm
   {
	strcpy($$, $1);
	strcat($$, " ");
	strcat($$, $2);
   }
   ;

Bcc: BA
   | BVF
   | BNZ
   | BZ
   | BZP
   | BN
   | BP
   | BZN
   | BNI
   | BNO
   | BNC
   | BC
   | BGE
   | BLT
   | BGT
   | BLE
   ;

number: HEX
	  | DECIMAL
	  ;

ssm: Ssm reg
   {
	strcpy($$, $1);
	strcat($$, $2);
   }
   ;

Ssm: SRA
   | SLA
   | SRL
   | SLL
   ;

rsm: Rsm reg
   {
	strcpy($$, $1);
	strcat($$, $2);
   }
   ;

Rsm: RRA
   | RLA
   | RRL
   | RLL
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

