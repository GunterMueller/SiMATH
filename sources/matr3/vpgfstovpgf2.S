/*M
.SH NAME
vpgfstovpgf2 - vector of polynomials over Galois-field with single characteristic to  vector of polynomials over Galois-field with characteristic 2 

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpgfstovpgf2(r, G, V) 
single r;
pol G;
vec V;

.SH DESCRIPTION
vpgfstovpgf2() returns the vector V represented as a vector over
polynomials over GF(2^n), that means the coefficients are
polynomials in one variable over Z/2Z of degree <n in
special bit-representation (type gf2el).
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in (GF(2^n)[x_1,...,x_r])^m where the entries
are of type gfel.
M*/

/*H
	Version 1	14.03.1996	S.Schmitt
   DATE vpgfstovpgf2  : 960501
H*/

#include <_matr3.h>

vec vpgfstovpgf2(r,G,V)
single r;
pol G;
vec V;
{	vec W;
	obj k;
	init(W,k);
	bind(G,V);

	W=_0;
	while(V!=_0)
	{	k=lfirst(V);
		V=lred(V);
		k=pgfstopgf2(r,G,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


