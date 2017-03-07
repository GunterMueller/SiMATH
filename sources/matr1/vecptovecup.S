/*M
.SH NAME
vecptovecup - vector of polynomials to vector of univariate polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecptovecup(r, V)
single r;
vec V;

.SH DESCRIPTION
vecptovecup() returns the vector V with all entries converted to
univariate polynomials.

.PP
.TP 4
.B V
is a vector of polynomials in r variables.

.SH SEE ALSO
ptoup
M*/



/*H
	Version 1       19.07.1990      Th. Weis
   DATE vecptovecup   : 910915
H*/

#include <_matr1.h>

vec vecptovecup( r, V )
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
/* in den Vektor L von Polynomen in einer Variablen */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = ptoup( r, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
