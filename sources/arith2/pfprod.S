/*M
.SH NAME
pfprod - p-adic field element product

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfprod(p, a, b)          
single p; 
pfel a, b;
       
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a, b
are the approximations of two elements (say A, B resp.) of the p-adic number field Qp (s.itopfel).
.PP  
pfprod returns the approximation of the p-adic field elememt A * B, which is equal to A * B at the first vp(A) + vp(B) + min(d - vp(A), d' - vp(B)) digits (for the definition of d see itopfel; d' analogous to d , but with regard to b).

.SH SEE ALSO
itopfel

M*/
                               
/*H
	Version 1       23.03.1990      Christine Hollinger
   DATE pfprod        : 901120
H*/

#include <_arith2.h>

pfel pfprod( p, a, b )
single p;
pfel a,b;

{
	bind( a,b );

	/*** 1.Fall: a != und b != 0 ***/

	if( a && b )
	{
		single i, j, sa, sb, v, ue = 0;
		int ai,ci;
		list c;
		init( c );

		sa = lfirst( a );
		sb = lfirst( b );
		v = lsecond( b );
		ai = lsecond( a );
		a = lred2( a );
		b = lred2( b );
		sa = sa - ai;
		sb = sb - v;
		v = v + ai;

		/*** a, b aus Up und sei a die kuerzere Liste ***/

		if( sa > sb )
		{       ai = sa; sa = sb; sb = ai;
			c = a; a = b; b = c;
		}
		/*** "ueberschuessige" El. von b evtl. entfernen ***/

		sb = sb - sa;
		if( sb > 50 )
		{       b = linv( b );
			b = lreduct( b,sb );
			b = linv( b );
		}
		/*** Produktbildung ( Cauchy-Produkt ) ***/

		i = 0; c = _0;
		while( i <= sa )
		{       j = 0;
			ci = 0;
			while( j <= i )
			{       sb = i - j;
				j++;
				ai = lelt( a,j );
				sb++;
				sb = lelt( b,sb );
				ai = iprod( ai,sb );
				ci = isum( ai,ci );
			}
			ci = isum( ci,ue );
			ue = iquot( ci,p );       /*** Uebertrag ***/
			ci = mihom( p,ci );
			c = lcomp( ci,c );
			i++;
		}
		/*** d( a*b ) = vp( A ) + vp( B ) + min( sa,sb ) ***/

		c = linv( c );
		sb = v + sa;
		a = lcomp2( sb, v, c );
	}
	/*** 2.Fall: a = 0 oder b = 0 ***/

	else    if( a )         a = 0;
	return( a );
}
