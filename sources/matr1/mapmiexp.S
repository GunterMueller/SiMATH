/*M
.SH NAME
mapmiexp - matrix of polynomials over modular integers, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmiexp(r, m, M, n)
single r;
int m;
matrix M;
single n;

.SH DESCRIPTION
mapmiexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix of polynomials in r variables over Z/mZ.
M*/
/*H
	Version 1       31.01.1992	Bernd Mayr
        Version 2       26.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE mapmiexp      : 920331.941201
H*/

#include <_matr1.h>

matrix mapmiexp( r, m, M, n )
single r;
matrix M;
int m, n;

{
	matrix M1;
	int l;

	bind( M,m,n );
	init( M1,l );

/* n gleich 0 */

	if ( !n )
	{
	   l = manrrow( M );
	   M1 = mapmicons1( r, m, l );
	}

/* M gleich 0 */

	else if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

	     else
	     {
		if ( n < 0 )
		{
		   M = mapmiinv( r, m, M );
		   n = -n;
		}
                l = manrrow( M );
  	        for (M1 = mapmicons1(r, m, l); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = mapmiprod(r, m, M1, M);

                      if (n != 1) M = mapmiprod( r, m, M, M );
                }

	     }

/* Ausgabe */

	return( M1 );
}

