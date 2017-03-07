/*M
.SH NAME
mam2exp - matrix over Z/2Z, special bit representation, exponentiation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2exp(M, n)
matrix M;
single n;

.SH DESCRIPTION
mam2exp() returns the matrix M^n.
For n<0 the determinant of M must be invertible.

.PP
.TP 4
.B M
must be a square matrix over Z/2Z in special bit representation.
M*/

/*H
	Veriosn 1	20.10.1995	Marc Conrad
   DATE mam2exp       : 951201
H*/

#include <_matr1.h>

/* Geplant:  Verbesserung durch Berechnen der Transponierten 
und dann Verwendung von mam2tprod */

matrix mam2exp( M, n )
matrix M;
single n;

{
	matrix M1;

	bind( M );
	init( M1);
	
	M1 = mam2um(lfirst(M) ); 

	if ( !n ) return( M1 ); 

	for ( ; n; n /= 2 ) /* Binaeres Potenzieren */
		{
		      if (n%2) M1 = mam2prod( M1, M );

		      if (n!= 1) M = mam2prod( M, M );
		}
	return( M1 );
}

