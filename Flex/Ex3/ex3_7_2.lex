%{
    int count = 0;
%}

%%

FEUP {
    printf("%s", "ISEP");
}

2007 {
    count++;
    printf("%d", "2008");
}

. {
    printf("%c", yytext[0]);
}

%%

int main() {
    yylex();
    printf("\nNumber of the word %s: %d\n", word, count);
    return 0;
}	