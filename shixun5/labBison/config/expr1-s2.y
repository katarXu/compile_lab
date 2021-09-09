/*
 * expr1.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * The parser eliminates conflicts by introducing more nondeterminals.
 */

%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
%}

%union {
   float val;
   char *op;
}
%locations

%token <val> NUMBER
%token <op> PLUS MINUS MULT DIV EXPON
%token EOL
%token LB RB

%left  MINUS PLUS
%left  MULT DIV
%right EXPON

%type  <val> exp term fact pmfact nfact

%%
input   :
        | input line
        ;

line    : EOL { printf("\n");}
        | exp EOL { printf(" = %g  at line %d\n",$1, @$.last_line);}

exp     : exp PLUS  term         { $$ = $1 + $3;   }
        | exp MINUS term         { $$ = $1 - $3;   }
        | term                   { $$ = $1;        }
        ;
term    : term MULT pmfact       { $$ = $1 * $3;   }
        | term DIV  pmfact       { $$ = $1 / $3;   }
        | fact                   { $$ = $1;        }
        ;
pmfact	: fact					 { $$ = $1;}
		| MINUS fact			 { $$ = -$2; } 
		;
fact    : NUMBER nfact           { $$ = pow($1,$2);}
        | LB exp RB nfact        { $$ = pow($2,$4);}
        ;
nfact	: EXPON fact			 { $$ = $2;        }
		|						 { $$ = 1;}
		;


%%
void yyerror(const char *message)
{
  printf("%s\n",message);
}

int main(int argc, char *argv[])
{
  yyparse();
  return(0);
}








