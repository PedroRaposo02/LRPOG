%{
%}


ALGARISMO [0-9]
BLANKS [ \t\r]*
SIGNAL [+-]
DOT [.,]


NATURAL (([1-9]{ALGARISMO}*)|0)
INTEGER ({SIGNAL}?{NATURAL})
REAL ({BLANKS}{INTEGER}?({DOT}{NATURAL})?{BLANKS})

%%
{REAL} {
    printf("%s ", yytext);
}

. {}

%%

int main() { 
    printf("\n");
    yylex();
    printf("\n");
    return 0;
}
