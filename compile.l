%{

#include <stdio.h>
#include "compile.tab.h"

%}

%option yylineno

%%

[[:digit:]][0-9a-fA-F]*h {
	yytext[yyleng - 1] = '\0';
	int decimal = strtol(yytext, NULL, 16);
	sprintf(yylval.string, "%d", decimal);
	return HEX;
}

[[:digit:]]+ {
	strcpy(yylval.string, yytext);
	return DECIMAL;
}

"END" {
	strcpy(yylval.string, yytext);
	return END;
}

"ACC" {
	strcpy(yylval.string, yytext);
	return ACC;
}

"IX" {
	strcpy(yylval.string, yytext);
	return IX;
}

"," {
	return COMMA;
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

"HLT" {
	strcpy(yylval.string, yytext);
	return HLT;
}

"NOP" {
	strcpy(yylval.string, yytext);
	return NOP;
}

"IN" {
	strcpy(yylval.string, yytext);
	return IN;
}

"OUT" {
	strcpy(yylval.string, yytext);
	return OUT;
}

"SCF" {
	strcpy(yylval.string, yytext);
	return SCF;
}

"RCF" {
	strcpy(yylval.string, yytext);
	return RCF;
}

"LD" {
	strcpy(yylval.string, yytext);
	return LD;
}

"ST" {
	strcpy(yylval.string, yytext);
	return ST;
}

"ADD" {
	strcpy(yylval.string, yytext);
	return ADD;
}

"ADC" {
	strcpy(yylval.string, yytext);
	return ADC;
}

"SUB" {
	strcpy(yylval.string, yytext);
	return SUB;
}

"SBC" {
	strcpy(yylval.string, yytext);
	return SBC;
}

"CMP" {
	strcpy(yylval.string, yytext);
	return CMP;
}

"AND" {
	strcpy(yylval.string, yytext);
	return AND;
}

"OR" {
	strcpy(yylval.string, yytext);
	return OR;
}

"EOR" {
	strcpy(yylval.string, yytext);
	return EOR;
}

"SRA" {
	strcpy(yylval.string, yytext);
	return SRA;
}

"SLA" {
	strcpy(yylval.string, yytext);
	return SLA;
}

"SRL" {
	strcpy(yylval.string, yytext);
	return SRL;
}

"SLL" {
	strcpy(yylval.string, yytext);
	return SLL;
}

"RRA" {
	strcpy(yylval.string, yytext);
	return RRA;
}

"RLA" {
	strcpy(yylval.string, yytext);
	return RLA;
}

"RRL" {
	strcpy(yylval.string, yytext);
	return RRL;
}

"RLL" {
	strcpy(yylval.string, yytext);
	return RLL;
}

"BA" {
	strcpy(yylval.string, yytext);
	return BA;
}

"BVF" {
	strcpy(yylval.string, yytext);
	return BVF;
}

"BNZ" {
	strcpy(yylval.string, yytext);
	return BNZ;
}

"BZ" {
	strcpy(yylval.string, yytext);
	return BZ;
}

"BZP" {
	strcpy(yylval.string, yytext);
	return BZP;
}

"BN" {
	strcpy(yylval.string, yytext);
	return BN;
}

"BP" {
	strcpy(yylval.string, yytext);
	return BP;
}

"BZN" {
	strcpy(yylval.string, yytext);
	return BZN;
}

"BNI" {
	strcpy(yylval.string, yytext);
	return BNI;
}

"BNO" {
	strcpy(yylval.string, yytext);
	return BNO;
}

"BNC" {
	strcpy(yylval.string, yytext);
	return BNC;
}

"BC" {
	strcpy(yylval.string, yytext);
	return BC;
}

"BGE" {
	strcpy(yylval.string, yytext);
	return BGE;
}

"BLT" {
	strcpy(yylval.string, yytext);
	return BLT;
}

"BGT" {
	strcpy(yylval.string, yytext);
	return BGT;
}

"BLE" {
	strcpy(yylval.string, yytext);
	return BLE;
}

[[:blank:]]|"\n" {}

%%

