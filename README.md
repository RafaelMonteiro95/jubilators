# Building

You can just call `make` from command line to build everything or `make lex_compile` to generate just the flex C code and then `make c_compile` to generate the executable.

# Running

Call `make run` or add `gcc-` to your PATH. gcc- require a source file path.
`Usage: gcc- [filename]`

The program generates a file with all found tokens and shall print any errors, if encountered.