/*M
.SH NAME
prtoppf - polynomial over rationals to polynomial over p-adic field
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol prtoppf(r, P, p, d)  
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
is a polynomial in r variables over Q.
.PP
prtoppf returns the representation of P as a polynomial over the p-adic field with precision d (s. itopfel).

.SH SEE ALSO
itopfel
                                                                                                              
M*/
              
/*H
	Version 1       25.07.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p, d vertauscht
	Version 3       01.08.1991      Parameterreihenfolge korrigiert.  PS
   DATE prtoppf       : 901120.910915
H*/

#include <_pol3.h>

pol prtoppf( r, P, p, d )
single r, p, d;
pol P;
{
	if( P )
	{       /*** koeffizientenweise p-adisch entwickeln ***/

		bind( P );
		if( r == 0 )    P = rtopfel( p, d, P );
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
				if( r ) h = prtoppf( r, h, p, d );
				else    h = rtopfel( p, d, h );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while ( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	return( P );
}
