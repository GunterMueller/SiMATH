/*M
.SH NAME
mudpitmudpr - matrix of univariate dense polynomials over integers to matrix of univariate dense polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mudpitmudpr(M)
matrix M;

.SH DESCRIPTION
mudpitmudpr() returns the matrix M with all entries converted to
univariate dense polynomials over the rational numbers.

.PP
.TP 4
.B M
is a vector of of univariate dense polynomials over integers.

.SH SEE ALSO
udpitoudpr
M*/
/*H
	Version 1       19.07.1990      Th. Weis
   DATE mudpitmudpr   : 910915
H*/

#include <_matr1.h>

matrix mudpitmudpr( M )
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in einer Variablen ueber Z, */
/* in dense-Darstellung, in die Matrix L von Polynomen in einer Variablen ueber Q, */
/* in dense-Darstellung */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = udpitoudpr( a );
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
