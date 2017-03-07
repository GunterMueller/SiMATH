/*M
.SH NAME
pitoppf - polynomial over integers to polynomial over p-adic field
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pitoppf(r, P, p, d)  
single r, p, d;  
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
is a polynomial in r variables over Z.
.PP
pitoppf returns the representation of P as a polynomial over the p-adic field with precision d (s. itopfel).

.SH SEE ALSO
itopfel

M*/
                       
/*H
	Version 1       25.07.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p, d vertauscht
	Version 3       01.08.1991      Parameterreihenfolge korrigiert.  PS
   DATE pitoppf       : 901120.910915
H*/

#include <_pol3.h>

pol pitoppf( r, P, p, d )
single p, d, r;
pol P;
{
	if( P )
	{       /*** koeffizientenweise p-adisch entwickeln ***/

		bind( P );
		if( r == 0 )    P = itopfel( p, d, P );
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
				if( r ) h = pitoppf( r, h, p, d );
				else    h = itopfel( p, d, h );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while ( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	return( P );
}
