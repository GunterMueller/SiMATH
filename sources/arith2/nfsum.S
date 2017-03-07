/*M
.SH NAME
nfsum - number field element sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfsum( F, a, b )           
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
nfsum returns an element of K, say c, where
.IP
c = a + b.

.SH SEE ALSO
nfneg

M*/
        
/*H
	Version 1       16.08.1988      Pascale Serf
	Version 2       25.07.1989      C.Hollinger    ( a+b = 0 ? )
	Version 3       24.10.1990      C.H.    ( Placebo F )
   DATE nfsum         : 890601.890801.901120.9107__
H*/

# include <_arith2.h>

nfel nfsum( F, a, b )
pol F;
nfel a,b;
{
	bind( a,b );

	/*** 1.Fall: a = 0 oder b = 0 ***/

	if( !a )        return( b );
	else if( !b )   return( a );

	/*** 2.Fall: a != 0 und b != 0 ***/

	else
	{       int HNa,HNb;
		init( HNa,HNb );

		HNa = lfirst(a); a = lred(a);
		HNb = lfirst(b); b = lred(b);
		a = udpiiprod( a,HNb );
		a = udpisum( a,udpiiprod( b,HNa ) );
		if( !oequal( a,0 ) )
		{       HNa = iprod( HNa,HNb );
			a = lcomp( HNa,a );
			a = nfelnormal( a );
		}
		return( a );
	}
}
