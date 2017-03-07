/*M
.SH NAME
ppfderiv - polynomial over p-adic field derivation, main variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfderiv(r, p, P)  
single r, p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p 
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel).
.PP
ppfderiv returns the derivation of P with regard to the main variable.

.SH SEE ALSO
itopfel

M*/
                         
/*H
	Version 1       22.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
	Version 3       01.08.1991      PFIRPOD -> PFELIPROD.  PS
   DATE ppfderiv      : 901120.910915
H*/

#include <_pol3.h>

pol ppfderiv( r, p, P )
single p,r;
pol P;
{
	if( P )
	{       single e;
		pol h,P1;
		init( h,P1 );
		bind( P );

		r--;
		P1 = _0;
		do
		{       e = lfirst( P );
			h = lsecond( P );
			P = lred2( P );
			if( r ) h = ppfiprod( r, p, h, e );
			else    h = pfeliprod( p, h, e );
			if( h ) P1 = lcomp2( h, e - 1 , P1 );
		}
		while( P != _0 );
		if( P1 == _0 )  P = 0;
		else    P = linv( P1 );
	}
	return( P );
}
