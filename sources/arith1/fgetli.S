/*M
.SH NAME
fgetli - file get list of integers

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgetli(pf)
FILE *pf;

.SH DESCRIPTION
fgetli() returns a list of integers read in from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      22.04.1987      R.Boeffgen
   DATE fgetli        : 890501
H*/


# include <_arith1.h>

list fgetli ( pf )
FILE *pf;
{
	list L = _0;
	int M;
   /***    Listenanfang einlesen    ***/
	single c = fgetcs(pf);
	if  ( c != '(' )  {
		errmsgio( "fgetli", "EA003" );
		return( ERROR );
	}
	bind( L );
   /***    erstes Zeichen einlesen    ***/
	c = fgetcs(pf);
	while ( c != ')' )  {
   /***    ganze Zahl einlesen    ***/
		if ( c=='+' || c=='-' || isdigit(c) )  {
			ungetc(c,pf);
			M = fgeti( pf );
		}
		else  M = ERROR;
   /***    ggf. Fehlermeldung    ***/
		if ( M == ERROR )  {
			errmsgio( "fgetli", "EA005" );
			return( ERROR );
		}
   /***    Liste erweitern und naechstes Zeichen einlesen    ***/
		L = lcomp(M,L);
		if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
	}
   /***    Ergebnisliste    ***/
	return( linv(L) );
}
