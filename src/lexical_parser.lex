/*
 *	Analisador léxico - trabalho 1 SCC0217 Linguagens de Programação e 
 *	Compiladores
 *	Prof. Adinovam Henriques de Macedo Pimenta
 *
 *	Lucas Alexandre Soares		9293265
 *	Giovanna Oliveira Guimarães 9293693
 *	Rafael Augusto Monteiro		9293095
 *
 */


%{ /* C code header*/

#include <stdio.h>
#include <stdlib.h>

#include "globals.h"

int lineno = 1;
bool line_cmt = false;
bool blk_cmt = false;
char *current_line = NULL;
%} /* End C code header */

/* Definitions */

/* Base */
digit			[0-9]
alpha			[A-Za-z]
alnum			({alpha}|{digit})

/* Words and identifiers */
id				({alpha}+)
reserved		(if|else|while|return|input|output|int|void)
whitespace		([ \t])
newline			([\n]|\r\n)

/* Numbers */
/*integer		((\+|\-)?[0-9]+) */
/*real 			((\+|\-)?[0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+(\.[0-9]+)?)?f?) */
/*hex			(0[xX]([0-9]|[A-Fa-f])+) */
integer			((\+|\-)?{digit}+) 
real 			((\+|\-)?{digit}+(\.{digit}+)?(e(\+|\-)?{digit}+(\.{digit}+)?)?f?)
hex				(0[xX]({digit}|[A-Fa-f])+)

/* Operators and punctuation */
punctuation		(,|;|\\)
brackets		(\[|\]|\(|\)|\{|\})
binSymbol		(\+|\-|\*|\/|>|<|>=|<=|=|==|!=)

/* End Definitions */

%% /* Rules */

"if"			{ if(!line_cmt && ! blk_cmt) return IF; }
"else"			{ if(!line_cmt && ! blk_cmt) return ELSE; }
"while"			{ if(!line_cmt && ! blk_cmt) return WHILE; }
"return"		{ if(!line_cmt && ! blk_cmt) return RETURN; }
"input"			{ if(!line_cmt && ! blk_cmt) return INPUT; }
"output"		{ if(!line_cmt && ! blk_cmt) return OUTPUT; }
"int"			{ if(!line_cmt && ! blk_cmt) return TYPE_INT; }
"void"			{ if(!line_cmt && ! blk_cmt) return TYPE_VOID; }
"+"				{ if(!line_cmt && ! blk_cmt) return PLUS; }
"-"				{ if(!line_cmt && ! blk_cmt) return MINUS; }
"*"				{ if(!line_cmt && ! blk_cmt) return MULTIPLY; }
"/"				{ if(!line_cmt && ! blk_cmt) return DIVIDE; }
">"				{ if(!line_cmt && ! blk_cmt) return GREATER; }
"<"				{ if(!line_cmt && ! blk_cmt) return LESSER; }
">="			{ if(!line_cmt && ! blk_cmt) return GREATER_EQUAL; }
"<="			{ if(!line_cmt && ! blk_cmt) return LESSER_EQUAL; }
"=="			{ if(!line_cmt && ! blk_cmt) return EQUALS; }
"!="			{ if(!line_cmt && ! blk_cmt) return DIFFERENT; }
"="				{ if(!line_cmt && ! blk_cmt) return ASSIGN; }
","				{ if(!line_cmt && ! blk_cmt) return COMMA; }
";"				{ if(!line_cmt && ! blk_cmt) return SEMICOLON; }
"\\"			{ if(!line_cmt && ! blk_cmt) return BACKSLASH; }
"["				{ if(!line_cmt && ! blk_cmt) return L_SQUARE_BRACKET; }
"]"				{ if(!line_cmt && ! blk_cmt) return R_SQUARE_BRACKET; }
"{"				{ if(!line_cmt && ! blk_cmt) return L_CURLY_BRACKET; }
"}"				{ if(!line_cmt && ! blk_cmt) return R_CURLY_BRACKET; }
"("				{ if(!line_cmt && ! blk_cmt) return L_PARENS; }
")"				{ if(!line_cmt && ! blk_cmt) return R_PARENS; }

"//"			{ 
					line_cmt = true;
					return SINGLE_LINE_COMMENT; 
				}

"/*"			{ 
					blk_cmt = true;
					return L_MULTI_LINE_COMMENT; 
				}
"*/"			{ 
					blk_cmt = false;
					return R_MULTI_LINE_COMMENT; 
				}

{whitespace}	{ line_cmt = false; }
{newline}		{ 
					current_line[0] = '\0'; // Clear current line
					lineno++; 
				}

{integer}		{ if(!line_cmt && ! blk_cmt) return INTEGER; }
{real}			{ if(!line_cmt && ! blk_cmt) return REAL; }
{hex}			{ if(!line_cmt && ! blk_cmt) return HEXADECIMAL; }
{id}			{ if(!line_cmt && ! blk_cmt) return ID; }
<<EOF>>			{ return LEX_EOF; }
.				{ return ERROR; }

%% /* End Rules */

/* C code */

void usage(char *name){
	printf("Usage: %s [source code]\n", name);
}

void SetupLex(FILE *input, FILE *output){
	yyin = input;
	yyout = output;
}

/*
	Stores current token in str then returns which token was found.
	Max token length is MAX_TOKEN_LEN.
*/
Token GetToken(char *str){

	Token token = yylex();
	strcat(current_line, yytext);
	strncpy(str, yytext, MAX_TOKEN_LEN);
	return token;
}

int main(int argc, char *argv[]){
  
  	if(argc != 2){
		usage(argv[0]);
  		return 1;
  	}

  	// Open source code
  	FILE *fp = fopen(argv[1], "r");
  	if(fp == NULL){
  		fprintf(stderr, "File not found.\n");
  		usage(argv[0]);
  		return -1;
  	}

  	current_line = (char *) malloc(sizeof(char)*MAX_LINE_LEN);
  	current_line[0] = '\0'; // Safety
  	char *token_str = (char *) malloc(sizeof(char)*MAX_TOKEN_LEN);
  	Token token_type;

  	SetupLex(fp, stdout);

  	// Load source code to memory
  	bool finished = false;
  	while(!finished){
		token_type = GetToken(token_str);
		switch(token_type){
		
		case ID:
			break;
		
		case INTEGER:
			break;
		
		case REAL:
			break;
		
		case HEXADECIMAL:
			break;
		
		case IF:
			break;
		
		case ELSE:
			break;
		
		case WHILE:
			break;
		
		case RETURN:
			break;
		
		case INPUT:
			break;
		
		case OUTPUT:
			break;
		
		case TYPE_INT:
			break;
		
		case TYPE_VOID:
			break;
		
		case NEWLINE: break;	// Shouldnt happen
		case WHITESPACE: break;	// Shouldnt happen
		
		case PLUS:
			break;
		
		case MINUS:
			break;
		
		case MULTIPLY:
			break;
		
		case DIVIDE:
			break;
		
		case GREATER:
			break;
		
		case LESSER:
			break;
		
		case GREATER_EQUAL:
			break;
		
		case LESSER_EQUAL:
			break;
		
		case EQUALS:
			break;
		
		case DIFFERENT:
			break;
		
		case ASSIGN:
			break;
		
		case COMMA:
			break;
		
		case SEMICOLON:
			break;
		
		case BACKSLASH:
			break;
		
		case L_SQUARE_BRACKET:
			break;
		
		case R_SQUARE_BRACKET:
			break;
		
		case L_CURLY_BRACKET:
			break;
		
		case R_CURLY_BRACKET:
			break;
		
		case L_PARENS:
			break;
		
		case R_PARENS:
			break;

		case L_MULTI_LINE_COMMENT:
			break;
		
		case R_MULTI_LINE_COMMENT:
			break;

		case LEX_EOF:
			finished = true;
			yyterminate();
			break;

		case ERROR:
			fprintf(stderr, ANSI_red "Error" ANSI_reset " (line %d): %s\n", lineno, current_line);
			break;
		}
  	}

	free(token_str);
	free(current_line);
	fclose(fp);

	return 0;
}