%{
#define HELLO "Parser booleano/aritmetico\nPor: Oscar Medina Duarte\nBajo licencia BSD"
#include "y.tab.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

%}

Natural ([0-9]+)
Cadena \"[^"\n]*["]
Return "\n"

%%
%{
int i;
%}

{Return} {return NL;}
"bye"|"quit"|"exit"|"resume"	{return BYE;}

{Natural} {
		yylval.entero =atoi(yytext);
		return ENTERO;
		}
{Cadena} {
		for(i=1;i<strlen(yytext)-1;i++)
			yytext[i-1] = yytext[i];
			
		yytext[i-1] = '\0';
		yylval.cadena = malloc(strlen(yytext)+1);
		strcpy(yylval.cadena,yytext);
		return CADENA;
		}

"=="		{return EQ;}
"!="		{return NE;}
"||"		{return OR;}
"&&"		{return AND;}
">="		{return GEQ;}
"=>"		{return GEQ;}
"<="		{return LEQ;}
"=<"		{return LEQ;}

"eq"		{return SEQ;}
"ne"		{return SNE;}
"gt"		{return SG;}
"lt"		{return SL;}
"ge"		{return SGE;}
"le"		{return SLE;}

[ \t];
. return yytext[0];


%%
