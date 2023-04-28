%{
#include <stdio.h>
#include <stdlib.h>
extern int yyparse();
extern int yylex();
%}

%token HW

%%
    hw_list: hw
        | hw hw_list
        ;
    
    hw: HW {
        printf("Hello World!\n");
    }

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
