/*M
.SH NAME
magfsexp - matrix of Galois-field elements with single characteristic, exponentiation

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsexp(p, AL, M, n)
single p;
list AL;
matrix M;
single n;

.SH DESCRIPTION
magfsexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
must be a square matrix over GF(p^n).
.TP 4
.B n
with -BASIS+1 <= n <= BASIS-1 is the exponent of the result.
M*/

/*H
	Version 1       05.06.1990      Th. Weis
	Version 2	27.10.1993	MAGFSCONS1 hat jetzt 3 Parameter.  PS
        Version 3       27.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE magfsexp      : 910915.931130.941201
H*/

#include <_matr2.h>

matrix magfsexp( p, AL, M, n )
single p;
list   AL;
matrix M;
single n;

{
	matrix M1;
	single m;

	bind( AL, M );
	init( M1 );

/* n gleich 0 */

	if ( !n )
	{
	   m = manrrow( M );
	   M1 = magfscons1( p, AL, m );
	}

/* M gleich 0 */

	else    if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

	   else
	   {
	      if ( n < 0 )
	      {
	         M = magfsinv( p, AL, M );
	         n = -n;
	      }
	      m = manrrow( M );
              for (M1 = magfscons1( p, AL, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = magfsprod( p, AL, M1, M );

                      if (n != 1) M = magfsprod( p, AL, M, M );
                }

	   }

/* Ausgabe */

	return( M1 );
}


