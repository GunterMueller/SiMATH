/*M
.SH NAME
martomanf - matrix over the rational numbers to matrix of number field elements

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix martomanf(M)
matrix M;

.SH DESCRIPTION
martomanf() returns the matrix M with all entries converted to
number field elements in dense representation.

.PP
.TP
.B M
is a matrix over the rational numbers.

.SH SEE ALSO
rtonf
M*/



/*H
	Version 1       18.07.1990      Th. Weis
   DATE martomanf     : 910915
H*/

#include <_matr2.h>

matrix martomanf( M )
matrix M;

{
	list   ZM, ZL;
	matrix L;
	rat    a;
	nfel   b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M ueber Q in die Matrix L ueber einem Zahlkoerper */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = rtonf( a );
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
