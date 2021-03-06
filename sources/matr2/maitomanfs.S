/*M
.SH NAME
maitomanfs - matrix over integers to matrix of number field elements, sparse representation

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maitomanfs(M)
matrix M;

.SH DESCRIPTION
maitomanfs() returns the matrix M with all entries converted to
number field elements in sparse representation.

.PP
.TP
.B M
is a matrix over integers.

.SH SEE ALSO
itonfs
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE maitomanfs    : 910915
H*/

#include <_matr2.h>

matrix maitomanfs( M )
matrix M;

{
	list   ZM, ZL;
	matrix L;
	int    a;
	nfel   b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M ueber Z in die Matrix L ueber einem Zahlkoerper */
/* in sparse-Darstellung */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = itonfs( a );
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
