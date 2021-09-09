 你认为Examples/typeid-s2.cpp中的printTypeinfo函数的第2个参数的类型中的B可以改为D吗？这时程序编译和运行分别会有怎样的结果，如果要保证调用printTypeinfo(const char n, const D pb)是正确的，那么对第2个实参有何要求？

修改后直接编译会报错。若将代码进一步修改为如下形式： printTypeinfo("&b", (D*)&b); printTypeinfo("&d", &d); printTypeinfo("ptr", (D*)ptr); 则能够正常编译且运行结果与typeid-s2.cpp编译运行的结果相同。 因此，要保证调用printTypeinfo(const char n, const D pb)是正确的，那么对第2个实参要求为D*类型/或转换为D*类型。