/*M
.SH NAME
errmsgio - error message, I/O-operations

.SH SYNOPSIS
.nf
#include<_list.h>

errmsgio(name, errno)  
char *name, *errno;
  
.SH DESCRIPTION
.TP 4
.B name
is the name of a defective function.
.TP 4
.B errno
is a string of at most 7 characters, containg an error number from the file errmsg.
.PP
errmsgio writes the corresponding error message to stderr.

M*/
        
/*H
	Version 1       26.02.1987      R. Boeffgen
	Version 2       23.03.1987      Name geaendert.  RB
	Version 3       13.01.1988      "#undef fgets" eingefuegt.  BW
	Version 4       26.09.1991      fuer MX-Rechner Variable SM_HOME
					eingefuehrt.  PS
	Version 5       13.12.1991      SM_HOME aus Datei site.h fuer SUN
					und Apollo; 100 (statt 50) Zeichen
					fuer Dateinamen.  PS
	Version 6	14.12.1991	site.h fuer alle Rechner.  PS
	Version 7	14.11.1994	'#include <SITE.H>' entfernt, da
					SM_HOME jetzt in CONFIG.H definiert
					ist.  MP
   DATE errmsgio      : 890501.910930.911215.941201.9512__
H*/

# include <_list.h>
# undef fgets
# undef fprintf
	
void errmsgio ( name, errno )
char *name, *errno;
{
	extern char *fgets();
	extern FILE *fopen();
	FILE *pf;
	char *t, *file, *calloc(), *strcat();
	static char str[BUFSIZ];
	single len = strlen( errno );

/* Eroeffne errmsg-Datei im Verzeichnis SM_HOME */
	file = calloc(100,sizeof(char)), *file = '\0';
	file = strcat(strcat(file,SM_HOME),"/errmsg");
	if ( ( pf = fopen(file,"r") ) == NULL )  {
	    fprintf( stderr, "\n*** Fehler in \"errmsgio(\"%s\",\"%s\")\":", name, errno );
	    fprintf( stderr, "Datei \"%s\" nicht vorhanden\n",file);
	    return;
	}

/* Suche Fehlernummer und schreibe Fehlermeldung */
	while ( (t = fgets(str,BUFSIZ,pf))  &&  strncmp( str,errno,len ) );
	if (t)  fprintf( stderr, "\n*** %s: Fehler Nr. %s; %s", name,errno,str+8 );
	else    fprintf( stderr, "\n*** Fehler in \"errmsgio(\"%s\",\"%s\")\": Fehlernummer unbekannt\n", name, errno );

/* Schliesse errmsg-Datei */
	fclose( pf );
}
