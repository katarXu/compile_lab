#include <iostream>
#include "antlr4-runtime.h"
#include "labLexer.h"
#include "string.h"
using namespace antlr4;
int main(int argc, const char* argv[])
{
	char str[1000];
	std::cin.getline(str,1000);
	ANTLRInputStream input(str);

        labLexer lexer(&input);
    CommonTokenStream tokens(&lexer);
tokens.fill();
    for (auto token : tokens.getTokens()) {
	if(token->getType()==31)
		std::cout << "(other,"<< (token->getStopIndex()-token->getStartIndex()+1) << ")" ;
	else{
	switch(token->getType()){
	case 14:
			std::cout << "(relop,=)" ;break;
		case 15:
			std::cout << "(relop,<>)" ;break;
	case 16:
			std::cout << "(relop,<)" ;break;
	case 17:
			std::cout << "(relop,>)" ;break;
	case 18:
			std::cout << "(relop,<=)" ;break;
	case 19:
			std::cout << "(relop,>=)" ;break;}
}
       
    }
    return 0;
}