/* custom_java.l */
%{
#include "custom_java.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

digit   [0-9]
letter  [a-zA-Z_]

%%
"number"       { return T_NUMBER; }
"logic"        { return T_BOOLEAN; }
"when"         { return T_IF; }
"otherwise"    { return T_ELSE; }
"during"       { return T_WHILE; }
"giveback"     { return T_RETURN; }
"blueprint"    { return T_CLASS; }
"open"         { return T_PUBLIC; }
"static"       { return T_STATIC; }
"nothing"      { return T_VOID; }
"show"         { return T_PRINT; }

{digit}+        { yylval.ival = atoi(yytext); return T_NUM; }
[a-zA-Z_][a-zA-Z0-9_]*        { yylval.id = strdup(yytext); return T_ID; }


"+"            { return T_PLUS; }
"-"            { return T_MINUS; }
"*"            { return T_MUL; }
"/"            { return T_DIV; }

"("            { return T_LPAREN; }
")"            { return T_RPAREN; }
"{"            { return T_LBRACE; }
"}"            { return T_RBRACE; }
"["            { return T_LBRACKET; }
"]"            { return T_RBRACKET; }

"="            { return T_ASSIGN; }
";"            { return T_SEMICOLON; }
","            { return T_COMMA; }

"<="           { return T_LE; }
">="           { return T_GE; }
"<"            { return T_LT; }
">"            { return T_GT; }
"=="           { return T_EQ; }
"!="           { return T_NEQ; }

[ \t\r\n]+    { /* skip whitespace */ }
.               { /* skip any other character */ }

%%
int yywrap(void) { return 1; }
int yylex (void);