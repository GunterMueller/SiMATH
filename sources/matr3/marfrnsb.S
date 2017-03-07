/*M
.SH NAME
marfrnsb - matrix of rational functions over the rational numbers, null space basis

.SH SYNOPSIS
.nf
#include<_matr3.h>

list marfrnsb(r, M)
single r;
matrix M;

.SH DESCRIPTION
marfrnsb() returns a list L=(L1, ... , Lr)  of vectors representing a basis
of the null space of M, i.e. M*Li=0 for all i=1,...r.
.PP
.TP 4
.B M
is a square matrix of rational functions in r variables over the rational numbers.

M*/





/*H
	Version 1       20.06.1990      Th. Weis
	Version 2	29.10.1991	Darstellung der 'eins' korrigiert.  TW
   DATE marfrnsb      : 910915.920331
H*/

#include <_matr3.h>

list marfrnsb( r, M )
single r;
matrix M;

{
	rfunc  a, c, d, v;
	rfunc  eins;
	single i, k, m, s;
	list   B, C, Ch, V, Vh;
	matrix M1, M1h, M2, M2h;

	bind( M );
	init( eins );
	init( a, c, d, v );
	init( B, C, Ch, V, Vh, M1, M1h, M2, M2h );

/* Initialisierung */

	eins = rtorfr( r, itor( 1 ) );
	M1 = M;
	M2 = _0;
	B = _0;
	m = llength( lfirst( M ) );

/* Schleife */

	for ( k = 1; k <= m; k++ )
	{
	   M1h = M1;  M1 = _0;  s = 1;
	   while ( M1h != _0 )
	   {
	      C = lfirst( M1h );  M1h = lred( M1h );
	      a = lfirst( C );  C = lred( C );
	      if ( a == 0 ) M1 = lcomp( C, M1 );
	      else
	      {
	         M2 = lcomp( C, M2 );
	         a = rfrneg( r, rfrinv( r, a ) );
	         Ch = C;
	         while ( Ch != _0 )
	         {
	            c = rfrprod( r, lfirst( Ch ), a );
	            lsfirst( Ch, c );
	            Ch = lred( Ch );
	         }
	         while ( M1h != _0 )
	         {
	            Vh = lfirst( M1h );  M1h = lred( M1h );
	            v = lfirst( Vh );  Vh = lred( Vh );
	            M1 = lcomp( Vh, M1 );
	            if ( v != 0 )
	            {
	               Ch = C;
	               while ( Ch != _0 )
	               {
	                  c = lfirst( Ch );  Ch = lred( Ch );
	                  d = lfirst( Vh );
	                  a = rfrsum( r, d, rfrprod( r, c, v ) );
	                  lsfirst( Vh, a );
	                  Vh = lred( Vh );
	               }
	            }
	         }
	         s = 0;  break;
	      }
	   }
	   if ( s != 0 )
	   {
	      V = _0;
	      for ( i = k; i < m; i++ ) V = lcomp( 0, V );
	      V = lcomp( eins, V );
	      M2h = M2;
	      while ( M2h != _0 )
	      {
	            C = lfirst( M2h );  M2h = lred( M2h );
	            if ( C != 0 ) a = vecrfrsprod( r, C, V );
	            else a = 0;
	            V = lcomp( a, V );
	      }
	      B = lcomp( V, B );
	      M2 = lcomp( 0, M2 );
	   }
	}
	return( B );
}


