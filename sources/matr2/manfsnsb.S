/*M
.SH NAME
manfsnsb - matrix of number field elements, sparse representation, null space basis

.SH SYNOPSIS
.nf
#include<_matr2.h>

list manfsnsb(F, M)
pol F;
matrix M;

.SH DESCRIPTION
manfsnsb() returns a list L=(L1, ... , Lr)  of vectors representing a basis
of the null space of M, i.e. M*Li=0 for all i=1,...r.
.PP
.TP 4
.B F
is an irreducible monic sparse polynomial in one variable over the rational numbers.
.TP 4
.B M
is a square matrix over the number field generated by F.

.SH CAUTION
M will be be changed.
M*/




/*H
	Version 1       18.10.1990      Th. Weis
	Version 2	05.11.1991	Darstellung der 1 korrigiert.  TW
   DATE manfsnsb      : 910915.920331
H*/

#include <_matr2.h>

list manfsnsb( F, M )
pol    F;
matrix M;

{
	nfel   a, c, d, v;
	single i, k, m, s;
	list   B, C, Ch, V, Vh;
	matrix M1, M1h, M2, M2h;

	bind( M );
	init( a, c, d, v );
	init( B, C, Ch, V, Vh, M1, M1h, M2, M2h );

/* Initialisierung */

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
	         a = nfsneg( F, nfsinv( F, a ) );
	         Ch = C;
	         while ( Ch != _0 )
	         {
	            c = nfsprod( F, lfirst( Ch ), a );
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
	                  a = nfssum( F, d, nfsprod( F, c, v ) );
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
	      V = lcomp( list2( 0, list2( 1, 1 ) ), V );
	      M2h = M2;
	      while ( M2h != _0 )
	      {
	            C = lfirst( M2h );  M2h = lred( M2h );
	            if ( C != 0 ) a = vecnfssprod( F, C, V );
	            else a = 0;
	            V = lcomp( a, V );
	      }
	      B = lcomp( V, B );
	      M2 = lcomp( 0, M2 );
	   }
	}
	return( B );
}
