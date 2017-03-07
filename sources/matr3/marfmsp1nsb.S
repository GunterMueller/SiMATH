/*M
.SH NAME
marfmsp1nsb - matrix of rational functions over modular single primes, transcendence degree 1, null space basis

.SH SYNOPSIS
.nf
#include<_matr3.h>

list marfmsp1nsb(p, M)
single p;
matrix M;

.SH DESCRIPTION
marfmsp1nsb() returns a list L=(L1, ... , Lr)  of vectors representing a basis
of the null space of M, i.e. M*Li=0 for all i=1,...r.
.PP
.TP 4
.B M
is a square matrix of rational functions in r variables over Z/pZ.
M*/






/*H
	Version 1       20.06.1990      Th. Weis
	Version 2	08.10.1991	Darstellung der 'eins' korrigiert.  TW
	Version 3	10.09.1992	list2(list2(),list2()) aufgeloest.  PS
   DATE marfmsp1nsb   : 910915.920331.921130
H*/

#include <_matr3.h>

list marfmsp1nsb( p, M )
single p;
matrix M;
{
	rfunc  a, c, d, v;
	rfunc  eins;
	single i, k, m, s;
	list   B, C, Ch, V, Vh;
	matrix M1, M1h, M2, M2h;

	bind( M );
	init( a, c, d, v );
	init( eins );
	init( B, C, Ch, V, Vh, M1, M1h, M2, M2h );

/* Initialisierung */

	eins = list2( 0, 1 );
	eins = list2( eins, list2( 0, 1 ) );
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
	         a = rfmsp1neg( p, rfmsp1inv( p, a ) );
	         Ch = C;
	         while ( Ch != _0 )
	         {
	            c = rfmsp1prod( p, lfirst( Ch ), a );
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
	                  a = rfmsp1sum( p, d, rfmsp1prod( p, c, v ) );
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
	            C = lfirst( M2h ); M2h = lred( M2h );
	            if ( C != 0 ) a = vecrfmsp1sp( p, C, V );
	            else a = 0;
	            V = lcomp( a, V );
	      }
	      B = lcomp( V, B );
	      M2 = lcomp( 0, M2 );
	   }
	}
	return( B );
}


