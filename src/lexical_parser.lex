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
#include <time.h>

#include "globals.h"

int lineno = 1;
char *current_line = NULL;

bool line_cmt = false;
bool blk_cmt = false;

bool error = false;
int errorCount = 0;

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

"if"			{ return (!line_cmt && !blk_cmt) ? IF : COMMENT; }
"else"			{ return (!line_cmt && !blk_cmt) ? ELSE : COMMENT; }
"while"			{ return (!line_cmt && !blk_cmt) ? WHILE : COMMENT; }
"return"		{ return (!line_cmt && !blk_cmt) ? RETURN : COMMENT; }
"input"			{ return (!line_cmt && !blk_cmt) ? INPUT : COMMENT; }
"output"		{ return (!line_cmt && !blk_cmt) ? OUTPUT : COMMENT; }
"int"			{ return (!line_cmt && !blk_cmt) ? TYPE_INT : COMMENT; }
"void"			{ return (!line_cmt && !blk_cmt) ? TYPE_VOID : COMMENT; }
"+"				{ return (!line_cmt && !blk_cmt) ? PLUS : COMMENT; }
"-"				{ return (!line_cmt && !blk_cmt) ? MINUS : COMMENT; }
"*"				{ return (!line_cmt && !blk_cmt) ? MULTIPLY : COMMENT; }
"/"				{ return (!line_cmt && !blk_cmt) ? DIVIDE : COMMENT; }
">"				{ return (!line_cmt && !blk_cmt) ? GREATER : COMMENT; }
"<"				{ return (!line_cmt && !blk_cmt) ? LESSER : COMMENT; }
">="			{ return (!line_cmt && !blk_cmt) ? GREATER_EQUAL : COMMENT; }
"<="			{ return (!line_cmt && !blk_cmt) ? LESSER_EQUAL : COMMENT; }
"=="			{ return (!line_cmt && !blk_cmt) ? EQUALS : COMMENT; }
"!="			{ return (!line_cmt && !blk_cmt) ? DIFFERENT : COMMENT; }
"="				{ return (!line_cmt && !blk_cmt) ? ASSIGN : COMMENT; }
","				{ return (!line_cmt && !blk_cmt) ? COMMA : COMMENT; }
";"				{ return (!line_cmt && !blk_cmt) ? SEMICOLON : COMMENT; }
"\\"			{ return (!line_cmt && !blk_cmt) ? BACKSLASH : COMMENT; }
"["				{ return (!line_cmt && !blk_cmt) ? L_SQUARE_BRACKET : COMMENT; }
"]"				{ return (!line_cmt && !blk_cmt) ? R_SQUARE_BRACKET : COMMENT; }
"{"				{ return (!line_cmt && !blk_cmt) ? L_CURLY_BRACKET : COMMENT; }
"}"				{ return (!line_cmt && !blk_cmt) ? R_CURLY_BRACKET : COMMENT; }
"("				{ return (!line_cmt && !blk_cmt) ? L_PARENS : COMMENT; }
")"				{ return (!line_cmt && !blk_cmt) ? R_PARENS : COMMENT; }

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

{whitespace}	{ 
					line_cmt = false; 
					return WHITESPACE;
				}

{newline}		{ 
					current_line[0] = '\0'; // Clear current line
					lineno++; 
					return NEWLINE;
				}

{integer}		{ return (!line_cmt && !blk_cmt) ? INTEGER : COMMENT; }
{real}			{ return (!line_cmt && !blk_cmt) ? REAL : COMMENT; }
{hex}			{ return (!line_cmt && !blk_cmt) ? HEXADECIMAL : COMMENT; }
{id}			{ return (!line_cmt && !blk_cmt) ? ID : COMMENT; }
<<EOF>>			{ return LEX_EOF; }
.				{ 
					if(line_cmt || blk_cmt) return COMMENT;
					
					int i = strlen(current_line);
					while((current_line[i++] = input()) != '\n');
					current_line[i] = '\0';
					
					return ERROR;
				}

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

	if(token != ERROR) strcat(current_line, yytext);
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

  	clock_t clocks = clock();
  	char *token_str = (char *) malloc(sizeof(char)*MAX_TOKEN_LEN);
  	current_line = (char *) malloc(sizeof(char)*MAX_LINE_LEN);
  	current_line[0] = '\0'; // Safety
  	Token token_type;

  	SetupLex(fp, stdout);

  	// Load source code to memory
  	bool finished = false;
  	while(!finished){
		token_type = GetToken(token_str);
		switch(token_type){
		
		case ID: break;
		case INTEGER: break;
		case REAL: break;
		case HEXADECIMAL: break;
		case IF: break;
		case ELSE: break;
		case WHILE: break;
		case RETURN: break;
		case INPUT: break;
		case OUTPUT: break;
		case TYPE_INT: break;
		case TYPE_VOID: break;
		case NEWLINE: break;
		case WHITESPACE: break;
		case PLUS: break;
		case MINUS: break;
		case MULTIPLY: break;
		case DIVIDE: break;
		case GREATER: break;
		case LESSER: break;
		case GREATER_EQUAL: break;
		case LESSER_EQUAL: break;
		case EQUALS: break;
		case DIFFERENT: break;
		case ASSIGN: break;
		case COMMA: break;
		case SEMICOLON: break;
		case BACKSLASH: break;
		case L_SQUARE_BRACKET: break;
		case R_SQUARE_BRACKET: break;
		case L_CURLY_BRACKET: break;
		case R_CURLY_BRACKET: break;
		case L_PARENS: break;
		case R_PARENS: break;
		case COMMENT: break;
		case SINGLE_LINE_COMMENT: break;
		case L_MULTI_LINE_COMMENT: break;
		case R_MULTI_LINE_COMMENT: break;

		case LEX_EOF:
			finished = true;
			break;

		case ERROR:
			fprintf(stderr, ANSI_red "Error" ANSI_reset " (line %d): %s", lineno, current_line);
			error = true;
			errorCount++;
			break;
		}
  	}

  	if(error){
  		printf("%d errors found.\n", errorCount);
  	} else {
  		double time = (double) (clock() - clocks)/CLOCKS_PER_SEC;
  		printf("Compilation successful in %lf seconds.\n", time);
  	}

	free(token_str);
	free(current_line);
	fclose(fp);

	yyterminate();

	return 0;
}