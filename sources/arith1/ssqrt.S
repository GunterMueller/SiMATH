/*M
.SH NAME
ssqrt - single-precision square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ssqrt(n)
single n;

.SH DESCRIPTION
ssqrt() returns the integer part of the square root
of n for n >=0.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2       29.6.1987               kein MACRO; m nicht mehr
						ganzzahlig gerundet.  RB
	Version 3       06.07.1987              Parameteruebergabe an
						sqrem verbessert. MAR
	Version 4	14.10.1996		POW2[] rausgeworfen. 
						Marc Conrad
   DATE ssqrt         : 890501.961201
H*/


# include <_arith1.h>

single ssqrt( n )
single n;
{
	single l,m, r,s;
	if (  n == 0 )  m = 0;
	else {
    /***    erste Naeherung    ***/
		s = slog2( n );
		m = 1 << ((s+1)/2);
    /***    Newton-Approximation    ***/
		for ( l=0 ; m>l ; m=(m+l)/2 )  sqrem( 0,n,m, &l,&r );
	}
	return( m );
}
