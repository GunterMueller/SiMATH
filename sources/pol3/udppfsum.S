/*M
.SH NAME
udppfsum - univariate dense polynomial over p-adic field sum 

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udppfsum(p, P1, P2)  
single p; 
pol P1, P2;
     
.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B P1, P2
are univariate dense-polynomials over the p-adic field Qp. Thereby, the coefficients of P1 and P2 are approximations of elements in Qp(s. itopfel).
.PP
udppfsum returns a polynomial, say P3, over Qp, where
.IP
P3 = P1 + P2.

.SH SEE ALSO
itopfel

M*/

/*H
	Version 1       09.05.1990      Christine Hollinger
   DATE udppfsum      : 901120.9109__
H*/

#include <_pol3.h>

pol udppfsum( p, P1, P2 )
single p;
pol P1,P2;
{
	bind( P1,P2 );

	/*** P2 = 0 => P1 + P2 = P1   und   P1 = 0 => P1 + P2 = P2 ***/

	if( P2 )
	{       if( P1 )
		{       single e1,e2;
			list h1,h2;
			pol P;
			init( h1, h2, P );

			if( lfirst( P1 ) < lfirst( P2 ) )
			{       h1 = P2;
				P2 = P1;
				P1 = h1;
			}
			/*** deg( P1 ) >= deg( P2 ) ***/

			e1 = lfirst( P1 );
			e2 = lfirst( P2 );
			P1 = lred( P1 );
			P2 = lred( P2 );
			P = _0;
			for( h2 = e1; h2 > e2; h2-- )
			{       h1 = lfirst( P1 );
				P1 = lred( P1 );
				P = lcomp( h1,P );
			}
			for( ; e2 >= 0; e2-- )
			{       h1 = lfirst( P1 );
				P1 = lred( P1 );
				h2 = lfirst( P2 );
				P2 = lred( P2 );
				h1 = pfsum( p, h1, h2 );
				if( h1 || P != _0 )     P = lcomp( h1,P );
				else    e1--;
			}
			if( P == _0 )   P1 = 0;
			else
			{       P1 = linv( P );
				P1 = lcomp( e1,P1 );
			}
		}
		else    P1 = P2;
	}
	return( P1 );
}
