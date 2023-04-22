%{
  #include"exemplo.tab.h" /* header gerado pelo bison */
  extern int numErros;    /* variável criado no bison */
%}

%option noyywrap
%option nounput
%option noinput
%option case-insensitive

%%

[0-9]+           yylval.inteiro=atoi(yytext);return INT;
[0-9]*\.[0-9]+   yylval.real=atof(yytext);return FLOAT;
,                return yytext[0];
[ \t]            /* ignorado */
.               {
                 printf("Erro lexico: simbolo desconhecido %s\n",yytext);
                 numErros++;
                }
\n               return 0; /* tratar \n como final de input */
<<EOF>>          return 0;

%%
