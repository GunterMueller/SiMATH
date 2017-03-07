/*M
.SH NAME
madptomap - matrix of dense polynomials to matrix of polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix madptomap(r, M)
single r;
matrix M;

.SH DESCRIPTION
madptomap() returns the matrix M with all entries converted to
(sparse) polynomials in r variables.

.PP
.TP
.B M
is a matrix of dense polynomials in r variables.
M*/
/*H
	Version 1       07.01.1991      Th. Weis
   DATE madptomap     : 910915
H*/

#include <_matr1.h>

matrix madptomap( r, M )
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
/* in dense-Darstellung in die Matrix L von Polynomen in r Variablen in */
/* rekursiver Darstellung. */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = dptop( r, a );
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
