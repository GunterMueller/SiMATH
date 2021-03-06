/*M
.SH NAME
magfsinv - matrix of Galois-field with single characteristic elements, inverse

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsinv(p, AL, M)
single p;
list AL;
matrix M;

.SH DESCRIPTION
magfsinv() returns the matrix M^(-1).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
must be a square matrix over GF(p^n) with a non-zero determinant.
M*/


/*H
	Version 1       18.04.1990      Th. Weis
   DATE magfsinv      : 910915
H*/

#include <_matr2.h>

matrix magfsinv( p, AL, M )
single p;
list   AL;
matrix M;

{
	list MZ;        /* eine Zeile von MT                            */
	list MSZ;       /* eine Zeile von MS                            */
	list PZM;       /* durchlaeuft Pivotzeile von MS                */
	list PZMT;      /* aktuelle Pivotzeile von MS                   */
	list Hz;        /* Hilfszeile zum Vertauschen                   */

	matrix MS;      /* durchlaeuft MT; falls MT=(Z1,..,Zn), dann    */
			/* ist fuer i=1..n MS=(Zi,..,Zn)                */
	matrix MT;      /* bildet immer die nach einem Gauss-Schritt    */
			/* erhaltene Untermatrix                        */
	matrix MTS;     /* durchlaeuft MT zum Aufbau der neuen Untermat.*/
	matrix Mlauf;   /* durchlaeuft M, um beim Tauschen der Pivot-   */
			/* zeilen mit dem Index k auf die richtige Zeile*/
			/* zuzugreifen.                                 */

			/* Sind in einem Gauss-Schritt PZMT, bzw PZET   */
			/* die Pivotzeilen, und PZM, bzw PZE die noch   */
			/* zu bearbeitenden Reste, und MZ bzw EZ die    */
			/* aktuellen Zeilen, dann                       */
	gfel A;         /* A = lfirst(PZMT).    A = M(i,i)              */
	gfel AA;        /* AA = lfirst(PZM), bzw AA = lfirst(PZE).      */
			/* AA = M(i,j) bzw AA = ET(i,k)                 */
	gfel B;         /* B = lfirst(MZT).     B = M(l,i)              */
	gfel BB;        /* BB = lfirst(MZ), bzw BB = lfirst(EZ).        */
			/* BB = M(l,j) bzw BB = ET(l,k)                 */
	gfel eins;

	single k;
	single n;

	bind( M );
	init( A, B, AA, BB, eins, MT );

/* M wird mittels Gauss-Algorithmus invertiert. Erst wird MT auf untere */
/* Dreiecksgestalt gebracht, dann auf Diagonalgestalt.                  */

	MT = macopy( M );
	Mlauf = M = linv( lcinv( MT ) );
	n = manrcol( M );
	eins = list2( 0, 1 );
	maam( MT, eins );
	while ( lred( MT ) != _0 )
	{

/* Suche Pivot-Zeile */

	   MS = MT;
	   k = 0;
	   while ( MS != _0 && lfirst( lfirst( MS ) ) == 0 )
	   {
	      MS = lred( MS );
	      k++;
	   }

/* Setze aktuelle Zeilen und tausche */

	   MZ = lfirst( MS );
	   if ( MS != MT )
	   {
	      Hz = lfirst( MT );
	      lsfirst( MT, MZ );
	      lsfirst( MS, Hz );

/* Tausch auch in M */

	      Hz = lfirst( Mlauf );
	      MS = lreduct( Mlauf, k );
	      lsfirst( Mlauf, lfirst( MS ) );
	      lsfirst( MS, Hz );
	   }
	   A = lfirst( MZ );
	   PZMT = lred( MZ );
	   MTS = MS = lred( MT );
	   Mlauf = lred( Mlauf );

/* MS durchlaeuft MT unterhalb von MZ MT */

	   while( MS != _0 )
	   {
	      PZM = PZMT;
	      MZ = lfirst( MS );
	      MS = lred( MS );
	      B = lfirst( MZ );
	      lsfirst( MZ, 0 );
	      MZ = lred( MZ );
	      lsfirst( MTS, MZ );
	      MTS = lred( MTS );
	      if ( B )
	      {
	         B = gfsneg( p, AL, B );
	         while( MZ != _0 )
	         {
	            AA = lfirst( PZM );
	            AA = gfsprod( p, AL, AA, B );
	            PZM = lred( PZM );
	            BB = lfirst( MZ );
	            BB = gfsprod( p, AL, BB, A );
	            BB = gfssum( p, AL, BB, AA );
	            lsfirst( MZ, BB );
	            MZ = lred( MZ );
	         }
	      }
	   }
	   MT = lred( MT );
	}
	MT = M = linv( M );
	k = n - 1;
	while ( MT != _0 )
	{
	   MZ = lfirst( MT );
	   PZM = lreduct( MZ, k );
	   A = lfirst( PZM );
	   lsfirst( PZM, eins );
	   MZ = PZM = lred( PZM );
	   while ( MZ != _0 )
	   {
	      B = lfirst( MZ );
	      B = gfsquot( p, AL, B, A );
	      lsfirst( MZ, B );
	      MZ = lred( MZ );
	   }
	   MS = lred( MT );
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
	            BB = gfssum( p, AL, AA, BB );
	            lsfirst( MSZ, BB );
	            MZ = lred( MZ );
	            MSZ = lred( MSZ );
	         }
	      }
	   }
	   MT = lred( MT );
	   k--;
	}
	MT = M = linv( M );
	while (MT != _0)
	{
	   lsfirst( MT, lreduct( lfirst( MT ), n ) );
	   MT = lred( MT );
	}
	return( M );
}
