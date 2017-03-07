/*M
.SH NAME
pfexp - p-adic field element exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfexp(p, a, n)        
single p, n; 
pfel a;

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s. itopfel).
.TP 4
.B n 
is an integer number.
.PP
pfexp returns the approximation of the p-adic field element A^n. 

.SH CAUTION
a = 0 and n < 0 is not allowed.

.SH SEE ALSO
itopfel

M*/
                                  
/*H
	Version 1       09.04.1990      Christine Hollinger
   DATE pfexp         : 901120
H*/

#include <_arith2.h>

pfel pfexp( p, a, n )
single p,n;
pfel a;
{
	single i;
	bind( a );

	/*** a != 0 ***/

	if( a && n )
	{       pfel h,erg = _0;
		init( h );
		bind( erg );

		if( n < 0 )
		{       a = pfinv( p,a );
			n = ineg( n );
		}
		/*** 1 als Approximation in Qp, passend zu a ***/

		i = lfirst( a ) - lsecond( a );
		for( h = 1; h <= i ; h++ )      erg = lcomp( 0,erg );
		erg = lcomp3( i, 0, 1, erg );

		/*** Berechnung mit binaerer right-to-left-Methode ***/

		h = a;
		while( n )
		{       if( n % 2 )     erg = pfprod( p, erg, h );
			h = pfprod( p, h, h );
			n = n / 2 ;
		}
		return( erg );
	}
	if( n == 0 )    /*** a^0 = 1 in p-Approximation ***/
	{       if( a )
		{       i = lfirst( a ) - lsecond( a );
			a = list3( 1, 0, i );
			for( ; i; i-- ) a = lcomp( 0,a );
			a = linv( a );
		}
		else    a = list3( 0, 0, 1 );
	}
	return( a );
}
