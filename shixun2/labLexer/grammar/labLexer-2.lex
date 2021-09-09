/*
 * expr.lex : Scanner for a simple
 *            expression parser.
 */

%{
#include "pl0.h"
#include <stdio.h>
#include <string.h>
%}

%%
"<>"        {printf("(relop,<>)");}
"<="        {printf("(relop,<=)");}
">="        {printf("(relop,>=)");}
">"         {printf("(relop,>)");}
"<"         {printf("(relop,<)");}
"="         {printf("(relop,=)");}
[^<=>\n]+    {
	     num = strlen(yytext);
             printf("(other,%d)",num);
           }
%%
void getsym()
{
	sym = yylex();
}
