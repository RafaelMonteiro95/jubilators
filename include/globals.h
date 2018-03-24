#ifndef _GLOBALS_H_
#define _GLOBALS_H_

#define MAX_TOKEN_LEN	(63)
#define MAX_LINE_LEN	(63000)

typedef enum {
	
	/* IDENTIFIER */
	ID,
	
	/* NUMBERS */
	INTEGER, REAL, HEXADECIMAL,

	/* RESERVED WORDS */
	IF, ELSE, WHILE, RETURN, INPUT, OUTPUT, 

	/* TYPES */
	TYPE_INT, TYPE_VOID,

	/* WHITESPACES */
	NEWLINE, WHITESPACE,

	/* OPERATORS */
	PLUS, MINUS, MULTIPLY, DIVIDE,
	
	/* COMPARISON OPERATORS */
	GREATER, LESSER, GREATER_EQUAL, LESSER_EQUAL, EQUALS, DIFFERENT, ASSIGN,
	
	/* PUNCTUATION */
	COMMA, SEMICOLON, BACKSLASH,
	L_SQUARE_BRACKET, 	R_SQUARE_BRACKET,
	L_CURLY_BRACKET,	R_CURLY_BRACKET,
	L_PARENS, 			R_PARENS,

	/* COMMENT */
	L_MULTI_LINE_COMMENT, R_MULTI_LINE_COMMENT,
	SINGLE_LINE_COMMENT, COMMENT,

	/* ERROR & EOF */
	LEX_EOF, ERROR
	
} Token;

typedef enum { false, true } bool;

/* Terminal colors */
#define ANSI_bg_darkgrey "\x1b[48;2;85;85;85m"

#define ANSI_bg_black "\x1b[48;5;0m"
#define ANSI_bg_red "\x1b[48;5;1m"
#define ANSI_bg_green "\x1b[48;5;2m"
#define ANSI_bg_yellow "\x1b[48;5;3m"
#define ANSI_bg_blue "\x1b[48;5;4m"
#define ANSI_bg_magenta "\x1b[48;5;5m"
#define ANSI_bg_cyan "\x1b[48;5;6m"
#define ANSI_bg_white "\x1b[48;5;7m"

#define ANSI_bg_bold_black "\x1b[48;5;8m"
#define ANSI_bg_bold_red "\x1b[48;5;9m"
#define ANSI_bg_bold_green "\x1b[48;5;10m"
#define ANSI_bg_bold_yellow "\x1b[48;5;11m"
#define ANSI_bg_bold_blue "\x1b[48;5;12m"
#define ANSI_bg_bold_magenta "\x1b[48;5;13m"
#define ANSI_bg_bold_cyan "\x1b[48;5;14m"
#define ANSI_bg_bold_white "\x1b[48;5;15m"

#define ANSI_black "\x1b[30m"
#define ANSI_red "\x1b[31m"
#define ANSI_green "\x1b[32m"
#define ANSI_yellow "\x1b[33m"
#define ANSI_blue "\x1b[34m"
#define ANSI_magenta "\x1b[35m"
#define ANSI_cyan "\x1b[36m"
#define ANSI_white "\x1b[37m"

#define ANSI_bold_black "\x1b[30;1m"
#define ANSI_bold_red "\x1b[31;1m"
#define ANSI_bold_green "\x1b[32;1m"
#define ANSI_bold_yellow "\x1b[33;1m"
#define ANSI_bold_blue "\x1b[34;1m"
#define ANSI_bold_magenta "\x1b[35;1m"
#define ANSI_bold_cyan "\x1b[36;1m"
#define ANSI_bold_white "\x1b[37;1m"

#define ANSI_reset "\x1b[0m"

#endif