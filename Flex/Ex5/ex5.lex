%{
%}


ALGARISMO [0-9]
BLANKS [ \t\r]*

NATURAL {BLANKS}(([1-9]{ALGARISMO}*)|0){BLANKS}

%%
{NATURAL} {
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
