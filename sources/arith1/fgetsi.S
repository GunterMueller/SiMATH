/*M
.SH NAME
fgetsi - file get single

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fgetsi(pf)
FILE *pf;

.SH DESCRIPTION
fgetsi() returns the single integer value read from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      16.03.1987      R.Boeffgen
   DATE fgetsi        : 890501
H*/


# include <_arith1.h>

single fgetsi ( pf )
FILE *pf;
{
	single  n, s=1, c=fgetcs(pf);
	if ( c == '+' || c == '-' )
	      { s = (c=='+') ? 1 : -1;
		c = fgetcs( pf );
	      }
	if ( !isdigit(c) )  {
		errmsgio( "fgetsi", "EA007" );
		return( ERROR );
	}
	for ( n = 0 ; isdigit(c) ; c = getc(pf) )  {
		n = 10 * n + c - '0';
		if ( n >= BASIS )  {
			errmsgio( "fgetsi", "EA007" );
			return( ERROR );
		}
	}
	n *= s;
	if ( c != (-1) ) ungetc( c,pf );
	return( n );
}
