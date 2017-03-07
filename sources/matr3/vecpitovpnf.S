/*M
.SH NAME
vecpitovpnf - vector of polynomials over integers to vector of polynomials over  number field

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpitovpnf(r, V)
single r;
vec V;

.SH DESCRIPTION
vecpitovpnf() returns the vector V with all entries converted
to polynomials in r variables over a number field.

.SH SEE ALSO
pitopnf
M*/





/*H
	Version 1       19.07.1990      Th. Weis
   DATE vecpitovpnf   : 910915
H*/

#include <_matr3.h>

vec vecpitovpnf( r, V )
single r;
vec    V;

{
	vec    L;
	pol    a, b;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen ueber Z */
/* in den Vektor L von Polynomen in r Variablen ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = pitopnf( r, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}


