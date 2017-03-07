/*M
.SH NAME
magfsdet - matrix of Galois-field with single characteristic elements, determinant

.SH SYNOPSIS
.nf
#include<_matr2.h>

gfel magfsdet(p, AL, M)
single p;
list AL;
matrix M;

.SH DESCRIPTION
magfsdet() returns the determinant det(M).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a square matrix over GF(p^n).
M*/
/*H                                                               
        Version 1       10.05.1990	Th. Weis
   DATE magfsdet      : 910915
H*/

#include <_matr2.h>

gfel magfsdet( p, AL, M )
single p;
list   AL;
matrix M;

{
	single i, j, v = 1;
	list   Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	gfel   H, P, P1, P1S, P1T, P2, P2S, P3;

	bind( AL, M );
	init( MT, Z1, Z2, Z3, H, P, P1, P1S, P1T, P2, P2S, P3 );

	P1T = 0; P = 1;

/* Schleife */

	while ( lred( M ) != _0 )
	{

/* Suche Pivot-Zeile */

	   MS = M;
	   i = 0;
	   do
	   {
	      i++;
	      Z1 = lfirst( MS );
	      MS = lred( MS );
	   }
	   while ( lfirst( Z1 ) == 0  &&  MS != _0 );

/* M hat nicht vollen Rang */

	   if ( !lfirst( Z1 ) ) { P = 0; break; }

/* Aktualisiere Vorzeichen */

	   if ( seven( i ) ) v = -v;

/* Berechne MT */

	   P1 = lfirst( Z1 );
	   Z1 = lred( Z1 );
	   MT = _0;
	   j = 0;
	   do
	   {
	      j++;
	      Z2 = lfirst( M );
	      M = lred( M );
	      if ( j != i )
	      {
	         P2 = lfirst( Z2 );
	         Z2 = lred( Z2 );
	         Z3 = _0;
	         Z1S = Z1;
	         do
	         {
	            P1S = lfirst( Z1S );
	            Z1S = lred( Z1S );
	            P2S = lfirst( Z2 );
	            Z2 = lred( Z2 );
	            P3 = gfsprod( p, AL, P1, P2S );
	            H = gfsprod( p, AL, P2, P1S );
	            P3 = gfsdif( p, AL, P3, H );
	            if ( P1T ) P3 = gfsquot( p, AL, P3, P1T );
	            Z3 = lcomp( P3, Z3 );
	         }
	         while ( Z1S != _0 );
	         MT = lcomp( Z3, MT );
	      }
	   }
	   while ( M != _0 );
	   P1T = P1;
	   M = MT;
	}
	if ( P )
	{
	   P = lfirst( lfirst( M ) );
	   if ( v < 0 ) P = gfsneg( p, AL, P );
	}

/* Ausgabe */

	return( P );
}
