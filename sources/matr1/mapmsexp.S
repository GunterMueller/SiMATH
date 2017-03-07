/*M
.SH NAME
mapmsexp - matrix of polynomials over modular singles, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmsexp(r, m, M, n)
single r, m;
matrix M;
single n;

.SH DESCRIPTION
mapmsexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix of polynomials in r variables over Z/mZ.
M*/
/*H
	Version 1       05.06.1990	Th. Weis
        Version 2       26.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE mapmsexp      : 910915.9203__.941201
H*/

#include <_matr1.h>

matrix mapmsexp( r, m, M, n )
single r, m;
matrix M;
single n;

{
	matrix M1;
	single l;

	bind( M );
	init( M1 );

/* n gleich 0 */

	if ( !n )
	{
	   l = manrrow( M );
	   M1 = mapmscons1( r, m, l );
	}

/* M gleich 0 */

	else if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

	     else
	     {
		if ( n < 0 )
		{
		   M = mapmsinv( r, m, M );
		   n = -n;
		}
	        l = manrrow( M );
		for (M1 = mapmscons1(r, m, l); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = mapmsprod(r, m, M1, M);

                      if (n != 1) M = mapmsprod( r, m, M, M );
                }

	     }

/* Ausgabe */

	return( M1 );
}

