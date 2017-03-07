/*M
.SH NAME
pfsum - p-adic field element sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfsum(p, a, b)    
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
pfsum returns the approximation of the p-adic field element A+B, which is equal to A+B at the first min( d,d' ) + 1 - vp( A + B ) digits (for the definition of d see itopfel; d' analogous to d , but with regard to b).

.SH SEE ALSO
itopfel

M*/
                            
/*H
	Version 1       07.03.1990      Christine Hollinger
   DATE pfsum         : 901120
H*/

#include <_arith2.h>

pfel pfsum( p, a, b )
single p;
pfel a,b;

{
	bind( a,b );

	/*** 1.Fall: a = 0 oder b = 0 ***/

	if( !a )        return( b );
	else if( !b )   return( a );

	/*** 2.Fall: a != 0 und b != 0 ***/

	else
	{       single i, d, va, vb, u = 0;
		int ai,bi;
		pfel c;
		init( ai, bi, c );

		if( lsecond( a ) > lsecond( b ) )
		{       c = a;
			a = b;
			b = c;
		}
		/*** vp( a ) <= vp( B ) ***/

		va = lsecond( a );
		vb = lsecond( b );

		/*** Genauigkeit von A + B ***/

		d = lfirst( a );
		i = lfirst( b );
		d = smin( d,i );
		a = lred2( a );
		b = lred2( b );
		c = _0;

		/*** Addition ab vp( B ), bis Position davor Stellen
		     von A uebernehmen ***/

		vb = smin( vb, d+1 );
		for( i = va; i < vb; i++ )
		{       ai = lfirst( a );
			a = lred( a );
			c = lcomp( ai,c );
		}
		for( ; i <= d; i++ )
		{       ai = lfirst( a );
			bi = lfirst( b );
			a = lred( a );
			b = lred( b );
			ai = isum( ai,bi );
			ai = isum( ai,u );      /*** Uebertrag ***/
			u = iquot( ai,p );
			ai = mihom( p,ai );
			if( ai || c != _0 )     c = lcomp( ai,c );
			else    va++;
		}
		if( c == _0 )   return( 0 );
		c = linv( c );
		c = lcomp2( d,va,c );
		return( c );
	}
}
