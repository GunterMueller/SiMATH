include ../Makefile.flags

.SUFFIXES:

all: SM CCC cmd ExtractKeywords FormatKeywords \
	preV3_1.lex.c preV3_1.x preproc.lex.c preproc.x 

SM: SM.c
	$(CC) SM.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LDFLAGS) -o SM

CCC:CCC.c
	$(CC) CCC.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LDFLAGS) -o CCC

cmd:cmd.c
	$(CC) cmd.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LDFLAGS) -o cmd

ExtractKeywords:ExtractKeywords.c
	$(CC) ExtractKeywords.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LDFLAGS) -o ExtractKeywords

FormatKeywords:FormatKeywords.c
	$(CC) FormatKeywords.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LDFLAGS) -o FormatKeywords

preV3_1.lex.c: preV3_1.lex
	rm -f preV3_1.lex.c lex.yy.c
	fgrep -v '/*KOM' preV3_1.lex | $(LEX) ; \
	sed -e /stdlib.h/d lex.yy.c > preV3_1.lex.c

preproc.lex.c: preproc.lex
	rm -f preproc.lex.c lex.yy.c
	fgrep -v '/*KOM' preproc.lex | $(LEX) ; \
	sed -e /stdlib.h/d lex.yy.c > preproc.lex.c

preV3_1.x:preV3_1.x.c
	$(CC) preV3_1.x.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LEXLIB) $(LDFLAGS) -o preV3_1.x

preproc.x:preproc.x.c
	$(CC) preproc.x.c $(CPPFLAGS_BIN) $(CFLAGS_BIN) $(LEXLIB) $(LDFLAGS) -o preproc.x

clean:
	rm -f core	
	rm -f *.bak
	rm -f *.P
	rm -f *.S
	rm -f *.o
	rm -f *~
	rm -f SM CCC cmd ExtractKeywords FormatKeywords preV3_1.x preproc.x
