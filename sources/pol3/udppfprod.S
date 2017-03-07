/*M
.SH NAME
udppfprod - univariate dense polynomial over p-adic field product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfprod(p, P1, P2)  
single p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B P1, P2
are univariate dense-polynomials over the p-adic field Qp. Thereby, the coefficients of P1 and P2 are approximations of elements in Qp (s. itopfel). 
.PP          
udppfprod returns a polynomial over Qp, say P3, where
.IP
P3 = P1 * P2.

.SH SEE ALSO
itopfel

M*/
                               
/*H
	Version 1       09.07.1990      Christine Hollinger
   DATE udppfprod     : 901120.9109__
H*/

#include <_pol3.h>

pol udppfprod( p, P1, P2 )
single p;
pol P1, P2;
{
	if( P1 == 0 || P2 == 0 )        P1 = 0;

	/*** P1 und P2 ungleich 0 ***/

	else
	{       single d, h, i, j;
		pfel ai, a1, a2;
		list P;
		init( ai, a1, a2, P );
		bind( P1,P2 );

		d = lfirst( P1 );
		P1 = lred( P1 );
		h = lfirst( P2 );
		P2 = lred( P2 );

		/*** Produktbildung ( Cauchy-Produkt ): P = P1 * P2 ***/

		P1 = lcinv( P1 );        /*** P1, P2 nach aufsteig. Grad ***/
		P2 = lcinv( P2 );
		d = d + h;
		i = 0; P = _0;
		while( i <= d )
		{       j = 0;
			ai = 0;
			while( j <= i )
			{       h = i - j;
				j++; h++;
				a1 = lelt( P1,j );
				a2 = lelt( P2,h );
				a1 = pfprod( p, a1, a2 );
				ai = pfsum( p, ai, a1 );
			}
			P = lcomp( ai,P );
			i++;
		}
		/*** fuehrende Nullen beseitigen und Grad d anpassen ***/

		for( ; lfirst( P ) == 0; d-- )
			P = lred( P );
		if( P == _0 )   P1 = 0;
		else    P1 = lcomp( d,P );
	}
	return( P1 );
}
