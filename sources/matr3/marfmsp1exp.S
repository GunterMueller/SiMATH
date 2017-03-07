/*M
.SH NAME
marfmsp1exp - matrix of rational functions over modular single primes, transcendence degree 1, exponentiation

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfmsp1exp(p, M, n)
single p;
matrix M;
single n;

.SH DESCRIPTION
marfmsp1exp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
must be a square matrix of rational functions in one variable over Z/pZ.
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
   DATE marfmsp1exp   : 890801.9109__.941201
H*/

#include <_matr3.h>

matrix marfmsp1exp(p,M,n)
single p;
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
		M1 = marfmsp1c1( p, m );
	}
/* M gleich 0 */

	else if (isnullma(M)) M1 = M;

/* n,M ungleich 0 */

	else
	{       if( n<0 )
		{       M = marfmsp1inv( p, M );
			n = -n;
		}
		m = manrrow( M );
		for (M1 = marfmsp1c1( p, m ); n; n /= 2) /* Binaeres Potenzieren */
                {
                      if (n%2) M1 = marfmsp1prod(p,M1,M);

                      if (n != 1) M = marfmsp1prod(p,M,M);
                }

	}

/* Ausgabe */

	return(M1);
}



