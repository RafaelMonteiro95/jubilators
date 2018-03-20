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

/* Definitions */

digit		[0-9]
alpha		[A-Za-z]
alnum		({alpha}|{digit})
id			({alpha}+)
blank		([ \t\n])

/*integer	((\+|\-)?[0-9]+) */
integer		((\+|\-)?{digit}+) 

/*real 		((\+|\-)?[0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+(\.[0-9]+)?)?f?) */
real 		((\+|\-)?{digit}+(\.{digit}+)?(e(\+|\-)?{digit}+(\.{digit}+)?)?f?)

/*hex		(0[xX]([0-9]|[A-Fa-f])+) */
hex			(0[xX]({digit}|[A-Fa-f])+)

/* End Definitions */

%% /* Rules */

digit		{ printf("digit found!"); }
alpha		{ printf("alpha found!"); }
alnum		{ printf("alnum found!"); }
id			{ printf("id found!"); }
blank		{ printf("blank found!"); }
integer		{ printf("integer found!"); }
real		{ printf("real found!"); }
hex			{ printf("hex found!"); }

%% /* End Rules */

/* C code */

int main(){
  
	printf("Give me your input:\n");
	yylex();
}