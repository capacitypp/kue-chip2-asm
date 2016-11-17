%{

#include <stdio.h>
#include "macro_expansion.tab.h"

%}

%option yylineno

%%

"HLT" {
	yylval.string = strdup(yytext);
	return HLT;
}

. {}

"\n" {}

%%

