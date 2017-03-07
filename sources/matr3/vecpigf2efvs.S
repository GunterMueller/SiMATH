/*M
.SH NAME
vecpigf2efvs - vector of polynomials over integers Galois-field with  characteristic 2 element, evaluation first variable, special version     

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpigf2efvs(r, G, V) 
single r;
pol G;
vec V;

.SH DESCRIPTION
vecpigf2efvs() returns the vector of polynomials in r-1
variables over GF(2^n) obtained by replacing the first
variable in the variable list of M with the generating
element of the finite field determined by G .
.PP
.TP 4
.B r
is the number of variables used in the polynomials over Z.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B  V
is a vector in (GF(2^n)[x_1,...,x_r])^m
M*/


/*H
	Version 1	29.02.96	S.Schmitt
   DATE vecpigf2efvs  : 960501
H*/

#include <_matr3.h>

vec vecpigf2efvs(r,G,V)
single r;
list G;
vec V;
{	vec W;
	obj k;
	init( W, k );
	bind( G, V );

	W=_0;
	while(V!=_0)
	{	k=lfirst(V);
		V=lred(V);
		k=pigf2evalfvs(r,G,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


