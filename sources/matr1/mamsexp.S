/*M
.SH NAME
mamsexp - matrix of modular singles, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamsexp(m, M, n)
single m;
matrix M;
single n;

.SH DESCRIPTION
mamsexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix over Z/mZ.
M*/
/*H
	Version 1	01.06.1990	Th. Weis
	Version 2	26.10.1993	Georg Rock
					Habe  induktives Potenzieren,d.h.
					A^n = A*A*A*A*A... (n-mal) durch
					binaeres Potenzieren ersetzt.
   DATE mamsexp	      : 910915.9203__.941201
H*/

#include <_matr1.h>

matrix mamsexp( m, M, n )
single m;
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
	   M1 = mamscons1( m, l );
	}

/* M gleich 0 */

	else if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

	     else
	     {
		if ( n < 0 )
		{
		   M = mamsinv( m, M );
		   n = -n;
		}

		l = manrrow( M );
		for ( M1 = mamscons1(m, l); n; n /= 2 ) /* Binaeres Potenzieren */
		{
		      if (n%2) M1 = mamsprod( m, M1, M );

		      if (n!= 1) M = mamsprod( m, M, M );
		}

	     }

/* Ausgabe */

	return( M1 );
}

