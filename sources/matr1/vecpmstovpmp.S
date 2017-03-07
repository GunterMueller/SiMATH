/*M
.SH NAME
vecpmstovpmp - vector of polynomials over modular singles to vector of polynomials modulo polynomial over modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmstovpmp(r, m, P, V)
single r, m;
pol P;
vec V;

.SH DESCRIPTION
vecpmstovpmp() returns the vector V with all entries
reduced modulo P.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over Z/mZ.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
M*/



/*H
	Version 1       15.12.89	J.Schmitt
   DATE vecpmstovpmp  : 901120.9203__.9305__
H*/

#include <_matr1.h>

vec vecpmstovpmp( r, m, P, V )
single r, m;
pol P;
vec V;
{
	pol el;
	vec H;
	init(el,H);
	bind(P,V);

	H = _0;
	while ( V != _0 ) {
	        el = lfirst(V);
		V  = lred(V);
		el = pmsrem(r,m,el,P);
		H  = lcomp(el,H);
	}
	if ( H != _0 ) V = linv(H);
	return(V);
}
