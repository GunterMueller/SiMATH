/*M
.SH NAME
udppfpfprod - univariate dense polynomial over p-adic field p-adic field element product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfpfprod(p, P, a)  
single p; 
pol P; 
pfel a;
 
.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B P
is an univariate dense-polynomial over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp(s. itopfel).
.TP 4
.B a
is an element in Qp.   
.PP
udppfpfprod returns a polynomial, say P1, over Qp, where
.IP
P1 = a * P.

.SH SEE ALSO
itopfel

M*/
                                    
/*H
	Version 1       18.07.1990      Christine Hollinger
	Version 2       01.08.1991      Parameter a und P vertauscht.  PS
   DATE udppfpfprod   : 901120.910915
H*/

#include <_pol3.h>

pol udppfpfprod( p, P, a )
single p;
pol P;
pfel a;
{
	if( a == 0 || P == 0 )  P = 0;

	/*** koeffizientenweise mit a multiplizieren ***/

	else
	{       pfel ai;
		list P1;
		bind( a,P );
		init( ai,P1 );

		ai = lfirst( P );
		P1 = list1( ai );       /*** Grad( P*a ) = Grad( P ) ***/
		P = lred( P );
		for( ; P != _0; P = lred( P ) )
		{       ai = lfirst( P );
			ai = pfprod( p, a, ai );
			P1 = lcomp( ai,P1 );
		}
		P = linv( P1 );
	}
	return( P );
}
