/*M
.SH NAME
vecrtovecnf - vector over the rational numbers to vector of number field elements

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecrtovecnf(V)
vec V;

.SH DESCRIPTION
vecrtovecnf() returns the vector V with all entries converted to
number field elements in dense representation.

.PP
.TP
.B V
is a vector over the rational numbers.

.SH SEE ALSO
rtonf
M*/




/*H
	Version 1       18.07.1990      Th. Weis
   DATE vecrtovecnf   : 910915
H*/

#include <_matr2.h>

vec vecrtovecnf( V )
vec V;

{
	nfel b;
	rat  a;
	vec  L;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V ueber Q in den Vektor L ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = rtonf( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
