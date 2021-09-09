#include "stdio.h"
//#include<stdlib.h>
int main()
{
	char ch[2000];
	gets_s(ch, 2000);
	int i = 0, num = 0;
	int flag1 = 0;//judge if use ','
	int flag2 = 1;//judge other or relop
	char last = '\0';
	while (ch[i] != '\0'&&ch[i] != '\n'&&ch[i] != '\r') {
		if (ch[i] >= '<'&&ch[i] <= '>') {
			if (flag2 == 0) {
				if (flag1 == 0)
					flag1 = 1;
				else
					putchar(',');
				printf("(other,%d)", num);
				num = 0;
				flag2 = 1;
			}
			if (last == '\0') {
				if (ch[i] == '=') {
					if (flag1 == 0)
						flag1 = 1;
					else
						putchar(',');
					printf("(relop,%c)", ch[i++]);
				}
				else {
					last = ch[i++];
					continue;
				}
			}
			else if (last == '<'&&ch[i] == '<' || last == '>'&&ch[i] != '=') {
				if (flag1 == 0)
					flag1 = 1;
				else
					putchar(',');
				printf("(relop,%c)", last);
				last = '\0';
			}
			else {
				if (flag1 == 0)
					flag1 = 1;
				else
					putchar(',');
				printf("(relop,%c%c)", last, ch[i++]);
				last = '\0';
			}
		}
		else {
			if (last != '\0') {
				if (flag1 == 0)
					flag1 = 1;
				else
					putchar(',');
				printf("(relop,%c)", last);
				last = '\0';
			}
			flag2 = 0;
			num++;
			i++;
		}
	}
	if (num != 0) {
		if (flag1 == 0)
			flag1 = 1;
		else
			putchar(',');
		printf("(other,%d)", num);
		num = 0;
	}
	//system("pause");
	return 0;
}

