default: booze.so

CC = gcc

DEFINES = _GNU_SOURCE

LIBFLAGS = -shared -lfuse3

CWARN = -Wall
COPT = -O0 -fPIC -fno-diagnostics-show-caret -I /usr/include/bash -I /usr/include/bash/builtins -I /usr/include/bash/include -I /usr/include/fuse3
ifneq ($(DEBUG),)
	CDEBUG = -ggdb3
else
	CDEBUG =
endif

CDEFINES = $(foreach d,$(DEFINES),-D$(d))

CFLAGS = $(CWARN) $(COPT) $(CDEFINES) $(CDEBUG)

EXTRAFLAGS = $(shell pkg-config --cflags --libs fuse bash)



booze.o: booze.c
	$(CC) -c $(CFLAGS) -o $@ $<

booze.so: booze.o
	$(CC) $< $(LIBFLAGS) -o $@

.PHONY: clean
clean:
	rm -f booze.o booze.so
