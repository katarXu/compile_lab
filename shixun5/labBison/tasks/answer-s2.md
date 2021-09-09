1、请用-r solved选项执行bison，将在src目录输出文件expr.output，其中State 9的定义如下：
State 9

    6 exp: exp . PLUS exp
    7    | exp . MINUS exp
    8    | exp . MULT exp
    9    | exp . DIV exp
   10    | MINUS exp .
   11    | exp . EXPON exp

    $default  reduce using rule 10 (exp)

    Conflict between rule 10 and token PLUS resolved as reduce (PLUS < UMINUS).
    Conflict between rule 10 and token MINUS resolved as reduce (MINUS < UMINUS).
    Conflict between rule 10 and token MULT resolved as reduce (MULT < UMINUS).
    Conflict between rule 10 and token DIV resolved as reduce (DIV < UMINUS).
    Conflict between rule 10 and token EXPON resolved as reduce (EXPON < UMINUS).
该状态包含5条冲突，请解释这些冲突产生的原因以及Bison对这些冲突的解决。

原因：存在移进归约冲突，在state 9时，下一个读入是PLUS、MINUS、MULT、DIV、EXPON时，可以移进也可以先归约为UMINUS exp，如-1*2可以解释为(-1)*2或-(1*2)
解决：resolved as reduce 选择归约，设置UMINUS的优先级高于其他运算符


3.请阅读labBison/config/expr1.y，并在labBison/下执行make expr1，然后检查输出的src/expr1.output，你将看到其中State 11和State 24还包含有冲突，请说明冲突的原因。

State 11

   12 fact: MINUS fact .
   13     | fact . EXPON fact

    EXPON  shift, and go to state 18

    $default  reduce using rule 12 (fact)

    Conflict between rule 12 and token EXPON resolved as shift (MINUS < EXPON).

原因：存在移进归约冲突，遇到EXPON可以先归约为MINUS fact.也可以先移进，如-1**2可以解释为(-1)**2或-(1**2)，这里选择移进，优先级MINUS < EXPON

State 24

   13 fact: fact . EXPON fact
   13     | fact EXPON fact .

    EXPON  shift, and go to state 18

    $default  reduce using rule 13 (fact)

    Conflict between rule 13 and token EXPON resolved as shift (%right EXPON).

原因：存在移进归约冲突，遇到EXPON可以先移进为fact EXPON fact.也可以按fact. EXPON fact归约，如1**2**1可以解释为(1**2)**1或1**(2**1)，这里选择移进，EXPON右结合

