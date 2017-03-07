/*M
.SH NAME
fgeta - file get atom

.SH SYNOPSIS
.nf
#include<_list.h>

atom fgeta( pf )  
FILE *pf;
   
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
fgeta reads an atom from the file *pf and returns it. In case of an error, fgeta returns ERROR.

M*/
              
/*H
	Version  1      23.02.1987      R.Boeffgen
	Version  2      09.07.1987      "EA002" bei EOF.  RB
   DATE fgeta         : 890501
H*/


# include <_list.h>

atom fgeta ( pf )
FILE *pf;
{
	obj a;
	single  s = 1, c;
    /***    erstes signifikantes Zeichen    ***/
	if ( (c = fgetcs(pf)) == EOF )  {
		errmsgio( "fgeta", "EA002" );
		return( ERROR );
	}
    /***    Vorzeichen    ***/
	if ( c == '+' || c == '-' )  {
		s = (c=='+') ? 1 : -1;
		c = fgetcs( pf );
	}
    /***    erste Ziffer    ***/
	if ( !isdigit(c) )  {
		errmsgio( "fgeta", "EA001" );
		return( ERROR );
	}
    /***    weitere Ziffern    ***/
	for ( a = 0 ; isdigit(c) ; c = getc(pf) )  {
		a = 10 * a + c - '0';
		if ( a >= BASIS )  {
			errmsgio( "fgeta", "EA001" );
			return( ERROR );
		}
	}
    /***    Endergebnis    ***/
	a *= s;
	if ( c != (-1) ) ungetc( c,pf );
	return( a );
}
