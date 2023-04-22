#!/bin/bash

.DEFAULT_GOAL := all

# Set the name of the output file
TARGET := program


# Compiler settings
CC := gcc
CFLAGS :=

# Build the executable
program: lex.yy.c
	$(CC) $(CFLAGS) $< -o $(TARGET) -lfl

# Generate the C code from the Flex source file
lex.yy.c: 
	flex $(FLEX)

# Run the program
run: program
	./$(TARGET) < $(TXT)

# Clean up generated files
clean:
	rm -f $(TARGET) lex.yy.c .makefile.swp

# Ensure 'clean' is not a file.
.PHONY: clean

# Ensure 'run' is not a file.
.PHONY: run

all: run
.PHONY: all
