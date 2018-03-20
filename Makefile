# Simple makefile

NAME=lexical_parser

LEX_SRC=$(wildcard src/*.lex) $(wildcard src/*.l)
C_SRC=$(wildcard src/*.c)

CC=gcc
LEX_CC=flex

CFLAGS=-O3 
LEXFLAGS=

all: lex_compile c_compile
	
lex_compile:
	$(LEX_CC) $(LEX_SRC)

c_compile:
	$(CC) $(CFLAGS) $(C_SRC) -o $(NAME)

clean:
	~rm -f build/*