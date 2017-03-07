/*M
.SH NAME
vudpitvudpr - vector of univariate dense polynomials over integers to vector of univariate dense polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vudpitvudpr(V)
vec V;

.SH DESCRIPTION
vudpitvudpr() returns the vector V with all entries converted to
univariate dense polynomials over the rational numbers.

.PP
.TP 4
.B V
is a vector of of univariate dense polynomials over integers.

.SH SEE ALSO
udpitoudpr
M*/
/*H
	Version 1       19.07.1990      Th. Weis
   DATE vudpitvudpr   : 910915
H*/

#include <_matr1.h>

vec vudpitvudpr( V )
vec V;

{
	vec L;
	pol a, b;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in einer Variablen ueber Z, */
/* in dense-Darstellung, in den Vektor L von Polynomen in einer Variablen ueber Q, */
/* in dense-Darstellung */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = udpitoudpr( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
