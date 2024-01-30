grammar BigCalcProg;

program
        : progStatement+ EOF
        ;

progStatement
        : assignment ';' #assigmentStatement
        | expression ';' #expressionStatement
        ;

assignment
        : VariableName '=' expression
        ;

expression
        : expression op=('*' | '/') expression  #mulDiv
        | expression op=('+' | '-') expression  #addSub
        | '(' expression ')'                    #parens
        | VariableName                          #var
        | Number                                #num
        ;

VariableName
        : Letter Digit*
        ;

Number
        : Digit* '.' Digit+
        | Digit+
        | [0-9]
        ;

Letter
        : [a-zA-Z]
        ;

Digit
        : [0-9]
        ;

Whitespace
        : [ \t]+ -> skip
        ;

Newline
        : [\r\n\u000C]+ -> skip
        ;

BlockComment
        :   '/*' .*? '*/' -> skip
        ;

LineComment
        : '//' ~[\r\n]* -> skip
        ;