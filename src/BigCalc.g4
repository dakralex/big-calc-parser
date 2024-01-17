grammar BigCalc;

// <statement>;
expressionStatement
        : expression ';' EOF
        ;

// <expression> * 9
expression  
        : expression op=('*' | '/') expression  # mulDiv
        | expression op=('+' | '-') expression  # addSub
        | Number                                # num
        ;

// 1.0
Number  
        : Digit* '.' Digit+
        | Digit+
        ;

Digit   
        : [0-9]
        ;

WS      : [ \t\r\n\u000C]+ -> skip  
        ;

COMMENT
        :   '/*' .*? '*/' -> skip
        ;

LINE_COMMENT
        : '//' ~[\r\n]* -> skip 
        ;


