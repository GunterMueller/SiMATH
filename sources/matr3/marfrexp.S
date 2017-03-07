/*M
.SH NAME
marfrexp - matrix of rational functions over the rational numbers, exponentiation

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfrexp(r, M, n)
single r;
matrix M;
single n;

.SH DESCRIPTION
marfrexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.


.PP
.TP 4
.B M
must be a square matrix of rational functions in r variables over the rational numbers.
.TP 4
.B n
with -BASIS+1 <= n <= BASIS-1 is the exponent of the result.
M*/





/*H
	Version 1       01.06.1989      U.Schneiders, Th. Weis
	Version 2       27.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE marfrexp      : 890801.9109__.941201
H*/

#include <_matr3.h>

matrix marfrexp(r,M,n)
single r;
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
		M1 = marfrcons1( r, m );
	}
/* M gleich 0 */

	else if (isnullma(M)) M1 = M;

/* n,M ungleich 0 */

	else
	{       if( n<0 )
		{       M = marfrinv( r, M );
			n = -n;
		}
		m = manrrow( M );
		for (M1 = marfrcons1( r, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = marfrprod(r,M1,M);

                      if (n != 1) M = marfrprod(r,M,M);
                }

	}

/* Ausgabe */

	return(M1);
}



