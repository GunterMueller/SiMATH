/*M
.SH NAME
magfsssle - matrix of Galois-field with single characteristic elements, solution of a system of linear equations

.SH SYNOPSIS
.nf
#include<_matr2.h>

single magfsssle(p, AL, A, b, pX, pN);

single p;
list AL;
matrix A;
vec b,*pX;
list *pN;

.SH DESCRIPTION
magfsssle() computes the solutions of the equation A*x=B.
In case there is no solution, the returned value is -1
and both *pX and *pN are empty lists.
If there is exactly one solution, it is assigned to *pX,
the returned value is zero and *pN is the empty list.
If there is more than one solution, *pX is an arbitrary
solution, the returned value is the dimension of the
null space and *pN is a list of basis vectors of the null space.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B A
is a mxn matrix over GF(p^n).
At least one entry of A must be non-zero.
.TP 4
.B b
is a vector of length m over GF(p^n).
.TP 4
.B *pX
is a vector of length n over GF(p^n),
representing nothing or a solution.
.TP 4
.B *pN
is a vector over GF(p^n),
representing nothing or a basis of the null space.
M*/



/*H
	Version 1       27.06.1990      Th. Weis
   DATE magfsssle     : 910915.9203__
H*/

#include <_matr2.h>

single magfsssle( p, AL, M, b, pX, pN )
single p;
list   AL;
matrix M;
vec    b, *pX;
list   *pN;

{
	list MZ;        /* eine Zeile von MT                            */
	list MSZ;
	list PZM;       /* durchlaeuft Pivotzeile von MS                */
	list PZMT;      /* aktuelle Pivotzeile von MS                   */
	list Hz;        /* Hilfszeile zum Vertauschen                   */
	list R = _0, RR, N;

	matrix MS;      /* durchlaeuft MT; falls MT=(Z1,..,Zn), dann    */
			/* ist fuer i=1..n MS=(Zi,..,Zn)                */
	matrix MT;
	matrix MTS;     /* durchlaeuft MT zum Aufbau der neuen Untermat.*/
	matrix Mlauf;
	matrix M1;

	gfel A;
	gfel AA;
	gfel B;
	gfel BB;
	gfel eins;

	vec bb, X, x, xx;

	single fertig = 0;
	single SpalteIs0;
	single k = 0;
	single Istloesbar = 1;
	single i, j, l, m, n, r;

	bind ( AL, M, b, R );
	init ( eins, MT, MS, N, MZ );
	init ( A, AA, B, BB, X, x );

	MS = MT = macopy( M );
	Mlauf = M = linv( lcinv( MT ) );
	eins = list2( 0, 1 );
	n = manrcol( M );
	m = manrrow( M );

/* Anhaengen von b an M */

	while ( b != _0 )
	{
	   M1 = list1( lfirst( b ) );
	   lconc( lfirst( MS ), M1 );
	   b = lred( b );
	   MS = lred( MS );
	}

/* Gauss-Schritt nach unten, bringe M auf obere Dreiecksgestalt */

	while ( !fertig && lred( MT ) != _0 )
	{

/* Suche ein Element != 0. Falls alle 0, und MT nur noch aus dem Rest   */
/* besteht, fertig */

	   SpalteIs0 = 1;
	   while ( SpalteIs0 )
	   {
	      k = 0;
	      if ( lred( lfirst( MT ) ) == _0 )
	      {
	         fertig = 1;
	         break;
	      }
	      else
	      {
	         MS = MT;
	         while( MS !=_0 && lfirst( lfirst( MS ) ) == 0 )
	         {
	            MS = lred( MS );
	            k++;
	         }
	         if ( MS == _0 )
	         {

/* Alle Elemente der ersten Spalte von MT sind 0, ruecke MT um eins nach*/
/* rechts */

	            MS = MT;
	            while ( MS != _0 )
	            {
	               lsfirst( MS, lred( lfirst( MS ) ) );
	               MS = lred( MS );
	            }
	         }
	         else
	         {

/* In der ersten Spalte von MT existiert ein Element != 0 in der Zeile  */

	            MZ = lfirst( MS );
	            SpalteIs0 = 0;
	         }
	      }
	   }
	   if ( fertig ) break;
	   if ( MS != MT )
	   {

/* Tausch, so dass MT(1,1) != 0. */

	      Hz = lfirst( MT );
	      lsfirst( MT, MZ );
	      lsfirst( MS, Hz );

/* Tausch auch in M */

	      Hz = lfirst( Mlauf );
	      MS = lreduct( Mlauf, k );
	      lsfirst( Mlauf, lfirst( MS ) );
	      lsfirst( MS, Hz );
	   }
	   Mlauf = lred( Mlauf );
/* A != 0 */    A = lfirst( MZ );
	   lsfirst( MZ, eins );
	   PZMT = MZ = lred( MZ );

/* Dividiere Zeile MZ durch A */

	   while ( MZ != _0 )
	   {
	      lsfirst( MZ, gfsquot( p, AL, lfirst( MZ ), A ) );
	      MZ = lred( MZ );
	   }
	   MT = MS = lred( MT );
	   while( MS != _0 )
	   {
	      PZM = PZMT;
	      MZ = lfirst( MS );
	      B = gfsneg( p, AL, lfirst( MZ ) );
	      lsfirst( MZ, 0 );
	      lsfirst( MS,MZ );
	      MZ = lred( MZ );
	      MS = lred( MS );
	      if ( B )
	      {
	         while ( MZ != _0 )
	         {
	            AA = gfsprod( p, AL, lfirst( PZM ), B );
	            PZM = lred( PZM );
	            BB = gfssum( p, AL, lfirst( MZ ), AA );
	            lsfirst( MZ, BB );
	            MZ = lred( MZ );
	         }
	      }
	   }
	} 
	if ( !fertig )
	{
	   MZ = lfirst( MT );
	   while ( MZ != _0 && lfirst( MZ ) == 0 ) MZ = lred( MZ );
	   if ( MZ != _0 && ( A = lfirst( MZ ) ) )
	   {
	      lsfirst( MZ, eins );
	      MZ = lred( MZ );
	      while ( MZ != _0 )
	      {
	         lsfirst( MZ, gfsquot( p, AL, lfirst( MZ ), A ) );
	         MZ = lred( MZ );
	      }
	   }
	}
	MT = M = linv( M );
	while ( M != _0 )
	{
	   MZ = lfirst( M );
	   M = lred( M );
	   k = 0;
	   while ( MZ != _0 && lfirst( MZ ) == 0 )
	   {
	      MZ = lred( MZ );
	      k++;
	   }

/* Das (k+1)te Element von MZ ist != 0, sogar = 1 */

	   if ( MZ != _0 )
	   {
	      if ( k < n )
	      {
	         R = lcomp( k+1, R );
	         PZM = lred( MZ );
	         MS = M;
	         while ( MS != _0 )
	         {
	            MSZ = lreduct( lfirst( MS ), k );
	            MS = lred( MS );
	            B = gfsneg( p, AL, lfirst( MSZ ) );
	            if ( B )
	            {
	               lsfirst( MSZ, 0 );
	               MSZ = lred( MSZ );
	               MZ = PZM;
	               while ( MZ != _0 )
	               {
	                  AA = lfirst( MZ );
	                  AA = gfsprod( p, AL, AA, B );
	                  BB = lfirst( MSZ );
	                  BB = gfssum( p, AL, BB, AA );
	                  lsfirst( MSZ, BB );
	                  MZ = lred( MZ );
	                  MSZ = lred( MSZ );
	               }
	            }
	         }
	      }
	   }
	}
	R = linv( R );
	r = llength( R );
	M = MT; 
	for ( MS = M /*,b=_0*/; MS != _0; MS = lred( MS ) )
	{
	   MZ = lreduct( lfirst( MS ), n-1 );
	   b = lcomp( lsecond( MZ ), b );
	   lsred( MZ, _0 );
	}
	b = linv( b );
	for ( i = m - r; i --> 0; b = lred( b ), M = lred( M ) )
	   if ( lfirst( b ) )
	   {
	      Istloesbar = 0;
	      break;
	   }     
	if ( Istloesbar )
	{

/* Eine spezielle Loesung */

	   for ( RR = R, i = n, bb = b, X = _0; i > 0; i-- )
	      if ( RR != _0 && i == lfirst( RR ) )
	      {
	         X = lcomp( lfirst( bb ), X );
	         RR = lred( RR );
	         bb = lred( bb );
	      }
	      else X = lcomp( 0, X );
	   for ( N = _0, i = n - r; i > 0; i-- )
	   {
	      for ( x = _0, j = n, l = 0, RR = R, MS = M; j > 0; j-- )
	      {
	         if ( RR != _0 && j == lfirst( RR ) )
	         {
	            A = 0;
	            MZ = lreduct( lfirst( MS ), j );
	            xx = x;
	            while ( xx != _0 )
	            {
	               B = lfirst( xx );
	               B = gfsprod( p, AL, B, lfirst( MZ ) );
	               A = gfsdif( p, AL, A, B );
	               xx = lred( xx );
	               MZ = lred( MZ );
	            }
	            x = lcomp( A, x );
	            MS = lred( MS );
	            RR = lred( RR );
	         }
	         else x = lcomp( ++l == i? eins: 0, x );
	      }
	      N = lcomp( x, N );
	   }
	   *pX = X;
	   *pN = N;
	   r = n - r;
	}
	else
	{
	   *pX = *pN = _0;
	   r = -1;
	}
	return( r );
}
