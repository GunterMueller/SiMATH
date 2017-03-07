/*M
.SH NAME
vecpmitovpmp - vector of polynomials over modular integers to vector of polynomials modulo polynomial over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmitovpmp(r, m, P, V)
single r;
int m;
pol P;
vec V;

.SH DESCRIPTION
vecpmitovpmp() returns the vector V with all entries
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
	Version 1       31.01.1992	Bernd Mayr
   DATE vecpmitovpmp  : 920331.9305__
H*/

#include <_matr1.h>

vec vecpmitovpmp( r, m, P, V )
single r;
int  m;
pol P;
vec V;
{
	pol el;
	vec H;
	init(el,H);
	bind(m,P,V);

	H = _0;
	while ( V != _0 ) {
	        el = lfirst(V);
		V  = lred(V);
		el = pmirem(r,m,el,P);
		H  = lcomp(el,H);
	}
	if ( H != _0 ) V = linv(H);
	return(V);
}
