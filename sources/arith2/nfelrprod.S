/*M
.SH NAME
nfelrprod - number field element rational number product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfelrprod( F, a, R )  
pol F; 
nfel a; 
rat R;
   
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.TP 4
.B R
is a rational number.
.PP
nfelrprod returns an element of K, say c, where
.IP
c = R * a.

.SH SEE ALSO
nfneg

M*/

/*H
	Version 1       29.03.1989      Christine Hollinger
	Version 2       18.01.1990      C.H.   ( Optimierung )
	Version 3       24.10.1990      C.H.   ( Placebo F )
	Version 4       01.08.1991      RNFELPROD -> NFELRPROD,
					INFELPROD -> NFELIPROD.  PS
   DATE nfelrprod     : 890601.900315.901120.910915
H*/

#include <_arith2.h>

nfel nfelrprod( F, a, R )
pol F;
nfel a;
rat R;
{
	bind( a,R );            /*** F nicht binden, da nur Placebo ***/

	/*** a = 0 -> R * a = 0. ***/

	if( a )
	{       /*** R = 0 -> R * a = 0. ***/
		if( !R )        a = 0;
		else
		{       int g, HNa, n, z;
			pol P;
			init( g, HNa, n, z, P );

			/*** R * a = z/(HNa*n)*(ar*x^r + ... + a0) ***/

			z = lfirst( R );
			a = nfeliprod( F, a, z );
			HNa = lfirst( a );
			a = lred( a );
			z = udpicontpp( a,&P );
			n = lsecond( R );
			g = igcd( z,n );
			if( g != 1 )
			{       n = iquot( n,g );
				HNa = iprod( HNa,n );
				z = iquot( z,g );
				a = udpiiprod( P,z );
			}
			else    HNa = iprod( HNa,n );
			a = lcomp( HNa,a );
		}
	}
	return( a );
}
