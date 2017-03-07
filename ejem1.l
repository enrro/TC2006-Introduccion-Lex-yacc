%{
#include <stdlib.h>
int palabra=0, numero=0;
%}

Numero	-?[0-9]+
Palabra	[a-zA-Z]+

%%
"bye"		{bye();return 0;}
"quit"		{bye();return 0;}
"resume"	{bye();return 0;}
{Palabra}	{printf("Se leyo la palabra : %s", yytext);palabra++;}
{Numero}	{printf("Se leyo el numero : %d", atoi(yytext));numero++;}
. printf("%s",yytext[0]);


%%
main(){
	printf("ejem1.l\nEste ejemplo, distingue entre un numero entero y palabras.\nIntroduzca bye, quit o resume para terminar.\n");
	yylex();
}

bye(){
	printf("Se leyeron %d entradas, de las cuales se reconocieron\n%d\tEnteros\ny\n%d\tPalabras.\n", (palabra+numero), numero, palabra);
}
