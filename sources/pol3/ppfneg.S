/*M
.SH NAME
ppfneg - polynomial over p-adic field negation 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfneg(r, p, P)  
single p, r; 
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
.PP
ppfneg returns a polynomial over Qp, say P1, where
.IP
P1 = -P.

.SH SEE ALSO
itopfel

M*/
            
/*H
	Version 1       27.07.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppfneg        : 901120.910915
H*/

#include <_pol3.h>

pol ppfneg( r, p, P )
single p,r;
pol P;
{
	if( P )
	{       /*** koeffizientenweise p-adisch Inverses bilden ***/

		bind( P );
		if( r == 0 )    P = pfneg( p,P );
		else
		{       single e;
			list h,P1;
			init( h,P1 );

			r--;
			P1 = _0;
			do
			{       e = lfirst( P );
				h = lsecond( P );
				P = lred2( P );
				if( r ) h = ppfneg( r, p, h );
				else    h = pfneg( p,h );
				P1 = lcomp2( h, e, P1 );
			}
			while ( P != _0 );
			P = linv( P1 );
		}
	}
	return( P );
}
