/*M
.SH NAME
maptomadp - matrix of polynomials to matrix of dense polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maptomadp(r, M)
single r;
matrix M;

.SH DESCRIPTION
maptomadp() returns the matrix M with all entries converted to
dense polynomials in r variables.

.PP
.TP
.B M
is a matrix of (sparse) polynomials in r variables.
M*/
/*H
	Version 1       07.01.1991      Th. Weis
   DATE maptomadp     : 910915
H*/

#include <_matr1.h>

matrix maptomadp( r, M )
single r;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen */
/* in die Matrix L von Polynomen in r Variablen in dense-Darstellung. */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = ptodp( r, a );
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
