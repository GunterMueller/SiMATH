/*M
.SH NAME
vecgfstovgf2 - vector over Galois-field with single characteristic to vector over Galois-field with characteristic 2 

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecgfstovgf2(G, V) 
pol G;
vec V;

.SH DESCRIPTION
vecgfstovgf2() returns the vector V with each coefficient represented 
an element of GF(2^n), that means as polynomials in one variable over
Z/2Z of degree<n in special bit-representation (type gf2el).

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in GF(2^n)^m with coefficients of type gfel.
M*/

/*H
	Version 1	14.03.1996	S.Schmitt
   DATE vecgfstovgf2  : 960501
H*/

#include <_matr3.h>

vec vecgfstovgf2(G,V)
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
		k=gfseltogf2el(G,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


