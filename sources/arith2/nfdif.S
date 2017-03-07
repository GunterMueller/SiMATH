/*M
.SH NAME
nfdif - number field element difference

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfdif( F, a, b )     
pol F; 
nfel a, b;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a, b
are elements of K (for representation of number field elements s. nfneg).
.PP
nfdif returns an element of K, say c, where
.IP
c = a - b.

.SH SEE ALSO
nfneg

M*/

/*H
	Version 1       09.02.1989      Christine Hollinger
	Version 1.1     22.02.1989      C.H.
	Version 2       24.10.1990      C.H.    ( Placebo F )
   DATE nfdif         : 890601.901120
H*/

#include <_arith2.h>

nfel nfdif( F, a, b )
pol F;
nfel a,b;
{
	bind( a,b );            /*** F nicht binden, da Placebo ***/

	/*** b = 0 , a Ergebnis. ***/
	if( b != 0 )
	{       /*** a = 0 && b != 0 ***/
		if( !a )        a = nfneg( F,b );

		/*** a,b != 0 ***/
		else
		{       if( oequal( a,b ) )     a = 0;
			else
			{       int HNa,HNb;
				list c;
				init( HNa, HNb, c );

				HNa = lfirst( a );
				a = lred( a );
				HNb = lfirst( b );
				b = lred( b );
				a = udpiiprod( a,HNb );
				b = udpiiprod( b,HNa );
				c = udpidif( a,b );
				HNa = iprod( HNa,HNb );
				c = lcomp( HNa,c );
				a = nfelnormal(c);
			}
		}
	}
	return( a );
}
