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

CC=gcc
LEX_CC=flex

CFLAGS=-O3 -lfl
LEXFLAGS=

# C- things
CMINUS_SRC=$(wildcard c-/*.c-)
CMINUS_BUILD=c-_build

all: clean lex_compile c_compile
	
lex_compile:
	$(LEX_CC) -o src/$(NAME).yy.c $(LEX_SRC) 

c_compile:
	$(CC) $(CFLAGS) $(C_SRC) -o $(NAME)

cminus_compile:
	@mkdir $(CMINUS_BUILD)
	./$(NAME) $(RUN_ARGS) -o $(CMINUS_BUILD)/$(NAME)

clean: 
	~rm -f $(NAME)
	~rm -rf $(CMINUS_BUILD)

run:
	./$(NAME) 

zip:
	zip -r $(NAME).zip *