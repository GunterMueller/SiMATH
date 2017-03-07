/*M
.SH NAME
icomp - integer comparison

.SH SYNOPSIS
.nf
#include<_arith1.h>

single icomp(A,B)
int A,B;

.SH DESCRIPTION
icomp() returns the sign of (A-B).
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE icomp         : 890501
H*/


# include <_arith1.h>

single icomp ( A, B )             /* safe */
int A,B;
{
    /***    Sonderfaelle    ***/
	if ( isatom(A) && isatom(B) )  return(ssign(A-B));
	if ( isatom(A) )  return(-isign(B));
	if ( isatom(B) )  return(isign(A));
	{
	    /***    paarweiser Vergleich der Komponenten    ***/
		single a,b,d, s,u,v;
		for ( s=0 ; A!=_0 && B!=_0 ; A=lred(A), B=lred(B) )  {
			a = lfirst( A ),  b = lfirst( B );
			u = ssign( a ),   v = ssign( b );
			if (u*v == -1)  return( u );
			if ( d=a-b )  s = ssign( d );
		}
	    /***    Ergebnis    ***/
		if ( A==_0 && B==_0 )  return( s );
		if ( A==_0 )  return(-isign( B ));
		return(isign( A ));
	}
}
