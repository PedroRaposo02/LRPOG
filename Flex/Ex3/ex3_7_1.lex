%{
    int count = 0;
    char* word = "TEST";
%}

Character "TEST"

%%

{Character} {
    count++;
    printf("%s", yytext);
}

\n {
    printf("\n");
}

%%

int main() {
    yylex();
    printf("\nNumber of the word %s: %d\n", word, count);
    return 0;
}	