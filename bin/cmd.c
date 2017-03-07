#include <stdio.h>
#include <ctype.h>
#include <string.h>

#ifndef TRUE
#define TRUE		(0==0)
#endif
#ifndef FALSE
#define FALSE		(1==0)
#endif

enum {PLAIN, DO_SYNOPSIS, DO_ITEMS, DO_NAME, MAN_VERB, TEX_VERB} MODE;
enum {TEX, MAN, KEY, ASC} OUT;

int HEADER    = FALSE;
int NO_FORMAT = FALSE;

char INDENT[5];
char LINE[200];
char NAME[20];
char SHORT[1000];
char ARGS[100];
char *SRClib;
char DATE[50];
char version_nr[20];


char *MONTH[] = {
	"JANUARY",	"FERRUARY",	"MARCH",	"APRIL",
	"MAY",		"JUNE",		"JULY",		"AUGUST",
	"SEPTEMBER",	"OCTOBER",	"NOVEMBER",	"DECEMBER"
	};

#define rd_dig(n)		10*(argv[3][n] - '0') + argv[3][n+1] - '0'

#define delchar(s)		strcpy (s,s+1)

#define del_first_spaces(s)	while (isspace(*s))	delchar (s)


main(argc,argv)
int argc;
char *argv[];
 {
 char c,Macro[20], *libname, hlp[10];
 int MACRO = 0;
 int i;
 int Indent, OldMode;
 int day,month,year;

 if (strcmp (argv[1], "TEX") == 0)	OUT = TEX;
 if (strcmp (argv[1], "MAN") == 0)	OUT = MAN;
 if (strcmp (argv[1], "KEY") == 0)	OUT = KEY;
 if (strcmp (argv[1], "ASC") == 0)	OUT = ASC;

 SRClib = argv[2];

 if (argv[3][0] == ' ') argv[3]++;

 month = rd_dig (2);
 year  = rd_dig (0);
 day   = rd_dig (4);

 if (month < 1 || month > 12 || year < 0 || year > 99) *DATE = '\0';
 else	if (day < 1 || day > 31)
		sprintf (DATE,"%s %d",MONTH[month-1],year);
	else
		sprintf (DATE,"%d %s %d",day,MONTH[month-1],year);

 sprintf (version_nr,"%s",argv[4]);

 MODE = PLAIN;

 *ARGS = '\0';

 while (1) {

	nextline();

	HAVE_LINE:

	switch (MODE) {
	
	case MAN_VERB:	if (*LINE == '.') if (*(LINE+1) == '}') break;
			if (OUT != TEX)	printf ("%s\n",LINE);
			continue;

	case TEX_VERB:	if (*LINE == '.') if (*(LINE+1) == ']') break;
			if (OUT == TEX)	printf ("%s\n",LINE);
			continue;
		}

	if (NO_FORMAT) {
		if (OUT != KEY)		printf ("%s\n",LINE);
		NO_FORMAT = FALSE;
		continue;
		}      

	if (*LINE != '.') {
		if (OUT == TEX)	if (MODE == DO_SYNOPSIS) {
			printf ("\\\\");
			if (*LINE == '\0') printf ("\\mbox{ } ");
			}
		if (OUT != KEY)		printf ("%s\n",LINE);

		continue;
		}

	c = *(LINE+1);

	switch (c) {

	case '#':
		break;
	case '[':
		OldMode = MODE;
		MODE    = TEX_VERB;
		nextline();
		goto HAVE_LINE;
		
	case ']':
		MODE = OldMode;
		nextline();
		goto HAVE_LINE;		

	case '{':
		OldMode = MODE;
		MODE    = MAN_VERB;
		if (OUT == MAN)		printf (".nf\n");
		nextline();
		goto HAVE_LINE;
		
	case '}':
		MODE = OldMode;
		if (OUT == MAN)		printf (".SH\n");
		nextline();
		goto HAVE_LINE;		

	default:
		if (MODE == DO_SYNOPSIS) 	MODE = PLAIN;

		if (MODE == DO_ITEMS)
		if (c != 'I' && c != '%' && c != '\"') {
			if (OUT == TEX)			printf ("\\end{description}\n");
			if (OUT == MAN)			printf (".LP\n");
			MODE = PLAIN;
			goto HAVE_LINE;
			}
		}

	switch (c) {

	case 'A':
		nextline();
		strcpy (ARGS,LINE);
		clear_spaces (ARGS);
		if (OUT == KEY)	format_line (ARGS);
		break;

	case 'M':
		MACRO = 1;
		break;

	case 'N':
		nextline();
		nextword (NAME,LINE);
		break;

	case '#':
		switch (*(LINE + 2)) {
		case 'a': libname = "_arith";	break;
		case 'm': libname = "_matr";	break;
		case 'e': libname = "_ec";	break;
		case 'p': libname = "_pol";	break;
		case 'l': libname = "_list";	break;
		case 'C': libname = "C_sm";	break;
		case 'k': libname = "kern";	break;
		default : nextline();
			  goto HAVE_LINE;
			  }
		
		c = *(LINE + 3);
		*hlp = c;
		*(hlp+1) = '\0';

		if (OUT != KEY)	sprintf (LINE,"#include <%s%s.h>",libname,
			(isdigit (c)) ? hlp : "");

		goto HAVE_LINE;

	case 'S':
		switch (*(LINE + 2)) {
		case 'S':	strcpy (LINE,"SYNOPSIS");	break;		
		case 'P':	strcpy (LINE,"PRELIMINARIES");	break;		
		default :	nextline();
			}
		MODE = DO_SYNOPSIS;
		if (OUT == TEX)			printf ("\n\\PARAGRAPH{ %s}\n",LINE);
		if (OUT == MAN) 		printf ("\n.SH %s\n.nf\n",LINE);
		if (OUT == ASC)			{
						del_first_spaces (LINE);
						printf ("\n%s\n",LINE);
						}
		break;

	case 'I':
		if (MODE != DO_ITEMS) {
			nextword (NAME,LINE+2);
			if ((Indent = atoi(NAME)) != 0)	strcpy (INDENT,NAME);
			else			*INDENT = '\0';

			if (Indent < 8) Indent = 8;
			Indent = 1.3 * (double) Indent;
			if (OUT == TEX)	{	
				printf ("\n\\leftmarginii%dex\n",Indent);
				printf ("\\begin{description}\n");
				}
			if (OUT == ASC)	printf ("\n");
			}

		nextline();
		
		if (MODE == DO_ITEMS)
		if (*LINE == '\0') {
			if (OUT == TEX)		printf ("\\end{description}\n");
			if (OUT == MAN)		printf (".LP\n");
			if (OUT == ASC)		printf ("\n");
			MODE = PLAIN;
			break;
			}

		if (OUT == TEX)			printf ("\\ITEMA{%d}{%s}\n",Indent-2,LINE);
		if (OUT == ASC)			printf ("%s\n",LINE);
		if (OUT == MAN) {		printf ("\n.TP %s\n\\fB%s\\fR\n",INDENT,LINE);
						*INDENT = '\0';
						}
		MODE = DO_ITEMS;

		break;

	case 'P':
		switch (*(LINE + 2)) {
		case 'D':	strcpy (LINE,"DESCRIPTION");	break;		
		case 'A':	strcpy (LINE,"SEE ALSO");	break;		
		default :	nextline();
			}
		if (OUT == MAN)			printf ("\n.SH %s\n",LINE);
		if (OUT == TEX)			printf ("\\PARAGRAPH{ %s}\\\\\n",LINE);
		if (OUT == ASC)			{
						del_first_spaces (LINE);
						printf ("\n%s\n",LINE);
						}
		break;

	case 'D':
		nextline();
		strcpy (SHORT,LINE);
		strcat (SHORT," ");
		while ((nextline(),*LINE) != '.') {
			strcat (SHORT,LINE);
			strcat (SHORT," ");
			}
		clear_spaces (SHORT);
		del_first_spaces (SHORT);

		strcpy (Macro,(MACRO == 1) ? ((OUT == KEY) ? "(MACRO)" : "MACRO") : "");

		HEADER = TRUE;

		switch (OUT) {
		case TEX:
			printf ("\\markright{{\\rm SIMATH release %s \\hfill Last change: %s \\hfill}}\n",version_nr,DATE);
			printf ("%s(%s) \\hfill SIMATH manual page %s \\hfill %s(%s)\n",NAME,Macro,SRClib,NAME,Macro);
			printf ("\\begin{description}\n");
			printf ("\\NAME{%s}\n",NAME);
			if (MACRO == 1)		printf ("\\MACRO\n");
			printf ("\\SHORT{ %s }\n",SHORT);
			break;

		case KEY:
			printf ("%s\t%s\t%s\t\"%s\"\n",NAME,ARGS,Macro,SHORT);
			finish();

		case ASC:
			printf ("\n\nSIMATH release %s      last change: %s\n\n",version_nr,DATE);
			printf ("SIMATH srclib.%s:\n\n",SRClib);
			printf ("%s (%s) - %s\n", NAME, Macro, SHORT);
			break;

		case MAN:
			printf (".TH %s \"%s\" \"%s\" \"SIMATH %s \" \"SIMATH manual page %s\"\n",
				NAME, Macro, DATE, version_nr,SRClib);
			printf ("\n.SH NAME\n");
			printf ("%s \\- %s\n",NAME,SHORT);
			break;
			}

		goto HAVE_LINE;


	default:;
		}
	
	}

 }  




format_line (str)
char *str;
 {
 char *S,*s;

 switch (OUT) {
	case ASC:
		for (s = str; *s != '\0'; s++)
			switch (*s) {
			case '\\':
			case '@':
			case '$':
				insert (&s,"",1);
				break;
			case '\t':
				insert (&s,"        ",1);
				break;
				}				
		break;

	case KEY:
		for (s = str; *s != '\0'; s++)
			switch (*s) {
			case '\\':
			case '$':
			case '\t':
				insert (&s,"",1);
				break;
				}				

		if (str == ARGS) {
			for (s = str; *s != '\0'; s++)
				switch (*s) {
				case '\\':
				case '$':
				case '\t':
				case ' ':
					insert (&s,"",1);
					break;
					}			
			for (s = str; *s != '\0'; s++)
				switch (*s) {
				case ']':
				case ',':
					s++;
					insert (&s," ",0);
					s--;
					break;
					}
			}


		break;

	case TEX:
		if (*str == '.') {
			if (*(str+1) == '%') {
				*str = '\0';
				break;
				}
			if (*(str+1)	== '\"') {
				strcpy (str,str+2);
				del_first_spaces (str);
				NO_FORMAT = TRUE;
				}
			}			

		for (s = str; *s != '\0'; s++) {
			switch (*s) {

			case '@':
				for (S = s; ; S++) switch (*S) {
					case '\0':
					case '(' :
					case ' ' :
					case ',' :
					case ';' :
					case '\n':
					case '\t':
					case '/' : goto _break_1;
					}
						
_break_1:;
				insert (&S,"}",0);
				insert (&s,"\\nset{",1);
				break;

			case '<': if (*(s+1) == '=') insert (&s,"\\le ",2); break;
			case '>': if (*(s+1) == '=') insert (&s,"\\ge ",2); break;
			case '!': if (*(s+1) == '=') insert (&s,"\\neq ",2);break;
				}
			}

		break;
	case MAN:
		if (*str == '.') {
			if (*(str+1) 	== '\"') {
				*str = '\0';
				return;
				}
			if (*(str+1)	== '%') {
				strcpy (str,str+2);
				NO_FORMAT = TRUE;
				return;
				}
			}			
  
		del_first_spaces (str);

		for (s = str; *s != '\0'; ) {
			switch (*s) {
			case '\\':
				if (*(s+1) == '.')	*(s+1) = '*';
				insert (&s,"",1);
				break;
			case '@':
				for (S = s; ; S++) switch (*S) {
					case '\0':
					case ',':
					case ';':
					case ' ':
					case '(':
					case '\n':
					case '\t':
					case '/' : goto _break_0;
					}
_break_0:;
				insert (&S,"\\fR",0);
				insert (&s,"\\fB",1);
				s = S;
				break;

			case '$':
				insert (&s,"",1);
				break;
				}				
			s++;
			}
		break;
			
	}
 }




insert (s,text,del)
char **s,*text;
 {
 char help[500];

 strcpy (help,(*s)+del);
 strcpy (*s,text);
 strcat (*s,help);
 *s += strlen (text) -1;
 }



finish()
 {
 if (MODE == DO_ITEMS)
 if (OUT  != KEY) {
	if (OUT == TEX)		printf ("\\end{description}\n");
	if (OUT == MAN)		printf (".LP\n");
	}

 if (HEADER)	if (OUT == TEX)		printf ("\\end{description}\n");
 
 while (getchar() != EOF);

 exit (0);
 }



clear_spaces (str)
char *str;
 {
 char *s;

 for (s = str; *s != '\0'; s++)
	if (isspace (*s)) *s = ' ';

 for (s = str; *s != '\0'; s++)
	if (*s == ' ')	if (*(s+1) == ' ')	strcpy (s,s+1), s--;

 if (*(s-1) == ' ') *(s-1) = '\0';

 return (0);
 }


nextword (N,str)
char	*N,*str;
 {
 while (isspace (*(str++)));
 str--;
 while (!isspace (*(N++) = *(str++)) && (*(str-1) != '\0'));
 *(N-1) = '\0';
 } 



nextline()
 {
 char *line;

 do	{
	line = LINE;

	while ((*(line++) = getchar()) != '\n') 
		if (*(line-1) == (char) EOF)
			finish ();

	*(line-1) = '\0';

	if (*LINE == '\0') break;

	if ((MODE != MAN_VERB) && (MODE != TEX_VERB))
		format_line (LINE);

	}
 while (*LINE == '\0');
 }

