 dynamic_cast 阅读并运行程序src/step3/dynamic_cast.cpp。回答以下问题： output: BasicBlock: 3 unary instructions, 2 binary instructions UnaryInst UnaryInst BinaryInst UnaryInst BinaryInst

1.BasicBlock::print函数在62-73行的运行逻辑是怎么样的？这里 RTTI 机制是怎样起作用的？ 
机制： 语法形式：dynamic_cast < new-type > ( expression ) new-type 和 expression 必须同时是指针类型或者引用类型，也即dynamic_cast只能转换指针类型和引用类型。 若转型成功，则 dynamic_cast 返回 新类型 类型的值。 对于指针，如果转换失败将返回 NULL；对于引用，如果转换失败将抛出std::bad_cast异常。 第62-73行代码： for (auto v : values) {//逐个遍历values中的元素 v为Value类型的指针 if (dynamic_cast<UnaryInst *>(v)) { //动态类型转换，失败返回NULL。故若为UnaryInst *,则返回非零值，反之返回NULL。进行进一步条件判断 unary_cnt++; } else if (dynamic_cast<BinaryInst *>(v)) {//同理 binary_cnt++; } else { std::cerr << "Unspported instruction: " << v->getName() << std::endl; abort(); } } 

2.如果没有 RTTI 机制（部分库会在编译时加上fno-rtti选项，因为 RTTI会带来一定的开销），这时应该如何实现BasicBlock::print函数，保持功能的一致性，在src/step3/static_cast.cpp里进行实现（注意：可以增加类成员和API）。 第62-73行代码： for (auto v : values) { if (v->getName()=="UnaryInst") { unary_cnt++; } else if (v->getName()=="BinaryInst") { binary_cnt++; } else { std::cerr << "Unspported instruction: " << v->getName() << std::endl; abort(); } } 详见static_cast.cpp。 

3.考虑实际场景里的使用，如果Instruction有很多个子类（不同的指令），那么你修改后的程序需要修改什么地方？ 在Value中增加bool类型Is_SetName，初值为false，调用setName()后置为true，当Is_SetName的值为true时，setName()指令无效，故初始化name之后就不能进行修改。 class Value { public: Value() { setName("Value"); } virtual ~Value() {} void setName(std::string n) { if(Is_SetName==false){ name = n; Is_SetName==true; } } std::string getName() { return name; } virtual void print() { std::cout << "I'm a " << getName() << std::endl; } protected: std::string name; bool Is_SetName=false; };

typeid 阅读并运行程序src/step3/typeid.cpp。回答以下问题：

1.分别使用g++和clang++运行并得到程序输出，并解释输出。 
g++: output: P5Value 10BasicBlock P11Instruction 10BinaryInst clang++: output: P5Value 10BasicBlock P11Instruction 10BinaryInst 两种编译器的输出相同。 'v'为定义为'Value'类型的指针，故输出P表示类型为指针类型，而后面的'Value'表示'v'是'Value'类型的指针。（5是"Value"的字符串长度） 而因为'Value *v = new BasicBlock();'，同时，Value声明了一个虚函数，对v求值后为'BasicBlock'类型，故输出'BasicBlock'。（10是"BasicBlock"的字符串长度） 同理，'inst'是'Instruction'类型的指针，故输出P表示类型为指针类型，而后面的'Instruction'表示是'Instruction'类型的指针。（11是"Instruction"的字符串长度）。 'Instruction *inst = new BinaryInst();',同时，Instruction继承了一个虚函数，对inst求值后为'BinaryInst'类型，故输出'BinaryInst'。（10是"BinaryInst"的字符串长度） 

2.当去掉Instruction类的父类Value（删除: public Value）时，程序的输出是什么？对输出进行解释
（编译器自选）。 
g++: output: P5Value 10BasicBlock P11Instruction 11Instruction 不同之处在于第四行，输出为'11Instruction'。 from https://zh.cppreference.com/w/cpp/language/typeid >检验表达式 表达式 a) 若 表达式 为标识某个多态类型（即声明或继承至少一个虚函数的类）对象的泛左值表达式，则 typeid 表达式对该表达式求值，然后指代表示该表达式动态类型的 std::type_info 对象。若该泛左值表达式为通过对一个指针应用一元 * 运算符所得，且该指针为空指针值，则抛出 std::bad_typeid 类型或从 std::bad_typeid 派生的类型的异常。 b) 若 表达式 不是多态类型的泛左值表达式，则 typeid 不对该表达式求值，而它所指代的 std::type_info 对象表示该表达式的静态类型。不进行左值到右值、数组到指针或函数到指针转换。然而对于纯右值参数，（形式上）要进行临时量实质化：参数必须在 typeid 表达式所出现的语境中可析构。 (C++17 起)

未修改前继承了虚函数，修改后未继承或声明虚函数，故 typeid 不对表达式求值。而 inst 为 Instruction 类型的指针，表达式*inst的静态类型为Instruction。