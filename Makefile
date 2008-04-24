CC = gcc
SOURCES = parse.c vm.c wspace.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS = -Wall

.SUFFIXES: .c .o .pl .def
all: deps wspace

clean:
	rm -f $(OBJECTS) wspace gencode.c
deps: $(SOURCES)
	gcc -MM $+ >deps

wspace: $(OBJECTS)
	gcc $(OBJECTS) $(CFLAGS) -o $@

gencode.c: parsegen.pl wsparse.def
	perl parsegen.pl wsparse.def >gencode.c

parse.o: parse.c gencode.c
include deps
