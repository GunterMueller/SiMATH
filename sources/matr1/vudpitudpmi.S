/*M
.SH NAME
vudpitudpmi - vector of univariate dense polynomials over integers to vector of univariate dense polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vudpitudpmi(V, m)
vec V;
int m;

.SH DESCRIPTION
vudpitudpmi() returns the vector V with all entries converted to
univariate dense polynomials over Z/mZ.

.PP
.TP 4
.B V
is a vector of of univariate dense polynomials over integers.

.SH SEE ALSO
udpitoudpmi
M*/
/*H
	Version 1       19.07.1990      Th. Weis
   DATE vudpitudpmi   : 910915
H*/

#include <_matr1.h>

vec vudpitudpmi( V, M )
vec V;
int M;

{
	vec L;
	pol a, b;

	bind( V, M );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in einer Variablen ueber Z, */
/* in dense-Darstellung, in den Vektor L von Polynomen in einer Variablen ueber */
/* Z/M*Z, in dense-Darstellung */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = udpitoudpmi( a, M );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
