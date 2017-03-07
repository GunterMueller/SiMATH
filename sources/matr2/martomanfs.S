/*M
.SH NAME
martomanfs - matrix over the rational numbers to matrix of number field elements, sparse representation

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix martomanfs(M)
matrix M;

.SH DESCRIPTION
martomanfs() returns the matrix M with all entries converted to
number field elements in sparse representation.

.PP
.TP
.B M
is a matrix over the rational numbers.

.SH SEE ALSO
rtonfs
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE martomanfs    : 910915
H*/

#include <_matr2.h>

matrix martomanfs( M )
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
/* in sparse-Darstellung */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = rtonfs( a );
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
