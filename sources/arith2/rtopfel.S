/*M
.SH NAME
rtopfel - rational to p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel rtopfel(p, d, R)         
single p, d; 
rat R;
  
.SH DESCRIPTION
.TP 4
.B p
is a single prime number.
.TP 4
.B d
is a single number.
.TP 4
.B R
is a rational number.
.PP
rtopfel returns the approximation of R as an element of the p-adic field Qp, with precision p^d  (s. itopfel).

.SH SEE ALSO
itopfel

M*/
                               
/*H
	Version 1       23.04.1990      Christine Hollinger
   DATE rtopfel       : 901120
H*/

#include <_arith2.h>

pfel rtopfel( p, d, R )
single p,d;
rat R;

{
	bind( R );

	if( R )
	{       single al, bl, h, v;
		int A, B, Ah, Bh;
		init( A, B, Ah, Bh );

		v = 0;
		A = lfirst( R );
		for( ; mihom( p,A ) == 0; v++ )
			A = iquot( A,p );
		B = lsecond( R );
		for( ; mihom( p,B ) == 0; v-- )
			B = iquot( B,p );
		if( v > d )     return( 0 );

		/*** Best. der ersten d - v + 1 Stellen von R in Qp ***/

		R = list2( d,v );

		/*** R = A/B = c_vp( R ) * p^v + ... + c_d * p^d ***/

		bl = mihom( p,B );
		for( d = d - v; d >= 0; d-- )
		{       al = mihom( p,A );
			h = msquot( p, al, bl );
			R = lsuffix( R,h );
			Bh = iprod( B,h );
			Ah = idif( A,Bh );
			A = iquot( Ah,p );
		}
	}
	return( R );
}
