
/*
 * expr.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * The parser uses precedence declarations to eliminate conflicts.
 */

%{
#undef DEBUG
#include <stdio.h>
#include <math.h>
#include <string.h>
int yylex();
void yyerror(const char *s);
int lineno = 0;

struct ASTNode{
  char message[100];
  float value;
};
char* itoa(int num,char* str,int radix)
{/*索引表*/
    char index[]="0123456789ABCDEF";
    unsigned unum;/*中间变量*/
    int i=0,j,k;
    /*确定unum的值*/
    if(radix==10&&num<0)/*十进制负数*/
    {
        unum=(unsigned)-num;
        str[i++]='-';
    }
    else unum=(unsigned)num;/*其他情况*/
    /*转换*/
    do{
        str[i++]=index[unum%(unsigned)radix];
        unum/=radix;
       }while(unum);
    str[i]='\0';
    /*逆序*/
    if(str[0]=='-')
        k=1;/*十进制负数*/
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
  struct ASTNode node;
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
	  { printf("Line %d (%d):\t", lineno++, @1.last_line);
	  }
          line
        ;

line    : EOL			{ printf("\n");}
        | exp EOL 		{ printf("%s  = %g at line %d\n",$1.message,$1.value,@1.last_line);}

exp     : NUMBER                 { $$.value = $1;itoa($1,$$.message,10);        }
        | exp PLUS  exp          { $$.value = $1.value + $3.value;strcat($1.message," ");strcat($1.message,$3.message);char s[3]=" +\0";strcat($1.message,s);strcpy($$.message,$1.message);   }
        | exp MINUS exp          { $$.value = $1.value - $3.value;strcat($1.message," ");strcat($1.message,$3.message);char s[3]=" -\0";strcat($1.message,s);strcpy($$.message,$1.message);     }
        | exp MULT  exp          { $$.value = $1.value * $3.value;strcat($1.message," ");strcat($1.message,$3.message);char s[3]=" *\0";strcat($1.message,s);strcpy($$.message,$1.message);    }
        | exp DIV   exp          { $$.value = $1.value / $3.value;strcat($1.message," ");strcat($1.message,$3.message);char s[3]=" /\0";strcat($1.message,s);strcpy($$.message,$1.message);    }
        | MINUS  exp %prec MINUS { $$.value = -$2.value;char s[3]=" -\0";strcat($2.message,s);strcpy($$.message,$2.message);        }
        | exp EXPON exp          { $$.value = pow($1.value,$3.value);strcat($1.message," ");strcat($1.message,$3.message);char s[4]=" **\0";strcat($1.message,s);strcpy($$.message,$1.message); }
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


/*
 * expr.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * The parser uses precedence declarations to eliminate conflicts.
 */
/*
%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
int lineno = 0;
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

%type  <val> exp

%%
input   :
	  { lineno ++; }
        |  
          input
	  { printf("Line %d (%d):\t", lineno++, @1.last_line);
	  }
          line
        ;

line    : EOL			{ printf("\n");}
        | exp EOL 		{ printf(" = %g at line %d\n",$1, @1.last_line);}

exp     : NUMBER                 { $$ = $1;        }
        | exp PLUS  exp          { $$ = $1 + $3;   }
        | exp MINUS exp          { $$ = $1 - $3;   }
        | exp MULT  exp          { $$ = $1 * $3;   }
        | exp DIV   exp          { $$ = $1 / $3;   }
        | MINUS  exp %prec MINUS { $$ = -$2;       }
        | exp EXPON exp          { $$ = pow($1,$3);}
        | LB exp RB              { $$ = $2;        }
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

*/