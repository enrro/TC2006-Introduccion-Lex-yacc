%{
int CharFlag=0;
%}
%union{
	char *cadena;
	int entero;
}

%token NL BYE
%token <cadena> CADENA;
%token <entero> ENTERO;

%left '^' '|' '&'
%left '-' '+' 
%left '*' '/' '%'
%left SEQ SNE SG SL SGE SLE
%left OR AND '>' '<' EQ NE GEQ LEQ

%nonassoc SNOT
%nonassoc SMENOS
%nonassoc SNNOT

%type <entero> expression

%%

entrada: statement
	| entrada statement
        ;


statement: NL 
	| expression NL		{printf("== %d \n",$1);}
	| BYE NL	{printf("Cerrando calculadora...\n");exit(0);}
	;

expression: expression '+' expression	{$$ = $1 + $3;}
	| expression '-' expression	{$$ = $1 - $3;}
	| expression '*' expression	{$$ = $1 * $3;}
	| expression '/' expression	
		{
			if($3 == 0.0)
				yyerror("Division por cero\n");
			else
				$$ = $1 / $3;
		}
	| expression '%' expression	
		{
			if($3 == 0.0)
				yyerror("Division por cero\n");
			else
				$$ = $1 % $3;
		}
	
	| expression '^' expression	{$$ = $1 ^ $3;}
	| expression '|' expression	{$$ = $1 | $3;}
	| expression OR expression	{$$ = $1 || $3;}
	| expression '&' expression	{$$ = $1 & $3;}
	| expression AND expression	{$$ = $1 && $3;}
	| expression '>' expression	{$$ = $1 > $3;}
	| expression '<' expression	{$$ = $1 < $3;}
	| expression EQ expression	{$$ = $1 == $3;}
	| expression NE expression	{$$ = $1 != $3;}
	| expression GEQ expression	{$$ = $1 >= $3;}
	| expression LEQ expression	{$$ = $1 <= $3;}
	
	| CADENA SEQ CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)==0)
				$$ = 1;
			else $$ = 0;
		}
	| CADENA SNE CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)==0)
				$$ = 0;
			else $$ = 1;
		}
	| CADENA SG CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)>0)
				$$ = 0;
			else $$ = 1;
		}
	| CADENA SL CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)<0)
				$$ = 0;
			else $$ = 1;
		}
	| CADENA SGE CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)>=0)
				$$ = 0;
			else $$ = 1;
		}
	| CADENA SLE CADENA
		{
			CharFlag=1;
			if(strcmp($1,$3)<=0)
				$$ = 0;
			else $$ = 1;
		}
	
	| '!' expression %prec SNOT	{$$ = !$2;}
	| '-' expression %prec SMENOS	{$$ = -$2;}
	| '~' expression %prec SNNOT	{$$ = ~$2;}
	| '('expression')'	{$$ = $2;}
	| ENTERO
	| CADENA
		{
			if (CharFlag==0)
				$$ = strlen($1);
			else{
				$$ = $1;
				CharFlag=0;
			}
			
		}
	;

%%

main (){
	printf("Parser de Expresiones variadas\n");
	yyparse();

}

