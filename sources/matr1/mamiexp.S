/*M
.SH NAME
mamiexp - matrix of modular integers, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamiexp(m, M, n)
int m;
matrix M;
single n;

.SH DESCRIPTION
mamiexp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix over Z/mZ.
M*/
/*H
	Version 1	31.01.1992	Bernd Mayr
	Version 2	27.10.1993	Exponent single statt int.  PS
	Version 3	26.10.1993	Georg Rock
					Habe  induktives Potenzieren,d.h.
					A^n = A*A*A*A*A... (n-mal) durch
					binaeres Potenzieren ersetzt.
   DATE mamiexp	      : 920331.931130.941201
H*/

#include <_matr1.h>

matrix mamiexp( mi, M, n )
int mi;
matrix M;
single n;

{
	matrix M1;
	int l;

	bind( M,mi );
	init( M1,l );

/* n gleich 0 */

	if ( !n )
	{
	   l = manrrow( M );
	   M1 = mamicons1( mi, l );
	}

/* M gleich 0 */

	else if ( isnullma( M ) ) M1 = M;

/* n, M ungleich 0 */

	     else
	     {
		if ( n < 0 )
		{
		   M = mamiinv( mi, M );
		   n = -n;
		}

		l = manrrow( M );
		for ( M1 = mamicons1( mi,l); n; n /= 2 ) /* Binaeres Potenzieren */
		{     
		      if (n%2) M1 = mamiprod( mi, M1, M );

		      if (n!= 1) M = mamiprod( mi, M, M );
		}
		      
			     
	     }

/* Ausgabe */

	return( M1 );
}

