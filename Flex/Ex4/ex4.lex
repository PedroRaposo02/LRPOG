%{
    int algarismo = 0;
    int letra = 0;
    int linha_de_texto = 0;
    int expaco_tab = 0;
    int outros = 0;
%}

%option nounput

ALGARISMO [0-9]
LETRA [a-zA-Z]
LINHA_DE_TEXTO [\n]
EXPACO_TAB [ \t]


%%
{ALGARISMO} {algarismo++;}
{LETRA} {letra++;}
{LINHA_DE_TEXTO} {linha_de_texto++;}
{EXPACO_TAB} {expaco_tab++;}
. {outros++;}

%%

int main() {
    yylex();
    printf("Algarismos: %d\n", algarismo);
    printf("Letras: %d\n", letra);
    printf("Linhas de texto: %d\n", linha_de_texto);
    printf("Espaços e tabs: %d\n", expaco_tab);
    printf("Outros: %d\n", outros);
    return 0;
}	