/*M
.SH NAME
ppfsubst - polynomial over p-adic field substitution, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfsubst( r, p, P1, P2 )  
single r, p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B P1
is a polynomial in r variables over the p-adic field Qp.
.TP 4
.B P2
is a polynomial in r-1 variables over the p-adic field Qp.
.PP
Thereby, the coefficients of P1 and P2 are approximations of elements in Qp (s. itopfel).
.PP
ppfsubst returns a polynomial over Qp, say P3, where
.IP
P3 = P1(P2)  with regard to the main variable of 
             P1.

.SH CAUTION
If P1 is an univariate polynomial, P1(P2) is both of type pol and of type pfel. 

.SH SEE ALSO
.nf
itopfel
ppfsubstsv

M*/
                
/*H
	Version 1       29.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfsubst      : 901120.910915
H*/

#include <_pol3.h>

pol ppfsubst( r, p, P1, P2 )
single r,p;
pol P1,P2;
{
	if( P1 )
	{       bind( P1,P2 );

		if( r == 1 )    P1 = ppfeval( r, p, P1, P2 );
		else
		{       single e,e1;
			pol h,P;
			init( h,P );

			/*** Auswertung mit Horner-Schema ***/

			r--;
			e = lfirst( P1 );
			P = lsecond( P1 );
			P1 = lred2( P1 );
			while( P1 != _0 )
			{       e1 = lfirst( P1 );
				h = lsecond( P1 );
				P1 = lred2( P1 );
				for( e -= e1; e ; e -- )
					P = ppfprod( r, p, P, P2 );
				P = ppfsum( r, p, P, h );
				e = e1;
			}
			for( ; e; e-- ) P = ppfprod( r, p, P, P2 );
			P1 = P;
		}
	}
	return( P1 );
}
