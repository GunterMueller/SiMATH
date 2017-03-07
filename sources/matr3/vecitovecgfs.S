/*M
.SH NAME
vecitovecgfs - vector over integers to vector over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecitovecgfs(p, V)
single p;
vec V;

.SH DESCRIPTION
vecitovecgfs() returns the vector V with all entries converted
to elements of the finite field  GF(p^n).
M*/





/*H
	Version 1	03.06.93	S.Schmitt
   DATE vecitovecgfs  : 931130
H*/


#include <_matr3.h>

vec vecitovecgfs(p,V)
single p;
vec V;
{	vec W;
	obj k;
	init(W,k);
	bind(V);

	W=_0;
	while(V!=_0)
	{	k=lfirst(V);
		V=lred(V);
		k=mshom(p,k);
		if(k) k=list2(0,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


