/*M
.SH NAME
pfinv - p-adic field element inverse

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfinv(p,a)                
single p; 
pfel a;

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp. a is not equal to zero (for the representation of p-adic field elements s. itopfel).
.PP
pfinv returns the approximation of A^-1 with precision d (s. itopfel).

.SH SEE ALSO
itopfel

M*/
                                                       
/*H
	Version 1       07.04.1990      Christine Hollinger
   DATE pfinv         : 901120
H*/

#include <_arith2.h>

pfel pfinv( p,a )
single p;
pfel a;

{
	single i, j, d, s, v, ai, a0, ue;
	int h,ci;
	list c;
	init( h, ci, c );
	bind( a );

	/*** b = a^-1 => vp( A^-1 ) = -vp( A )
			 d( A^-1 ) = d( a ) - 2vp( A )  ***/
	d = lfirst( a );
	v = lsecond( a );
	s = d - v;
	d = s - v;
	v = ineg( v );

	/*** obdA: a aus Up: b_0 = a_0^-1 ,
			     b_i = -a_0^-1 * ( a_1*b_i-1 + ... b_1 ) ***/

	a0 = lthird( a );
	a = lred3( a );
	ci = msinv( p,a0 );
	c = list1( ci );
	ci = iprod( ci,a0 );
	ue = iquot( ci,p );
	i = 1;
	while( i <= s )
	{       j = 1;
		ci = 0;
		while( j <= i )
		{       ai = lelt( a,j );
			h = i - j;
			h++;
			h = lelt( c,h );
			h = iprod( h,ai );
			ci = isum( h,ci );
			j++;
		}
		h = isum( ci,ue );
		ci = miquot( p, h, a0 );
		ci = msneg( p,ci );
		c = lsuffix( c,ci );
		ci = iprod( a0,ci );
		ci = isum( h,ci );
		ue = iquot( ci,p );
		i++;
	}
	/*** a^-1 = ( d, -vp( A ), c_vp( A ), ..., c_d ) ***/

	c = lcomp2( d, v, c );
	return( c );
}
