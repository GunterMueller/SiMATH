/*M
.SH NAME
vnftovudpr - vector of number field elements to vector of univariate dense polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vnftovudpr(F, V)
pol F;
vec V;

.SH DESCRIPTION
vnftovudpr() returns the vector V with all entries converted to
univariate dense polynomials over the rational numbers.

.PP
.TP
.B V
is a vector of number field elements.

.SH SEE ALSO
nfeltoudpr
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE vnftovudpr    : 910915
H*/

#include <_matr2.h>

vec vnftovudpr( F, V )
pol F;
vec V;

{
	nfel   a;
	pol    b;
	vec    L;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V ueber einem Zahlkoerper in den Vektor L von */
/* Polynomen in einer Variablen ueber Q, in dense-Darstellung */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = nfeltoudpr( a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
