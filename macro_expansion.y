%{

#include <stdio.h>

//#define YYSTYPE char*

extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
void add_data(unsigned char data);
void newline(void);

%}

%union {
	char* string;
	char basic_command;
	char reg;
	char ea[2];
	unsigned char hex;
	char command2[2];
	unsigned char address;
}

%defines
%token HLT NOP IN OUT SCF RCF
%token LD
%token ST
%token ADD ADC SUB SBC CMP AND OR EOR
%token SRA SLA SRL SLL
%token RRA RLA RRL RLL
%token BA BVF BNZ BZ BZP BN BP BZN BNI BNO BNC BC BGE BLT BGT BLE
%token ACC IX
%token HEX
%token PARENTHESIS_BEGIN PARENTHESIS_END BRACKET_BEGIN BRACKET_END
%token PLUS
%token COMMA
%type <basic_command> command1 operator_simgle operator_reg_ea operator_reg_ma command_reg operator_reg operator_imm
%type <reg> reg;
%type <ea> ea ma
%type <hex> HEX d dd pd dixd pixd
%type <command2> command2 command_reg_ea command_reg_ma command_imm
%type <address> imm

%%

program: commands
	   ;

commands: 
		| commands command
			{
				newline();
			}
		;

command: command1
			{
				add_data($1);
			}
	   | command2
	   ;

command1: operator_simgle
		| command_reg
	   ;

command2: command_reg_ea
			{
				add_data($1[0]);
				if (($1[0] & 0x07) >= 0x02)
					add_data($1[1]);
			}
		| command_reg_ma
			{
				add_data($1[0]);
				add_data($1[1]);
			}
		| command_imm
			{
				add_data($1[0]);
				add_data($1[1]);
			}
		;

command_reg_ea: operator_reg_ea reg COMMA ea
				{
					$$[0] = $1;
					$$[0] |= $2;
					$$[0] |= $4[0];
					$$[1] = $4[1];
				}
			  ;

command_reg_ma: operator_reg_ma reg COMMA ma
				{
					$$[0] = $1;
					$$[0] |= $2;
					$$[0] |= $4[0];
					$$[1] = $4[1];
				}
			  ;

command_reg: operator_reg reg
			{
				$$ = $1;
				$$ |= $2;
			}
		   ;

command_imm: operator_imm imm
			{
				$$[0] = $1;
				$$[1] = $2;
			}
		  ;

operator_simgle: NOP
			   | HLT
			   | OUT
			   | IN
			   | RCF
			   | SCF
			   ;

operator_reg_ea: LD
			   | ADD
			   | ADC
			   | SUB
			   | SBC
			   | CMP
			   | AND
			   | OR
			   | EOR
			   ;

operator_reg_ma: ST
			   ;

operator_reg: SRA
			| SLA
			| SRL
			| SLL
			| RRA
			| RLA
			| RRL
			| RLL
			;

operator_imm: BA
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

reg: ACC
	{
		$$ = 0x00;
	}
   | IX
	{
		$$ = 0x08;
	}
   ;

ea: ACC
	{
		$$[0] = 0x00;
	}
  | IX
	{
		$$[0] = 0x01;
	}
  | d
	{
		$$[0] = 0x02;
		$$[1] = $1;
	}
  | dd
	{
		$$[0] = 0x05;
		$$[1] = $1;
	}
  | pd
	{
		$$[0] = 0x04;
		$$[1] = $1;
	}
  | dixd
	{
		$$[0] = 0x07;
		$$[1] = $1;
	}
  | pixd
	{
		$$[0] = 0x06;
		$$[1] = $1;
	}
  ;

ma: dd
	{
		$$[0] = 0x05;
		$$[1] = $1;
	}
  | pd
	{
		$$[0] = 0x04;
		$$[1] = $1;
	}
  | dixd
	{
		$$[0] = 0x07;
		$$[1] = $1;
	}
  | pixd
	{
		$$[0] = 0x06;
		$$[1] = $1;
	}
  ;
d: HEX
 ;

dd: PARENTHESIS_BEGIN d PARENTHESIS_END
	{
		$$ = $2;
	}
  ;

pd: BRACKET_BEGIN d BRACKET_END
	{
		$$ = $2;
	}
  ;

dixd: PARENTHESIS_BEGIN IX PLUS d PARENTHESIS_END
	{
		$$ = $4;
	}
	;

pixd: BRACKET_BEGIN IX PLUS d BRACKET_END
	{
		$$ = $4;
	}
	;

imm: d
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

void add_data(unsigned char data)
{
	printf("%02X ", (int)data);
}

void newline(void)
{
	putchar('\n');
}

