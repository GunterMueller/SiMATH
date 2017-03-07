/*M
.SH NAME
magf2tomagfs - matrix over Galois-field with characteristic 2 to matrix over Galois-field with single characteristic 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix magf2tomagfs(G, M) 
pol G;
matrix M;

.SH DESCRIPTION
magf2tomagfs() returns the matrix M with each coefficient represented 
as a sparse-polynomial (type gfel) over Z/2Z.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in GF(2^n)^(i,j).
M*/

/*H
	Version  1      08.03.1996      S.Schmitt
   DATE magf2tomagfs  : 960501
H*/
 
#include <_matr3.h>

matrix magf2tomagfs(G,M)
pol G;
matrix M;
{	matrix N;
	list V,W;
	obj k;
	init(N,V,W,k);
	bind(G,M);

	N=_0;
	while(M!=_0)
	{	V=lfirst(M);
		M=lred(M);
		W=_0;
		while(V!=_0)
		{	k=lfirst(V);
			V=lred(V);	
			k=gf2eltogfsel(G,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


