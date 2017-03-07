/*M
.SH NAME
ppfsubstsv - polynomial over p-adic field substitution, selected variable
(recursive)
.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfsubstsv(r, p, P1, n, P2)  
single r, p, n; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B n
is an integer number, 1 <= n <= r.                 
.TP 4
.B P1
is a polynomial in r variables over the p-adic field Qp.
.TP 4
.B P2
is a polynomial in n-1 variables over the p-adic field Qp.
.PP
Thereby, the coefficients of P1 and P2 are approximations of elements in Qp (s. itopfel).
.PP
ppfsubstsv returns a polynomial over Qp, say P3, where
.IP
P3 = P1(P2)  with regard to the n-th variable.

.SH CAUTION
If P1 is an univariate polynomial, P1(P2) is both of type pol and of type pfel.

.SH SEE ALSO
.nf
itopfel   
ppfsubst
 
M*/
       
/*H
	Version 1       31.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfsubstsv    : 901120.910915
H*/

#include <_pol3.h>

pol ppfsubstsv( r, p, P1, n, P2 )
single r, p, n;
pol P1,P2;
{
	if( P1 )
	{       bind( P1,P2 );

		if( r == n )    P1 = ppfsubst( r, p, P1, P2 );

		/*** Auswerten bzgl. der n-ten Variablen ***/

		else
		{       single e;
			pol h,P;
			init( h,P );

			r--;
			P = _0;
			do
			{       e = lfirst( P1 );
				h = lsecond( P1 );
				P1 = lred2( P1 );
				h = ppfsubstsv( r, p, h, n, P2 );
				if( h ) P = lcomp2( h, e, P );
			}
			while( P1 != _0 );
			if( P == _0 )   P1 = 0;
			else    P1 = linv( P );
		}
	}
	return( P1 );
}
