CC=gcc
PGMS=read
SRC=read.c
all: $(PGMS)
$(PGMS): $(SRC)
	$(CC) $< -o $@ -g

.PHONY: clean
clean:
	rm -rf $(PGMS) $(wildcard *.o)
