%{
    int numChars=0;
%}

%%

. {
    numChars++;
    printf("%s", yytext);
}

\n {
    numChars++;
    printf("\n") ;
}

%%

int main() {
    yylex( ) ;
    printf("Number of characters: %d\n", numChars);
}