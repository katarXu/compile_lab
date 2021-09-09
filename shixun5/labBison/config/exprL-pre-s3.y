/*
 * expr.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * The parser uses precedence declarations to eliminate conflicts.
 */

%{
 
#include <stdio.h>
#include <math.h>
#include <string.h>
int yylex();
void yyerror(const char *s);
int lineno = 0;


char* itoa(int num,char* str,int radix)
{
    char index[]="0123456789ABCDEF";
    unsigned unum;
    int i=0,j,k;
    if(radix==10&&num<0)
    {
        unum=(unsigned)-num;
        str[i++]='-';
    }
    else unum=(unsigned)num;
    do{
        str[i++]=index[unum%(unsigned)radix];
        unum/=radix;
       }while(unum);
    str[i]='\0';
    if(str[0]=='-')
        k=1;
    else
        k=0;
     
    for(j=k;j<=(i-1)/2;j++)
    {       char temp;
        temp=str[j];
        str[j]=str[i-1+k-j];
        str[i-1+k-j]=temp;
    }
    return str;
}
%}

%union {
  struct Message{
  char message[100];
  float value;
};
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

%type  <node> exp

%%
input   :
	  { lineno ++; }
        |  
          input
	  { printf("Line %d:\n\t", lineno++);
	  }
          line
        ;

line    : EOL			{ printf("\n");}
        | exp EOL 		{ printf("%s  = %g at line %d\n",$1.message,$1.value,@1.last_line);}

exp     : NUMBER                 { $$.value = $1;itoa($1,$$.message,10);        }
        | exp PLUS  exp          { strcpy($$.message," + ");$$.value = $1.value + $3.value;strcat($1.message," ");strcat($1.message,$3.message);strcat($$.message,$1.message);   }
        | exp MINUS exp          { strcpy($$.message," - ");$$.value = $1.value - $3.value;strcat($1.message," ");strcat($1.message,$3.message);strcat($$.message,$1.message);    }
        | exp MULT  exp          { strcpy($$.message," * ");$$.value = $1.value * $3.value;strcat($1.message," ");strcat($1.message,$3.message);strcat($$.message,$1.message);   }
        | exp DIV   exp          { strcpy($$.message," / ");$$.value = $1.value / $3.value;strcat($1.message," ");strcat($1.message,$3.message);strcat($$.message,$1.message);   }
        | MINUS  exp %prec MINUS { $$.message," - ");$$.value = -$2.value;strcpy(strcat($$.message,$2.message);       }
        | exp EXPON exp          {strcpy($$.message," ** "); $$.value = pow($1.value,$3.value);strcat($1.message," ");strcat($1.message,$3.message);strcat($$.message,$1.message);}
        | LB exp RB              { $$.value = $2.value;strcpy($$.message,$2.message);        }
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

