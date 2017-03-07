#include <stdio.h>

/*
 * This is used as a filter to format lines of the
 * file KEYWORDS. Every such line is of the form
name<TAB>(arg1,...)<TAB>[(MACRO)]<TAB>"short description"
 * the output will be
name (arg1,...)      [(MACRO)]
       "short description"

 * The command line argument indicates the number of
 * columns.
 */

main (argc,argv)
int argc;
char *argv[];
 {
 int num,tab_cnt = 0,cnt = 0;
 char c;

 num = (argc < 2) ? 80 : atoi (argv[1]);

 if (num < 10 || num > 1000) num = 80;

 num -= 8;						/* the 8 spaces below		*/

 while (1) {
	c = (char) getchar();
	if (feof (stdin)) break;
	if (c == '\t') {
		tab_cnt++;
		if (tab_cnt == 1) printf (" ");		/* a blank after name		*/
		if (tab_cnt == 2) printf ("       ");	/* some blanks after arg list	*/
		continue;
		}
	if (c == '\n')	{
	      cnt = tab_cnt = 0;			/* reset counters		*/
	      putchar ('\n'); 				/* extra new line after desc	*/
	      }
	if (tab_cnt == 3) {
		if (cnt == 0) printf ("\n        ");	/* 8 paces at beginning of each	*/
		cnt = (cnt+1) % num;			/* desc line			*/
		}	
	putchar (c);
	}
 }
