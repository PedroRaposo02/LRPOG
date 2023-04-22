%{
%}

%option nounput


LETRA [A-Z]
DIGITO [0-9]
BLANKS [ \t\r]*
PLATE1 {LETRA}{2}-{LETRA}{2}-{DIGITO}{2}
PLATE2 {LETRA}{2}-{DIGITO}{2}-{LETRA}{2}
PLATE3 {DIGITO}{2}-{LETRA}{2}-{DIGITO}{2}
PLATE4 {DIGITO}{2}-{DIGITO}{2}-{LETRA}{2}

VALID_PLATE {BLANKS}({PLATE1}|{PLATE2}|{PLATE3}|{PLATE4}){BLANKS}

%%

{VALID_PLATE} { printf("Valid plate: %s\n", yytext); }
.* { printf("Invalid plate: %s\n", yytext);}

%%

int main() {
    yylex();
    printf("\n\n");
    return 0;
}	