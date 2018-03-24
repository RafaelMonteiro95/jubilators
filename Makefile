# Simple makefile

NAME=gcc-

######################################################################
# If the first argument is "run"
ifeq (run, $(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif
######################################################################

LEX_SRC=$(wildcard src/*.lex) $(wildcard src/*.l)
C_SRC=$(wildcard src/*.c)
C_DEP=$(wildcard include/*.h)

CC=gcc
LEX_CC=flex

CFLAGS=-O3 -lfl -g
LEXFLAGS=

# C- things
CMINUS_SRC=$(wildcard c-/*.c-)
CMINUS_BUILD=c-_build

all: lex_compile c_compile
	
lex_compile:
	$(LEX_CC) -o src/$(NAME).yy.c $(LEX_SRC)

c_compile:
	$(CC) $(CFLAGS) $(C_SRC) -o $(NAME) -I./include

cminus_compile:
	@mkdir $(CMINUS_BUILD)
	./$(NAME) $(RUN_ARGS) -o $(CMINUS_BUILD)/$(NAME)

clean: 
	@-rm -f $(NAME)
	@-rm -f src/*.yy.c
	@-rm -rf $(CMINUS_BUILD)
	@-rm -rf vgcore.*
	@-rm -rf relatorio.txt

run:
	./$(NAME) $(RUN_ARGS)

zip: clean
	zip -r $(NAME).zip *
