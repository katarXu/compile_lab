## 1.请阅读include/SyntaxTree.h,总结在该文件中声明了哪些类型和类，分别表示什么含义；进一步阅读src/SyntaxTree.cpp，指出其中定义的各个方法的作用。

> enum class： Type: declare int,float,void
>
> ​						BinOp:declare +,-,*,/,%
>
> ​						UnaryOp:declare +,-
>
> class:	Node:：语法树的节点基类
>
> ​			Assembly：普通语法树的根节点
>
> ​			GlobalDef：全局定义的声明的基类
>
> ​			FuncDef：函数声明
>
> ​			Expr：表达式的基类
>
> ​			BinaryExpr：含二则运算符的表达式
>
> ​			UnaryExpr：含正负号的表达式
>
> ​			LVal：（数组）变量
>
> ​			Literal：常量表达式（int|float）
>
> ​			Stmt：语句的基类
>
> ​			VarDef：变量声明
>
> ​			AssignStmt：变量赋值
>
> ​			FuncCallStmt：函数调用
>
> ​			ReturnStmt：return语句
>
> ​			BlockStmt：语句块
>
> ​			EmptyStmt：空语句
>
> ​			Visitor：提供访问者模式的接口visit(&)

> 为每个派生类声明accept函数，接受对对象的引用来调用visit函数实现对对象的操作

## 2.请阅读`src/C1Driver.cpp`、`src/main.cpp`并浏览`grammar`目录下C1语言的词法描述文件`C1Parser.ll`和文法描述文件`C1Parser.yy`，简述`C1Driver`类与词法分析类和语法分析类之间的关系，词法分析类和语法分析类与`C1Parser.ll`和`C1Parser.yy`之间的对应关系。



