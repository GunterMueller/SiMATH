/*M
.SH NAME
ppfevalsv - polynomial over p-adic field evaluation, selected variable (recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfevalsv(r, p, P, n, A)  
single r, p, n; 
pol P; 
pfel A;
 
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
.TP 4
.B A
is an element in Qp (for the representation of p-adic field elements s. itopfel).
.PP
ppfevalsv returns the evaluation of P at A with regard to the n-th variable.

.SH CAUTION
If P is an univariate polynomial (so n = r = 1), P(A) is both of type pol and of type pfel.

.SH SEE ALSO
.nf
ppfeval
itopfel                                                                            
M*/

/*H
	Version 1       29.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfevalsv     : 901120.910915
H*/

#include <_pol3.h>

pol ppfevalsv( r, p, P, n, A )
single r, p, n;
pol P;
pfel A;
{
	if( P )
	{       bind( P,A );

		if( r == n )    P = ppfeval( r, p, P, A );

		/*** Auswerten bzgl. der n-ten Variablen ***/

		else
		{       single e;
			pol h,P1;
			init( h,P1 );

			r--;
			P1 = _0;
			do
			{       e = lfirst( P );
				h = lsecond( P );
				P = lred2( P );
				h = ppfevalsv( r, p, h, n, A );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	return( P );
}
