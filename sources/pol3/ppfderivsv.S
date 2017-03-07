/*M
.SH NAME
ppfderivsv - "polynomial over p-adic field derivation, selected variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfderivsv(r, p, P, n)  
single r, p, n; 
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
.TP 4
.B n
is an integer number, 0 < n <= r.
.PP
ppfderivsv returns the derivation of P with regard to the n-th variable.

.SH SEE ALSO
itopfel

M*/
                            
/*H
	Version 1       22.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfderivsv    : 901120.910915
H*/

#include <_pol3.h>

pol ppfderivsv( r, p, P, n )
single r, p, n;
pol P;
{
	if( P )
	{       if( r == n )    P = ppfderiv( r, p, P );

		/*** nach n-ter Variablen suchen ***/

		else
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
				if( r ) h = ppfderivsv( r, p, h, n );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	return( P );
}
