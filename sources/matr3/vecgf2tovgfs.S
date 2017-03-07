/*M
.SH NAME
vecgf2tovgfs - vector over Galois-field with characteristic 2 to vector over Galois-field with single characteristic 

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecgf2tovgfs(G, V) 
pol G;
vec V;

.SH DESCRIPTION
vecgf2tovgfs() returns the vector V with each coefficient represented 
as a sparse-polynomial (type gfel) over Z/2Z.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in GF(2^n)^m.
M*/
/*H
	Version 1	08.03.1996	S.Schmitt
   DATE vecgf2tovgfs  : 960501
H*/

#include <_matr3.h>

vec vecgf2tovgfs(G,V)
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
		k=gf2eltogfsel(G,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


