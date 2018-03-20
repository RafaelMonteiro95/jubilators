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

int lineno = 1;

%} /* End C code header */

/* Definitions */

/* Base */
digit		[0-9]
alpha		[A-Za-z]
alnum		({alpha}|{digit})

/* Words and identifiers */
id			({alpha}+)
reserved	(if|else|while|return|input|output|int|void)
whitespace	([ \t])
newline		([\n]|\r\n)

/* Numbers */
/*integer	((\+|\-)?[0-9]+) */
/*real 		((\+|\-)?[0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+(\.[0-9]+)?)?f?) */
/*hex		(0[xX]([0-9]|[A-Fa-f])+) */
integer		((\+|\-)?{digit}+) 
real 		((\+|\-)?{digit}+(\.{digit}+)?(e(\+|\-)?{digit}+(\.{digit}+)?)?f?)
hex			(0[xX]({digit}|[A-Fa-f])+)

/* Operators and punctuation */
punctuation	(,|;|\\)
brackets	(\[|\]|\(|\)|\{|\})
binSymbol	(\+|\-|\*|\/|>|<|>=|<=|=|==)

/* End Definitions */

%% /* Rules */

{reserved}				{ printf("keyword found!\n"); }
({brackets}|{punctuation})	{ printf("punctuation found!\n"); }
{binSymbol}				{ printf("operator found!\n"); }

{digit}					{ printf("digit found!\n"); }
{alpha}					{ printf("alpha found!\n"); }
{alnum}					{ printf("alnum found!\n"); }

{id}					{ printf("id found!\n"); }
{integer}				{ printf("integer found!\n"); }
{real}					{ printf("real found!\n"); }
{hex}					{ printf("hex found!\n"); }
{whitespace}			{ /* Do nothing (consume whitespaces) */ }
{newline}				{ lineno++; }
.						{ /* Error */ printf("Error in line %d\n", lineno); }

%% /* End Rules */

/* C code */

int main(){
  
	printf("Give me your input:\n");
	yylex();
}