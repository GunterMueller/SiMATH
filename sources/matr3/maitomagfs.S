/*M
.SH NAME
maitomagfs - matrix over integers to matrix over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix maitomagfs(p, M)
single p;
matrix M;

.SH DESCRIPTION
maitomagfs() returns the matrix M with all entries converted
to elements of the finite field  GF(p^n).
M*/






/*H
	Version 1	03.06.93	S.Schmitt
   DATE maitomagfs    : 931130
H*/


#include <_matr3.h>

matrix maitomagfs(p,M)
single p;
matrix M;
{	matrix N;
	list V,W;
	obj k;
	init(N,V,W,k);
	bind(M);

	N=_0;
	while(M!=_0)
	{	V=lfirst(M);
		M=lred(M);
		W=_0;
		while(V!=_0)
		{	k=lfirst(V);
			V=lred(V);	
			k=mshom(p,k);
			if(k)  k=list2(0,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


