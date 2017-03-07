/*M
.SH NAME
marexp - matrix of rational numbers, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix marexp(M, n)
matrix M;
single n;

.SH DESCRIPTION
marexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix of rational numbers.
M*/
/*H
	Version 1       31.10.1988      C.Hollinger/U.Schneiders
	Version 2       26.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE marexp        : 890501.9311__.941201
H*/

#include <_matr1.h>

matrix marexp(M,n)
matrix M;
single n;
{
	matrix M1;
	single m;
	bind(M);
	init(M1);

/* n gleich 0 */

	if (!n)
	{       m = manrrow( M );
		M1 = marcons1( m );
	}
/* M gleich 0 */

	else if ( isnullma(M) ) M1 = M;

/* n,M ungleich 0 */

	else
	{       if( n<0 )
		{       M = marinv( M );
			n = -n;
		}
		 m = manrrow( M );
		for (M1 = marcons1(m); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = marprod(M1,M);

                      if (n != 1) M = marprod( M,M );
                }

	}

/* Ausgabe */

	return(M1);
}


