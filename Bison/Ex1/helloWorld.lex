%{
#include "helloWorld.tab.h"
%}

%option caseless 

%%
"Hello"[ \t\r]*"World" { yylval = 1; return HW; }
. { /* ignore */ }
\n { /* ignore newlines */ }
%%

int yywrap(void) {
    return 1;
}