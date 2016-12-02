%{

#include <stdio.h>
#include "macro_expansion.tab.h"

%}

%option yylineno

%%

[[:alnum:]]+: {
	yytext[yyleng - 1] = '\0';
	strcpy(yylval.label_name, yytext);
	unput(':');
	return LABEL;
}

":" {
	return COLON;
}

"EQU" {
	return EQU;
}

[[:digit:]][0-9a-fA-F]+h {
	strcpy(yylval.hex, yytext);
	return HEX;
}

[0-9]+ {
	strcpy(yylval.decimal, yytext);
	return DECIMAL;
}

"HLT"|"NOP"|"IN"|"OUT"|"SCF"|"RCF"|"LD"|"ST"|"ADD"|"ADC"|"SUB"|"SBC"|"CMP"|"AND"|"OR"|"EOR"|"SRA"|"SLA"|"SRL"|"SLL"|"RRA"|"RLA"|"RRL"|"RLL"|"BA"|"BVF"|"BNZ"|"BZ"|"BZP"|"BN"|"BP"|"BZN"|"BNI"|"BNO"|"BNC"|"BC"|"BGE"|"BLT"|"BGT"|"BLE" {
	strcpy(yylval.opcode, yytext);
	return OPCODE;
}

"END" {
	return END;
}

[[:alpha:]][[:alnum:]]* {
	strcpy(yylval.string, yytext);
	return STRING;
}

"(" {
	return PARENTHESIS_BEGIN;
}

")" {
	return PARENTHESIS_END;
}

"[" {
	return BRACKET_BEGIN;
}

"]" {
	return BRACKET_END;
}

"+" {
	return PLUS;
}

"," {
	return COMMA;
}

"*".*$ { }

.|"\n" {}

%%

