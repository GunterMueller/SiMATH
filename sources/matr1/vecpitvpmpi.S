/*M
.SH NAME
vecpitvpmpi - vector of polynomials over integers to vector of polynomials modulo polynomial over integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpitvpmpi(r, V, P)
single r;
vec V;
pol P;

.SH DESCRIPTION
vecpitvpmpi() returns the vector V with all entries
reduced modulo P.

.PP
.TP
.B V
is a vector of polynomials in r variables over integers.
.TP
.B P
is a polynomial in r variables over integers.
M*/
/*H
	Version  1      25.10.1989      U.Schneiders/C.Hollinger
   DATE vecpitvpmpi   : 891101.9011__.9311__
H*/

#include <_matr1.h>

vec vecpitvpmpi( r, V, P )
single r;
vec V;
pol P;

{
	pol b,el;
	vec H;
	init( b, H, el );
	bind( V,P );

	/*** V = ( vi ), Modulorechnung fuer vi ***/

	H = V;
	V = _0;
	while( H != _0 )
	{       el = lfirst( H );
		H = lred( H );
		el = piqrem( r, el, P, &b );
		V = lcomp( b, V );
	}
	V = linv( V );
	return( V );
}
