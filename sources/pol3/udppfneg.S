/*M
.SH NAME
udppfneg - univariate dense polynomial over p-adic field negation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfneg(p, P)  
single p; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B P
is an univariate dense-polynomial over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp(s. itopfel).
.PP
udppfneg returns a polynomial, say P1, over Qp, where
.IP
P1 = -P.

.SH SEE ALSO
itopfel

M*/
   
/*H
	Version 1       08.05.1990      Christine Hollinger
   DATE udppfneg      : 901120.9109__
H*/

#include <_pol3.h>

pol udppfneg( p,P )
single p;
pol P;
{
	bind( P );

	/*** P != 0 ***/

	if( P )
	{       list h,P1;
		init( h,P1 );

		h = lfirst( P );
		P = lred( P );
		P1 = list1( h );

		/*** koeffizientenweise negieren ***/
		do
		{       h = lfirst( P );
			P = lred( P );
			h = pfneg( p,h );
			P1 = lcomp( h,P1 );
		}
		while( P != _0 );
		P = linv( P1 );
	}
	return( P );
}
