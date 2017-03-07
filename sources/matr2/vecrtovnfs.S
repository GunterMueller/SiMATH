/*M
.SH NAME
vecrtovnfs - vector over the rational numbers to vector of number field elements, sparse representation

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecrtovnfs(V)
vec V;

.SH DESCRIPTION
vecrtovnfs() returns the vector V with all entries converted to
number field elements in sparse representation.

.PP
.TP
.B V
is a vector over the rational numbers.

.SH SEE ALSO
rtonfs
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE vecrtovnfs    : 910915
H*/

#include <_matr2.h>

vec vecrtovnfs( V )
vec V;

{
	nfel   b;
	rat    a;
	vec    L;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V ueber Q in den Vektor L ueber einem Zahlkoerper */
/* in sparse-Darstellung */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = rtonfs( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
