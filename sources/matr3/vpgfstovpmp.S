/*M
.SH NAME
vpgfstovpmp - vector of polynomials over Galois-field with single characteristic to vector of polynomials modulo polynomial over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpgfstovpmp(r, p, AL, P, V)
single r,p;
list AL;
pol P;
vec V;

.SH DESCRIPTION
vpgfstovpmp() returns  the vector V with all entries converted
to polynomials reduced modulo P.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B P
is a polynomial in r variables over GF(p^n).
M*/








/*H
	Version 1       28.07.1993	S.Schmitt
   DATE vpgfstovpmp   : 931130
H*/

#include <_matr3.h>

vec vpgfstovpmp( r, p, AL, P, V )
single r, p;
list AL;
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
		el = pgfsrem(r,p,AL,el,P);
		H  = lcomp(el,H);
	}
	if ( H != _0 ) V = linv(H);
	return(V);
}



