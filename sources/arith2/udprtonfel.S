/*M
.SH NAME
udprtonfel - univariate dense polynomial over rationals to number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel udprtonfel( P )  
pol P;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the rational numbers.
.PP
udprtonfel returns P as a number field element (s. nfneg).

.SH SEE ALSO
nfneg

M*/
                                   
/*H
	Version 1       13.02.1989      Christine Hollinger
   DATE udprtonfel    : 890601.9211__
H*/



#include <_arith2.h>

nfel udprtonfel( P )
pol P;
{
	nfel a;
	int HNa, ai, ni, zi;
	single r;
	list bi;
	pol p;
	init( HNa, ai, ni, zi, bi, p, a );
	bind( P );

	/*** P = 0, so a = 0. ***/
	if( P == 0 )     return( P );

	/*** P ungleich Null -> HNa = kgv( nr, ..., n0 ). ***/
	r = lfirst( P );
	P = lred( P );
	p = P;
	HNa = 1;
	while( p != _0 )
	{       bi = lfirst( p );
		p = lred( p );
		if( bi )
		{       ni = lsecond( bi );
			HNa = ilcm( HNa,ni );
		}
	}

	/*** ai = bi*HNa/ni. ***/
	a = _0;
	while( P != _0 )
	{       bi = lfirst( P );
		P = lred( P );
		if( bi )
		{       ni = lsecond( bi );
			zi = lfirst( bi );
			ai = iquot( HNa,ni );
			ai = iprod( ai,zi );
			a = lcomp( ai,a );
		}
		else    a = lcomp( 0,a );
	}
	a = linv( a );
	a = lcomp2( HNa, r, a );
	a = nfelnormal( a );
	return( a );
}
