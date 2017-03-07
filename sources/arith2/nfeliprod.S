/*M
.SH NAME
nfeliprod - number field element integer product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfeliprod( F, a, i )  
pol F; 
nfel a; 
int i;
     
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.TP 4
.B i
is an integer number.
.PP
nfeliprod returns an element of K, say b, where
.IP
b = i * a.

.SH SEE ALSO
nfneg

M*/
                                    
/*H
	Version 1       28.03.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placebo F )
	Version 3       01.08.1991      INFELPROD(F,i,a) -> NFELIPROD(F,a,i)  PS
   DATE nfeliprod     : 890601.901120.910915
H*/

#include <_arith2.h>

nfel nfeliprod( F, a, i )
pol F;
nfel a;
int i;
{
	bind( a,i );

	/*** a = 0 -> i * a = 0. ***/

	if( a )
	{       /*** i = 0 -> i * a = 0. ***/
		if( !i )        a = 0;
		else
		{       /*** i = 1 -> i * a = a. ***/
			if( i != 1 )
			{       int HNa, g;
				single r;
				list L;
				init( HNa, g, L );

				HNa = lfirst( a );
				r = lsecond( a );
				a = lred2( a );
				g = igcd( HNa,i );
				if( g != 1 )
				{       HNa = iquot( HNa,g );
					i = iquot( i,g );
				}
				L = _0;
				while( a != _0 )
				{       g = lfirst( a );
					g = iprod( i,g );
					L = lcomp( g,L );
					a = lred( a );
				}
				L = linv( L );
				a = lcomp2( HNa, r, L );
			}
		}
	}
	return( a );
}
