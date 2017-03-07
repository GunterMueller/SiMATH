#include <stdio.h>
#include <ctype.h>

#define readchar(c)	c = getchar ();\
			if (feof (stdin)) exit_error ("unexpected end of input");

#define LNAME	20
#define LARGS	100
#define LDESC	600

char name[LNAME]	= "";
char args[LARGS]	= "";
char desc[LDESC]	= "";
char c, *macro		= "";

main (argn, argc)
int  argn;
char *argc[];
 {
 if (argn != 2) {
	fprintf (stderr, "\n%s: wrong number of args\n", argc[0]);
	exit (2);
	}

 switch (*argc[1]) {
/*
 * M:
 *
 * doc style M is something like

.SH NAME
name_of_function \- short description with
searchable keywords
.\" (arg1, arg2, ... )
.\" MACRO

 */

 case 'M':
	read_until (".SH",'\0');
	read_until ("\n",'\0');
	read_name  (name,'-');
	read_desc  (desc,'.');
	read_until ("(",'\0');
	read_args  (args,')');
	read_until ("\n",'\0');
	if (read_until ("MACRO",'\n')) macro = "(MACRO)";
	break;

/* 
 * C:
 *
 * doc style C is something like

		name_of_function (arg1, arg2, ... ) (MACRO)

	"short description with searchable keywords"

 *
 */

 case 'C':
	read_name  (name,'(');
	read_args  (args,')');
	if (read_until ("MACRO",'\n')) macro = "(MACRO)";
	read_until ("\"",'\0');
	read_desc  (desc,'\"');
	break;
 default:
	fprintf (stderr, "\n%s: docstyle '%c' not implemented\n",
		argc[0], *argc[1]);
	exit (2);
	}

 printf ("%s\t(%s)\t%s\t\"%s\"\n", name, args, macro, desc);
 }

/*
 * read_name() reads alphanumerics in s[] and stops if char end occurs
 */ 

read_name (s,end)
char *s,end;
 {
 int i = 0;

 do	{
	readchar (c);
	if (isalnum (c) || (c == '_')) *(s++) = c, i++;
	if (i == LNAME) exit_error ("name too long");
	}
 while (c != end);
 *s = '\0';
 }

/*
 * read desc() reads chars in s[]. Each sequence of spaces (blanc, TAB, CR, LF,...)
 * is replaced by exactly one blanc. It stops if char end occurs.
 */

read_desc (s,end)
char *s,end;
 {
 int spc_cnt = 1;
 int i = 0;

 while (1) {
	readchar (c);
	if (c == end) break;
	if (isspace (c))
		if (spc_cnt)	continue;
		else		c = ' ', spc_cnt = 1;
	else spc_cnt = 0;
	*(s++) = c, i++;
	if (i == LDESC) exit_error ("short descripton too long");
	}
 do 	*(s--) = '\0';
 while	(isspace (*s));
 }

/*
 * read_args() reads chars in s[]. Spaces are ignored. A blanc is forced
 * after each ',' and before each '['. It stops if char end occurs.
 */

read_args (s,end)
char *s,end;
 {
 int i = 0;

 while (1) {
	readchar (c);
	if (c == end) break;
	if (isspace (c)) continue;
	if (c == '[') *(s++) = ' ', i++;
	*(s++) = c, i++;
	if (c == ',') *(s++) = ' ', i++;
	if (i >= LARGS) exit_error ("argument list too long");
	}
 *s = '\0';
 }

/*
 * read_until() reads from stdin until the string str[] or the char end occurs.
 * str[] : return 1
 * end   : return 0
 * It prints an error message if EOF is detected.
 */

read_until (str,end)
char str[],end;
 {
 char *s;

 for (s = str; *s != '\0'; ) {
	readchar (c);
	if (c == end)	return (0);
	if (c == *s)	s++;
	else		s = str;
	}
 return (1);
 }

exit_error (msg)
char msg[];
 {
 fprintf (stderr, "*** bad doc style: %s ***\n",msg);
 exit (1);
 }
