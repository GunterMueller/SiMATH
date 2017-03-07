/*M
.SH NAME
mudpitudpmi - matrix of univariate dense polynomials over integers to matrix of univariate dense polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mudpitudpmi(M, m)
matrix M;
int m;

.SH DESCRIPTION
mudpitudpmi() returns the matrix M with all entries converted to
univariate dense polynomials over Z/mZ.

.PP
.TP 4
.B M
is a matrix of of univariate dense polynomials over integers.

.SH SEE ALSO
udpitoudpmi
M*/
/*H
	Version 1       19.07.1990      Th. Weis
   DATE mudpitudpmi   : 910915
H*/

#include <_matr1.h>

matrix mudpitudpmi( M, m )
matrix M;
int    m;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M, m );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in einer Variablen ueber Z, */
/* in dense-Darstellung, in die Matrix L von Polynomen in einer Variablen ueber */
/* Z/m*Z, in dense-Darstellung */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = udpitoudpmi( a, m );
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
