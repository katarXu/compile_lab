lexer grammar labLexer;

tokens {
    Comma,
    SemiColon,
    Assign,
    LeftBracket,
    RightBracket,
    LeftBrace,
    RightBrace,
    LeftParen,
    RightParen,
    If,
    Else,
    While,
    Const,
    Equal,
    NonEqual,
    Less,
    Greater,
    LessEqual,
    GreaterEqual,
    Plus,
    Minus,
    Multiply,
    Divide,
    Modulo,

    Int,
    Float,
    Void,

    Identifier,
    IntConst,
    FloatConst,
    Other
}

Equal: '=';
NonEqual: '<>';

Greater: '>' ;
GreaterEqual: '>=' ;
Less: '<' ;
LessEqual: '<=' ;

Other:[^<=>]+;
