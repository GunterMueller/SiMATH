/*M
.SH NAME
udppfdif - univariate dense polynomial over p-adic field difference

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfdif(p, P1, P2)  
single p; 
pol P1, P2;
    
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate dense-polynomials over the p-adic field Qp. Thereby, the coefficients of P1 and P2 are approximations of elements in Qp(s. itopfel).
.PP
udppfdif returns a polynomial over Qp, say P3, where
.IP
P3 = P1 - P2.

.SH SEE ALSO
itopfel

M*/
 
/*H
	Version 1       11.05.1990      Christine Hollinger
   DATE udppfdif      : 901120.9109__
H*/

#include <_pol3.h>

pol udppfdif( p, P1, P2)
single p;
pol P1, P2;
{
	bind( P1,P2 );

	/*** P2 = 0 => P1 - P2 = P1 ***/

	if( P2 )
	{       if( P1 )
		{       single e, e1, e2;
			list h1, h2;
			pol P;
			init( P, h1, h2 );

			e1 = lfirst( P1 );
			P1 = lred( P1 );
			e2 = lfirst( P2 );
			P2 = lred( P2 );
			e = smax( e1,e2 );
			P = _0;

			/*** deg( P1 > deg( P2 ) ***/

			if( e1 > e2 )
			{       for( ; e1 > e2; e1-- )
				{       h1 = lfirst( P1 );
					P1 = lred( P1 );
					P = lcomp( h1,P );
				}
			}
			/*** deg( P1 ) < deg( P2 ) ***/

			else if( e1 < e2 )
			{       for( ; e2 > e1; e2-- )
				{       h2 = lfirst( P2 );
					P2 = lred( P2 );
					h2 = pfneg( p,h2 );
					P = lcomp( h2,P );
				}
			}
			/*** e1 = e2 ***/

			for( ; e1 >= 0; e1-- )
			{       h1 = lfirst( P1 );
				P1 = lred( P1 );
				h2 = lfirst( P2 );
				P2 = lred( P2 );
				h1 = pfdif( p, h1, h2 );
				if( h1 || P != _0 )     P = lcomp( h1,P );
				else    e--;
			}
			if( P == _0 )   P1 = 0;
			else
			{       P1 = linv( P );
				P1 = lcomp( e,P1 );
			}
		}
		else    P1 = udppfneg( p,P2 );
	}
	return( P1 );
}
