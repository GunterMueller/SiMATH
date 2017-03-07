/*M
.SH NAME
maitomagf2 - matrix over integers to matrix over Galois-field with characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix maitomagf2(M) 
matrix M;

.SH DESCRIPTION
maitomagf2() returns the matrix M represented as a matrix over GF(2^n).
.PP
.TP 4
.B M
is a matrix in Z^(i,j).
M*/
/*H
	Version 1	29.02.96	S.Schmitt
   DATE maitomagf2    : 950501
H*/

#include <_matr3.h>

matrix maitomagf2(M)
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
			k=mshom(2,k);
			if(k)  
			{	k=list2(0,k);
				k=udpm2tosb(k);
			}
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


