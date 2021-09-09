#include "stdio.h"

// expr lexer
#include <stdlib.h>
#include <string.h>
#include "pl0.h"

#ifndef LEXERGEN

#endif

void handle(char* ch)
{
	int i = 0, num = 0;
	//int flag1 = 0;//judge if use ','
	int flag2 = 1;//judge other or relop
	char last = '\0';
	while (ch[i] != '\0'&&ch[i] != '\n'&&ch[i] != '\r') {
		if (ch[i] >= '<'&&ch[i] <= '>') {
			if (flag2 == 0) {
				printf("(other,%d)", num);
				num = 0;
				flag2 = 1;
			}
			if (last == '\0') {
				if (ch[i] == '=')
					printf("(relop,%c)", ch[i++]);
				else {
					last = ch[i++];
					continue;
				}
			}
			else if (last == '<'&&ch[i] == '<' || last == '>'&&ch[i] != '=') {
				printf("(relop,%c)", last);
				last = '\0';
			}
			else {
				printf("(relop,%c%c)", last, ch[i++]);
				last = '\0';
			}
		}
		else {
			if (last != '\0') {
				printf("(relop,%c)", last);
				last = '\0';
			}
			flag2 = 0;
			num++;
			i++;
		}
	}
	if (num != 0) {
		printf("(other,%d)", num);
		num = 0;
	}
	if (last != '\0') {
		printf("(relop,%c)", last);
	}
	//system("pause");
}

int main()
{
    char str[1000];
    int i = 0;
    gets(str);

#ifdef LEXERGEN
    extern FILE *yyin,*infile;
    infile = fopen("lex.in", "w");
    for (;; i++){
        if (str[i] == '\0' || str[i] == '\r' || str[i] == '\n')
            break;
        else
            fprintf(infile, "%c", str[i]);
    }
    fclose(infile);
    infile = fopen("lex.in", "r");
    yyin = infile;
    getsym();
    while (sym)
        getsym();
    fclose(infile);
#endif
#ifndef LEXERGEN
    handle(str);
#endif
	return 0;
}