/*M
.SH NAME
vecptovecdp - vector of polynomials to vector of dense polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecptovecdp(r, V)
single r;
vec V;

.SH DESCRIPTION
vecptovecdp() returns the vector V with all entries converted to
dense polynomials in r variables.

.PP
.TP
.B V
is a vector of (sparse) polynomials in r variables.
M*/




/*H
	Version 1       19.07.1990      Th. Weis
   DATE vecptovecdp   : 910915
H*/

#include <_matr1.h>

vec vecptovecdp( r, V )
single r;
vec    V;

{
	vec L;
	pol a, b;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen */
/* in den Vektor L von Polynomen in r Variablen in dense-Darstellung. */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = ptodp( r, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
