/*M
.SH NAME
sgetsi - string get single

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sgetsi(ps)
char **ps;

.SH DESCRIPTION
sgetsi()
returns the single integer value read from the string *ps,
or ERROR in case an error occurs.
On return, *ps points to the last character read.
M*/

/*H
	Version  1      16.06.1993     Marc Conrad
   DATE sgetsi        : 931130
H*/


# include <_arith1.h>

single sgetsi ( pf )
char **pf;
{
	single  n, s=1, c=sgetcs(pf);
	if ( c == '+' || c == '-' )
	      { s = (c=='+') ? 1 : -1;
		c = sgetcs( pf );
	      }
	if ( !isdigit(c) )  {
		errmsgio( "sgetsi", "EA007" );
		return( ERROR );
	}
	for ( n = 0 ; isdigit(c) ; c = sgetc(pf) )  {
		n = 10 * n + c - '0';
		if ( n >= BASIS )  {
			errmsgio( "sgetsi", "EA007" );
			return( ERROR );
		}
	}
	n *= s;
	unsgetc( c,pf );
	return( n );
}
