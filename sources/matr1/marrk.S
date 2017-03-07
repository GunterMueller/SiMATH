/*M
.SH NAME
marrk - matrix of rational numbers, rank

.SH SYNOPSIS
.nf
#include<_matr1.h>

single marrk(M)
matrix M;

.SH DESCRIPTION
marrk() returns the rank of the matrix M, computed using Gauss elimination.

.PP
.TP 4
.B M
is a matrix of rational numbers.
M*/
/*H
	Version 1       30.08.1990      Th. Weis
   DATE marrk         : 910915
H*/

#include <_matr1.h>

single marrk( M )
matrix M;
{
	list MZ;        /* eine Zeile von MT                            */
	list PZM;       /* durchlaeuft Pivotzeile von MS                */
	list PZMT;      /* aktuelle Pivotzeile von MS                   */
	list Hz;        /* Hilfszeile zum Vertauschen                   */

	matrix MS;      /* durchlaeuft MT; falls MT=(Z1,..,Zn), dann    */
	      /* ist fuer i=1..n MS=(Zi,..,Zn)                */
	matrix MT;
	matrix MTS;     /* durchlaeuft MT zum Aufbau der neuen Untermat.*/
	matrix Mlauf;
	matrix M1;

	rat A, AA;
	rat B, BB;
	rat eins;

	single SpalteIs0;
	single fertig = 0;
	single rang = 0;
	single k = 0;
	single i, m;

	bind( M );
	init( eins, MT, MS, MZ );
	init( A, AA, B, BB );

	MS = MT = macopy( M );
	Mlauf = M = linv( lcinv( MT ) );
	eins = list2( 1, 1 );
	m = manrrow( M );

/* Anhaengen des 0-Vektors der Laenge m an M */

	for ( i = 0; i < m; i++ )
	{
	   M1 = list1( 0 );
	   lconc( lfirst( MS ), M1 );
	   MS = lred( MS );
	}

/* Gauss-Schritt nach unten, bringe M auf obere Dreiecksgestalt */

	while ( !fertig && lred( MT ) != _0 )
	{

/* Suche ein Element != 0. */
/* Falls alle 0, und MT nur noch aus dem Rest besteht, fertig */

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
	         while( MS != _0 && lfirst( lfirst( MS ) ) == 0 )
	         {
	            MS = lred( MS );
	            k++;
	         }
	         if ( MS == _0 )
	         {

/* Alle Elemente der ersten Spalte von MT sind 0, */
/* ruecke MT um eins nach rechts */

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

/* A != 0 */
	   A = lfirst( MZ );
	   lsfirst( MZ, eins );
	   rang = rang + 1;
	   PZMT = MZ = lred( MZ );

/* Dividiere Zeile MZ durch A */

	   while ( MZ != _0 )
	   {
	      lsfirst( MZ, rquot( lfirst( MZ ), A ) );
	      MZ = lred( MZ );
	   }
	   MT = MS = lred( MT );
	   while ( MS != _0 )
	   {
	      PZM = PZMT;
	      MZ = lfirst( MS );
	      B = rneg( lfirst( MZ ) );
	      lsfirst( MZ, 0 );
	      lsfirst( MS, MZ );
	      MZ = lred( MZ );
	      MS = lred( MS );
	      if ( B )
	      {
	         while( MZ != _0 )
	         {
	            AA = rprod( lfirst( PZM ), B );
	            PZM = lred( PZM );
	            BB = rsum( lfirst( MZ ), AA );
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
	      rang = rang + 1;
	      MZ = lred( MZ );
	      while ( MZ != _0 )
	      {
	         lsfirst( MZ, rquot( lfirst( MZ ), A ) );
	         MZ = lred( MZ );
	      }
	   }
	}

/* Ausgabe */

	return( rang );
}
