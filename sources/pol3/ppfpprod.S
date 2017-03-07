/*M
.SH NAME
ppfpprod - polynomial over p-adic field prime power product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfpprod(r, p, P, i)  
single p, r, i; 
pol P;
   
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
.B i
is an integer number.
.PP
ppfpprod returns a polynomial over Qp, say P1, where
.IP
P1 = P * p^i.

.SH SEE ALSO
itopfel

M*/
      
/*H
	Version 1       03.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppfpprod      : 901120.910915
H*/

#include <_pol3.h>

pol ppfpprod( r, p, P, i )
single p, r, i;
pol P;
{
	if( P && i )
	{       /*** koeffizientenweise vorgehen ***/

		bind( P );

		if( r == 0 )    P = pfprod( P,i );
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
				if( r ) h = ppfpprod( r, p, h, i );
				else    h = pfpprod( p, h, i );
				P1 = lcomp2( h, e, P1 );
			}
			while( P != _0 );
			P = linv( P1 );
		}
	}
	return( P );
}
