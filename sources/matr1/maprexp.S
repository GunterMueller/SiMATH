/*M
.SH NAME
maprexp - matrix of polynomials over the rational numbers, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprexp(r, M, n)
single r;
matrix M;
single n;

.SH DESCRIPTION
maprexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix of polynomials in r variables over the rational numbers.
M*/
/*H
	Version 1       31.10.1988      C.Hollinger/U.Schneiders
        Version 2       26.01.1994      Georg Rock
                                        Habe  induktives Potenzieren,d.h.
                                        A^n = A*A*A*A*A... (n-mal) durch
                                        binaeres Potenzieren ersetzt.
   DATE maprexp       : 890501.9311__.941201
H*/

#include <_matr1.h>

matrix maprexp(r,M,n)
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
		M1 = maprcons1( r, m );
	}
/* M gleich 0 */

	else if (isnullma(M)) M1 = M;

/* n,M ungleich 0 */

	else
	{       if( n<0 )
		{       M = maprinv( r, M );
			n = -n;
		}
                m = manrrow( M );
		for (M1 = maprcons1( r, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = maprprod( r, M1, M );

                      if (n != 1) M = maprprod( r, M, M );
                }

	}

/* Ausgabe */

	return(M1);
}


