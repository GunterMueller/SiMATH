/*M
.SH NAME
ppfsum - polynomial over p-adic field sum
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfsum(r, p, P1, P2)  
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
ppfsum returns a polynomial over Qp, say P3, where
.IP
P3 = P1 + P2.
 
.SH SEE ALSO
itopfel

M*/
          
/*H
	Version 1       27.07.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppfsum        : 901120.910915
H*/

#include <_pol3.h>

pol ppfsum( r, p, P1, P2)
single p,r;
pol P1, P2;
{
	if( P1 && P2 )
	{       /*** koeffizientenweise addieren ***/

		bind( P1,P2 );
		if( r == 0 )    P1 = pfsum( p, P1, P2 );
		else
		{       single e1,e2;
			pol h1, h2, P3;
			init( h1, h2, P3 );

			r--;
			P3 = _0;
			do      /*** nach absteigendem Grad e1,e2 ***/
			{       e1 = lfirst( P1 );
				e2 = lfirst( P2 );
				if( e1 > e2 )
				{       h1 = lsecond( P1 );
					P1 = lred2( P1 );
					P3 = lcomp2( h1, e1, P3 );
				}
				else
				{       if( e1 < e2 )
					{       h2 = lsecond( P2 );
						P2 = lred2( P2 );
						P3 = lcomp2( h2, e2, P3 );
					}
					else    /*** summieren ***/
					{       h1 = lsecond( P1 );
						h2 = lsecond( P2 );
						P1 = lred2( P1 );
						P2 = lred2( P2 );
						if( r )
						  h1 = ppfsum( r,p,h1,h2 );
						else h1 = pfsum( p,h1,h2 );
						if( h1 )
						  P3 = lcomp2( h1, e1, P3 );
					}
				}
			}
			while( P1 != _0 && P2 != _0 );
			P3 = linv( P3 );
			if( P2 != _0 )  P1 = P2;
			P1 = lconc( P3,P1 );
			if( P1 == _0 )  P1 = 0;
		}
	}
	else if( P1 == 0 )      P1 = P2;
	return( P1 );
}
