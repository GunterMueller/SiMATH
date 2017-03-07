/*M
.SH NAME
magfstomagf2 - matrix over Galois-field with single characteristic to matrix over Galois-field with characteristic 2 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix magfstomagf2(G, M) 
pol G;
matrix M;

.SH DESCRIPTION
magfstomagf2() returns the matrix M with each coefficient represented 
an element of GF(2^n), that means as polynomials in one variable over
Z/2Z of degree<n in special bit-representation (type gf2el).

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in GF(2^n)^(i,j).
M*/
/*H
	Version  1      14.03.1996      S.Schmitt
  DATE magfstomagf2   : 960501
H*/

#include <_matr3.h>

matrix magfstomagf2(G,M)
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
			k=gfseltogf2el(G,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


