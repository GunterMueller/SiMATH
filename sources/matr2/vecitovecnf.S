/*M
.SH NAME
vecitovecnf - vector over integers to vector of number field elements

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecitovecnf(V)
vec V;

.SH DESCRIPTION
vecitovecnf() returns the vector V with all entries converted to
number field elements in dense representation.

.PP
.TP
.B V
is a vector over integers.

.SH SEE ALSO
itonf
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE vecitovecnf   : 910915
H*/

#include <_matr2.h>

vec vecitovecnf( V )
vec V;

{
	int    a;
	nfel   b;
	vec    L;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V ueber Z in den Vektor L ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = itonf( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
