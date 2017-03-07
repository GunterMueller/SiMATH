/*M
.SH NAME
vudprtovnf - vector of univariate dense polynomials over the rational numbers to vector of number field elements

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vudprtovnf(V)
vec V;

.SH DESCRIPTION
vudprtovnf() returns the vector V with all entries converted to
number field elements in dense representation.
.PP
.TP
.B V
is a vector of univariate dense polynomials over the rational numbers.

.SH SEE ALSO
udprtonfel
M*/





/*H
	Version 1       18.07.1990      Th. Weis
   DATE vudprtovnf    : 910915
H*/

#include <_matr2.h>

vec vudprtovnf( V )
vec V;

{
	nfel   b;
	pol    a;
	vec    L;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in einer Variablen ueber Q, */
/* in dense-Darstellung, in den Vektor L ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = udprtonfel( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
