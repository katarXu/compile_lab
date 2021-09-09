CC       = gcc -g
LEX      = flex -i -I 
PWD	  =$(shell pwd)
NAME_APP1 =labLexer-2
NAME_APP2 =labLexer-2m

TARGETS=$(NAME_APP1) $(NAME_APP2)
SOURCE_1=$(PWD)/src/labLexer-2.c
SOURCE_2=$(PWD)/src/labLexer-1.c
SOURCE_lex=$(PWD)/grammar/labLexer-2.lex
SOURCE_YY=$(PWD)/grammar/lex.yy.c
all: labLexer-2 labLexer-2m
	

labLexer-2:   $(SOURCE_lex)
	make clean
	$(LEX)  $(SOURCE_lex)
	$(CC)  $(INC) -DLEXERGEN $(SOURCE_YY) $(SOURCE_1) -o labLexer-2 -ll

labLexer-2m:   
	$(CC)  $(INC) $(SOURCE_2) -o labLexer-2m -ll

clean:
	rm -f *.BAK *.o core *~* *.a 
	rm -f *.tab.h *.tab.c
	rm -f labLexer-2 *.out
	rm -f labLexer-2m *.out