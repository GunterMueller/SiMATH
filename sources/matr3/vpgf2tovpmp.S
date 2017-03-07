/*M
.SH NAME
vpgf2tovpmp - vector of polynomials over Galois-field with characteristic 2 to vector of polynomials modulo polynomial over Galois-field with  characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpgf2tovpmp(r, G, P, V) 
single r;
pol G,P;
vec V;

.SH DESCRIPTION
vpgf2tovpmp() returns the vector V where the polynomials are
reduced modulo P.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in (GF(2^n)[x_1,...,x_r])^m.
.TP 4
.B P
is a polynomial in r variables over GF(2^n).
M*/
/*H
	Version 1       06.03.1996	S.Schmitt
   DATE vpgf2tovpmp   : 960501
H*/

#include <_matr3.h>

vec vpgf2tovpmp( r, G, P, V )
single r;
pol G, P;
vec V;
{
	pol el;
	vec H;
	init(el,H);
	bind(G,P,V);

	H = _0;
	while ( V != _0 ) {
	        el = lfirst(V);
		V  = lred(V);
		el = pgf2rem(r,G,el,P);
		H  = lcomp(el,H);
	}
	if ( H != _0 ) V = linv(H);
	return(V);
}



