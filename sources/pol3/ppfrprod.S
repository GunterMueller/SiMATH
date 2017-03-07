/*M
.SH NAME
ppfrprod - polynomial over p-adic field rational number product 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfrprod(r, p, P, R)  
single p, r; 
pol P; 
rat R;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel).
.TP 4
.B R
is a rational number.
.PP
ppfrprod returns a polynomial over Qp, say P1, where
.IP
P1 = R * P.

.SH SEE ALSO
itopfel

M*/
                    
/*H
	Version 1       22.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
	Version 3       01.08.1991      PFRPROD -> PFELRPROD.  PS
   DATE ppfrprod      : 901120.910915
H*/

#include <_pol3.h>

pol ppfrprod( r, p, P, R )
single p,r;
pol P;
rat R;
{
	if( P && R )
	{       bind( P,R );

		if( r == 0 )    P = pfelrprod( p, P, R );
		else
		{       single e;
			pol h,P1;
			init( h,P1 );

			/*** koeffizientenweise multiplizieren ***/

			r--;
			P1 = _0;
			do
			{       e = lfirst( P );
				h = lsecond( P );
				P = lred2( P );
				if( r ) h = ppfrprod( r, p, h, R );
				else    h = pfelrprod( p, h, R );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	else    P = 0;
	return( P );
}
