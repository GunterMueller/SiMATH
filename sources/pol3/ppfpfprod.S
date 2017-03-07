/*M
.SH NAME
ppfpfprod - polynomial over p-adic field p-adic field element product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfpfprod(r, p, P, b)  
single r, p; 
pol P; 
pfel b;   
  
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
.B b
is an element in Qp (for the representation of p-adic field elements s. itopfel). 
.PP
ppfpfprod returns a polynomial over Qp, say P1, where
.IP
P1 = b * P.

.SH SEE ALSO
itopfel

M*/
                          
/*H
	Version 1       24.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfpfprod     : 901120.910915
H*/

#include <_pol3.h>

pol ppfpfprod( r, p, P, b )
single r,p;
pol P;
pfel b;
{
	if( P && b )
	{       bind( P,b );

		if( r == 0 )    P = pfprod( p, P, b );
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
				if( r ) h = ppfpfprod( r, p, h, b );
				else    h = pfprod( p, h, b );
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
