/*M
.SH NAME
udppfexp - univariate dense polynomial over p-adic field exponentiation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfexp(p, P, n)  
single p, n; 
pol P;
              
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.                   
.TP 4
.B n
is a non noegative integer number. n < BASIS.
.TP 4
.B P
is an univariate dense-polynomial over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp(s. itopfel).
.PP
udppfexp returns a polynomial, say P1, over Qp, where
.IP
P1 = P^n

.SH SEE ALSO
itopfel

M*/
    
/*H
	Version 1       18.07.1990      Christine Hollinger
   DATE udppfexp      : 901120.9109__
H*/

#include <_pol3.h>

pol udppfexp( p, P, n )
single p,n;
pol P;
{
	single d;

	if( P && n )
	{       single d;
		list h,erg = _0;
		bind( P,erg );
		init( h );

		/*** 1 als Approximation in Qp, passend zu a ***/

		d = udppffit( p, P, &h );
		for( h = 0; h < d; h++ )       erg = lcomp( 0,erg );
		erg = lcomp3( d, 0, 1, erg );
		erg = list2( 0,erg );

		/*** Berechnung gemaess binaerer left-to-right-Methode ***/

		h = P;
		while( n )
		{       if( n % 2 )     erg = udppfprod( p, erg, h );
			h = udppfprod( p, h, h );
			n = n / 2 ;
		}
		return( erg );
	}
	if( n ) return( 0 );
	else
	{       if( P )
		{       d = udppffit( p, P, &P );
			P = _0;
			for( n = 0; n < d; n++ )        P = lcomp( 0,P );
			P = lcomp3( d, 0, 1, P );
			P = list2( 0,P );
			return( P );
		}
		else    return( list3( 0, 0, 1 ) );
	}
}
