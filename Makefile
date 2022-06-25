all: uconv
VERSION=0.0.3
NAME=uconv
APPNAME=$(NAME)
PREFIX=/usr
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man/man1

MYCFLAGS=-O2 -Wall -Wextra -Werror -DVERSION=\"$(VERSION)\" -DNAME=\"$(NAME)\" $(CFLAGS)
MYLDFLAGS=$(LDFLAGS)

uconv: uconv.o units.o
#	$(CC) -s -o uconv uconv.o units.o -lm
	$(CC) $(MYLDFLAGS) -s -o uconv uconv.o units.o -lm

uconv.o: uconv.c units.h
	$(CC) $(MYCFLAGS) -g -o uconv.o -c uconv.c

units.o: units.c units.h
	$(CC) $(MYCFLAGS) -g -o units.o -c units.c

clean:
	rm -f *.o *.stackdump uconv uconv.man.html

install: all
	mkdir -p $(DESTDIR)/$(MANDIR)
	mkdir -p $(DESTDIR)/$(BINDIR)
	cp -p man1/uconv.1 $(DESTDIR)/$(MANDIR)
	cp -p uconv $(DESTDIR)/$(BINDIR)

doc:
	perl makeman.pl > uconv.man.html
