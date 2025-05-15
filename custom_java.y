/* custom_java.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char* msg);

// Temporary variable generator
char tempVarName[16];
int tempCount = 0;
char* newTemp() {
    sprintf(tempVarName, "t%d", tempCount++);
    return strdup(tempVarName);
}

// Label generator
char labelName[16];
int labelCount = 0;
char* newLabel() {
    sprintf(labelName, "L%d", labelCount++);
    return strdup(labelName);
}
%}

%union { int ival; char* id; char* tac; }

%token <id>    T_ID
%token <ival>  T_NUM
%token         T_CLASS T_PUBLIC T_STATIC T_VOID T_NUMBER T_BOOLEAN T_IF T_ELSE T_WHILE T_RETURN T_PRINT
%token         T_LPAREN T_RPAREN T_LBRACE T_RBRACE T_LBRACKET T_RBRACKET T_ASSIGN T_SEMICOLON T_COMMA
%token         T_PLUS T_MINUS T_MUL T_DIV T_LT T_GT T_LE T_GE T_EQ T_NEQ

%type  <tac>   expr
%start program

%left T_PLUS T_MINUS
%left T_MUL T_DIV
%nonassoc T_LT T_GT T_LE T_GE T_EQ T_NEQ

%%

program:
    T_CLASS T_ID T_LBRACE main_method T_RBRACE
;

main_method:
    T_PUBLIC T_STATIC T_VOID T_ID T_LPAREN param_list_opt T_RPAREN T_LBRACE statements_opt T_RBRACE
;

param_list_opt:
    T_NUMBER T_LBRACKET T_RBRACKET T_ID
  | /* empty */
;

statements_opt:
    statement_list
  | /* empty */
;

statement_list:
    statement
  | statement_list statement
;

statement:
    T_NUMBER T_ID T_SEMICOLON
  | T_NUMBER T_ID T_ASSIGN expr T_SEMICOLON          { printf("%s = %s\n", $2, $4); }
  | T_ID T_ASSIGN expr T_SEMICOLON                   { printf("%s = %s\n", $1, $3); }
  | T_PRINT expr T_SEMICOLON                         { printf("print %s\n", $2); }

  // IF-ELSE
  | T_IF T_LPAREN expr T_RPAREN T_LBRACE statements_opt T_RBRACE T_ELSE T_LBRACE statements_opt T_RBRACE {
        char* l_else = newLabel();
        char* l_end = newLabel();
        printf("ifFalse %s goto %s\n", $3, l_else);
        // Then block already printed
        printf("goto %s\n", l_end);
        printf("%s:\n", l_else);
        // Else block already printed
        printf("%s:\n", l_end);
    }

  // WHILE LOOP (during)
  | T_WHILE T_LPAREN expr T_RPAREN T_LBRACE statements_opt T_RBRACE {
        char* l_start = newLabel();
        char* l_end = newLabel();
        printf("%s:\n", l_start);
        printf("ifFalse %s goto %s\n", $3, l_end);
        // Body already printed
        printf("goto %s\n", l_start);
        printf("%s:\n", l_end);
    }

  // RETURN
  | T_RETURN expr T_SEMICOLON                         { printf("return %s\n", $2); }
;

expr:
    T_NUM                         { char buf[16]; sprintf(buf, "%d", $1); $$ = strdup(buf); }
  | T_ID                          { $$ = strdup($1); }
  | T_LPAREN expr T_RPAREN        { $$ = $2; }
  | expr T_PLUS expr              { char* t = newTemp(); printf("%s = %s + %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_MINUS expr             { char* t = newTemp(); printf("%s = %s - %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_MUL expr               { char* t = newTemp(); printf("%s = %s * %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_DIV expr               { char* t = newTemp(); printf("%s = %s / %s\n", t, $1, $3); $$ = strdup(t); }

  // Relational Operators
  | expr T_LT expr                { char* t = newTemp(); printf("%s = %s < %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_GT expr                { char* t = newTemp(); printf("%s = %s > %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_LE expr                { char* t = newTemp(); printf("%s = %s <= %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_GE expr                { char* t = newTemp(); printf("%s = %s >= %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_EQ expr                { char* t = newTemp(); printf("%s = %s == %s\n", t, $1, $3); $$ = strdup(t); }
  | expr T_NEQ expr               { char* t = newTemp(); printf("%s = %s != %s\n", t, $1, $3); $$ = strdup(t); }
;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "Syntax Error: %s\n", msg);
}

int main() {
    return yyparse();
}
