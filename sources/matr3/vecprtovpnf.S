/*M
.SH NAME
vecprtovpnf - vector of polynomials over the rational numbers to vector of polynomials over number field

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecprtovpnf(r, V)
single r;
vec V;

.SH DESCRIPTION
vecprtovpnf() returns the vector V with all entries converted
to polynomials in r variables over a number field.

.SH SEE ALSO
prtopnf
M*/








/*H
	Version 1       30.04.1992      U.Schneiders
   DATE vecprtovpnf   : 921130
H*/

#include <_matr3.h>

vec vecprtovpnf( r, V )
single r;
vec    V;

{
	vec    L;
	pol    a;

	bind( V );
	init( L, a );

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen ueber Q */
/* in den Vektor L von Polynomen in r Variablen ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   a = prtopnf( r, a );
	   L = lcomp( a, L );
	   V = lred( V );
	}
	L = linv( L );

	return( L );
}


