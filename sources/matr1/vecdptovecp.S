/*M
.SH NAME
vecdptovecp - vector of dense polynomials to vector of polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecdptovecp(r, V)
single r;
vec V;

.SH DESCRIPTION
vecdptovecp() returns the vector V with all entries converted to
(sparse) polynomials in r variables.

.PP
.TP
.B V
is a vector of dense polynomials in r variables.
M*/



/*H
	Version 1       19.07.1990      Th. Weis
   DATE vecdptovecp   : 910915
H*/

#include <_matr1.h>

vec vecdptovecp( r, V )
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
/* in dense-Darstellung in den Vektor L von Polynomen in r Variablen in */
/* rekursiver Darstellung. */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = dptop( r, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
