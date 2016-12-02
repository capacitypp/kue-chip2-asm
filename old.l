%{

#include <stdio.h>
#include "macro_expansion.tab.h"

%}

%option yylineno

%%

"HLT" {
	yylval.basic_command = 0x08;
	return HLT;
}

"NOP" {
	yylval.basic_command = 0x00;
	return NOP;
}

"IN" {
	yylval.basic_command = 0x18;
	return IN;
}

"OUT" {
	yylval.basic_command = 0x10;
	return OUT;
}

"SCF" {
	yylval.basic_command = 0x28;
	return SCF;
}

"RCF" {
	yylval.basic_command = 0x20;
	return RCF;
}

"LD" {
	yylval.basic_command = 0x60;
	return LD;
}

"ST" {
	yylval.basic_command = 0x70;
	return ST;
}

"ADD" {
	yylval.basic_command = 0xb0;
	return ADD;
}

"ADC" {
	yylval.basic_command = 0x90;
	return ADC;
}

"SUB" {
	yylval.basic_command = 0xA0;
	return SUB;
}

"SBC" {
	yylval.basic_command = 0x80;
	return SBC;
}

"CMP" {
	yylval.basic_command = 0xF0;
	return CMP;
}

"AND" {
	yylval.basic_command = 0xE0;
	return AND;
}

"OR" {
	yylval.basic_command = 0xD0;
	return OR;
}

"EOR" {
	yylval.basic_command = 0xC0;
	return EOR;
}

"SRA" {
	yylval.basic_command = 0x40;
	return SRA;
}

"SLA" {
	yylval.basic_command = 0x41;
	return SLA;
}

"SRL" {
	yylval.basic_command = 0x42;
	return SRL;
}

"SLL" {
	yylval.basic_command = 0x43;
	return SLL;
}

"RRA" {
	yylval.basic_command = 0x44;
	return RRA;
}

"RLA" {
	yylval.basic_command = 0x45;
	return RLA;
}

"RRL" {
	yylval.basic_command = 0x46;
	return RRL;
}

"RLL" {
	yylval.basic_command = 0x47;
	return RLL;
}

"BA" {
	yylval.basic_command = 0x30;
	return BA;
}

"BVF" {
	yylval.basic_command = 0x38;
	return BVF;
}

"BNZ" {
	yylval.basic_command = 0x31;
	return BNZ;
}

"BZ" {
	yylval.basic_command = 0x39;
	return BZ;
}

"BZP" {
	yylval.basic_command = 0x32;
	return BZP;
}

"BN" {
	yylval.basic_command = 0x3A;
	return BN;
}

"BP" {
	yylval.basic_command = 0x33;
	return BP;
}

"BZN" {
	yylval.basic_command = 0x3B;
	return BZN;
}

"BNI" {
	yylval.basic_command = 0x34;
	return BNI;
}

"BNO" {
	yylval.basic_command = 0x3C;
	return BNO;
}

"BNC" {
	yylval.basic_command = 0x35;
	return BNC;
}

"BC" {
	yylval.basic_command = 0x3D;
	return BC;
}

"BGE" {
	yylval.basic_command = 0x36;
	return BGE;
}

"BLT" {
	yylval.basic_command = 0x3E;
	return BLT;
}

"BGT" {
	yylval.basic_command = 0x37;
	return BGT;
}

"BLE" {
	yylval.basic_command = 0x3F;
//	yylval.string = strdup(yytext);
	return BLE;
}

"ACC" {
	return ACC;
}

"IX" {
	return IX;
}

[0-9a-fA-F]{1,2}h {
	yylval.hex = strtol(yytext, NULL, 16);
	return HEX;
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

. {}

"\n" {}

%%

