/*M
.SH NAME
udprtoudppf - univariate dense polynomial over rationals to univariate dense polynomial over p-adic field

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udprtoudppf(P, p, d)  
pol P; 
single p, d;
     
.SH DESCRIPTION
.TP 4
.B P
is an univariate dense-polynomial over the rational numbers.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B d
is an integer number, d < BASIS.
.PP
udprtoudppf returns an univariate dense-polynomial, say P1, which is equal to P, but over the p-adic field Qp.
.SH CAUTION
The coefficients of P1 are only approximations of the regarding elements in Qp. The precision of this approximations is given by d (s. itopfel).
If the approximation of the leading coefficient is zero, the degree of P will be reduced.

.SH SEE ALSO
itopfel

M*/                          
                                          
/*H
	Version 1       09.05.1990      Christine Hollinger
	Version 2       01.08.1991      Parameter P an 1. Stelle.  PS
   DATE udprtoudppf   : 901120.910915
H*/

#include <_pol3.h>

pol udprtoudppf( P, p, d )
pol P;
single p,d;
{
	bind( P );

	/*** P != 0 ***/

	if( P )
	{       single e;
		list h,P1;
		init( h,P1 );

		e = lfirst( P );
		P = lred( P );
		P1 = _0;

		/*** Koeffizienten p-adisch entwickeln ***/
		do
		{       h = lfirst( P );
			P = lred( P );
			h = rtopfel( p, d, h );
			if( h || P1 != _0 )     P1 = lcomp( h,P1 );
			else    e--;
		}
		while( P != _0 );
		if( P1 == _0 )     P = 0;
		else
		{       P = linv( P1 );
			P = lcomp( e,P );
		}
	}
	return( P );
}
