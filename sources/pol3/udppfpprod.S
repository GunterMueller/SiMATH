/*M
.SH NAME
udppfpprod - univariate dense polynomial over p-adic field prime power product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfpprod(p, P, i)  
single p,i; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B i
is an integer. i < BASIS.
.TP 4
.B P
is an univariate dense-polynomial over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp(s. itopfel).
.PP 
udppfpprod returns a polynomial over Qp (say P1), where
.IP
P1 = p^i * P.

.SH SEE ALSO
itopfel

M*/
                
/*H
	Version 1       20.07.1990      Christine Hollinger
   DATE udppfpprod    : 901120.9109__
H*/

#include <_pol3.h>

pol udppfpprod( p, P, i )
single p,i;
pol P;
{
	if( P && i )
	{       pfel ai;
		list P1;
		bind( P );
		init( ai,P1 );

		ai = lfirst( P );       /*** Grad ***/
		P1 = list1( ai );
		P = lred( P );

		/*** koeffizentenweise mit p^i multiplizieren ***/

		for( ; P != _0; P = lred( P ) )
		{       ai = lfirst( P );
			ai = pfpprod( p, ai, i );
			P1 = lcomp( ai,P1 );
		}
		P = linv( P1 );
	}
	return( P );
}
