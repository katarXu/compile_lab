5.

1.检验运算符优先级
2.检验括号
3.
mkdir -p $(SRC) 若没有创建src目录
mkdir -p $(BIN) 若没有创建bin目录
$(YACC) -d -y -r solved -b $@ -o $(SRC)/$@.tab.c $(CONF)/$@.y	指定yacc的目录及生成文件
$(LEX) -i -I -o $(SRC)/expr.lex.c $(CONF)/$(EXPRLEX).lex 指定flex的目录及生成文件
$(CC) -DDEBUG -o $(BIN)/$@ $(SRC)/expr.lex.c $(SRC)/$@.tab.c -lfl -lm 指定gcc的目录及生成文件