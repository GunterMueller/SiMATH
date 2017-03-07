/*M
.SH NAME
itopfel - integer to p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel itopfel( p, d, A )         
single p, d; 
int A;  
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B d 
is a single number.
.TP 4
.B A
is an integer number.
.PP
itopfel returns the approximation of A as an element in Qp (the p-adic field) with precision d, i.e. let c denote that approximation and let vp be the additive p-adic valuation, then 
.PP
vp(A - c) >= d and
.IP
c = 0, for d < vp(A) or
.IP
c = c_vp(A) * p^vp(A) + ... + c_d * p^d, whereat 
c_vp(A) != 0 and 0 <= c_i <= p - 1.
.PP
Hence, c = 0, for A = 0 or all c_i = 0.

M*/
                                      
/*H
	Version 1       23.04.1990      Christine Hollinger
   DATE itopfel       : 901120
H*/

#include <_arith2.h>

pfel itopfel( p, d, A )
single p,d;
int A;

{
	bind( A );

	if( A )
	{       single h,v;
		list c;
		init( c );

		for( v = 0; mihom( p,A ) == 0; v++ )
			A = iquot( A,p );
		if( v > d )     return( 0 );

		/*** Best. der ersten d - v + 1 Stellen von A in Qp ***/

		c = list2( d,v );
		for( d = d - v; d >= 0; d-- )
		{       h = mihom( p,A );
			c = lsuffix( c,h );
			A = idif( A,h );
			A = iquot( A,p );
		}
		return( c );
	}
	return( A );
}
