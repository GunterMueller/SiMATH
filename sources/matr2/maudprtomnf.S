/*M
.SH NAME
maudprtomnf - matrix of univariate dense polynomials over the rational numbers to matrix of number field elements

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maudprtomnf(M)
matrix M;

.SH DESCRIPTION
maudprtomnf() returns the matrix M with all entries converted to
number field elements in dense representation.

.PP
.TP
.B M
is a matrix of univariate dense polynomials over the rational numbers.

.SH SEE ALSO
udprtonfel
M*/





/*H
	Version 1       18.07.1990      Th. Weis
   DATE maudprtomnf   : 910915
H*/

#include <_matr2.h>

matrix maudprtomnf( M )
matrix M;

{
	list   ZM, ZL;
	matrix L;
	nfel   b;
	pol    a;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in einer Variablen ueber Q, */
/* in dense-Darstellung, in die Matrix L ueber einem Zahlkoerper */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = udprtonfel( a );
	      ZL = lcomp( b, ZL );
	      ZM = lred( ZM );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M = lred( M );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
