/*M
.SH NAME
ppfexp - polynomial over p-adic field exponentiation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfexp(r, p, P, n)  
single p, r, n; 
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
.B n
is an integer number, 0 <= n < BASIS.
.PP
ppfexp returns a polynomial over Qp, say P1, where
.IP
P1 = P^n.

.SH SEE ALSO
itopfel

M*/

/*H
	Version 1       13.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppfexp        : 901120.910915
H*/

#include <_pol3.h>

pol ppfexp( r, p, P, n )
single p, r, n;
pol P;
{
	if( P && n )
	{       single d;
		pol erg,h;
		init( erg,h );
		bind( P );

		/*** r = 0  oder  r = 1
		     => binaere Methode schneller als for-Schleife ***/

		if( r < 2 )
		{       if( !r )        erg = pfexp( p, P, n );
			else
			{       d = ppford( r, p, P );
				erg = pvinsert( 0, 1, r );
				erg = pitoppf( r, erg, p, d );
				h = P;
				while( n )
				{       if( n % 2 )
					  erg = ppfprod( r, p, erg, h );
					h = ppfprod( r, p, h, h );
					n = n / 2;
				}
			}
		}
		else    /*** for-Schleife schneller ***/
		{       erg = P;
			for( --n; n; n-- )
				erg = ppfprod( r, p, P, erg );
		}
		P = erg;
	}
	else if( n == 0 )       /*** P^0 = 1 in p-Approximation ***/
	{       if( P )
		{       n = ppford( r, p, P );
			P = pvinsert( 0, 1, r );
			P = pitoppf( r, P, p, n );
		}
		else
		{       P = pvinsert( 0, 1, r );
			P = pitoppf( r, P, p, 0 );
		}
	}
	return( P );
}
