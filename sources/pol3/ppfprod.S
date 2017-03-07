/*M
.SH NAME
ppfprod - polynomial over p-adic field product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfprod(r, p, P1, P2)  
single p, r; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the p-adic field Qp. Thereby, the coefficients of P1 and P2 are approximations of elements in Qp (s. itopfel).
.PP
ppfprod returns a polynomial over Qp, say P3, where
.IP
P3 = P1 * P2.
 
.SH SEE ALSO
itopfel

M*/
      
/*H
	Version 1       01.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppfprod       : 901120.910915
H*/

#include <_pol3.h>

pol ppfprod( r, p, P1, P2)
single p,r;
pol P1, P2;
{
	if( P1 && P2 )
	{       bind( P1,P2 );

		/*** keine Variable ***/

		if( r == 0 )    P1 = pfprod( p, P1, P2 );

		else    /*** 0 < r Variablen ***/
		{
			single e1, e2, rs;
			pol h1, h2, P1S, P3, P3S;
			init( h1, h2, P1S, P3, P3S );

			P1 = lcinv( P1 );
			P2 = lcinv( P2 );
			P3 = 0;
			rs = r - 1;
			do      /*** durchmultiplizieren ***/
			{       h2 = lfirst( P2 );
				e2 = lsecond( P2 );
				P2 = lred2( P2 );
				P1S = P1;
				P3S = _0;
				do
				{       h1 = lfirst( P1S );
					e1 = lsecond( P1S );
					P1S = lred2( P1S );
					if( rs )
					  h1 = ppfprod( rs,p,h1,h2 );
					else  h1 = pfprod( p,h1,h2 );
					P3S = lcomp2( e1+e2, h1, P3S );
				}
				while( P1S != _0 );
				P3 = ppfsum( r, p, P3, P3S );
			}
			while( P2 != _0 );
			P1 = P3;
		}
	}
	else P1 = 0;
	return( P1 );
}
