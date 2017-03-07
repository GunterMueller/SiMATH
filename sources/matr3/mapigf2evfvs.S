/*M
.SH NAME
mapigf2evfvs - matrix of polynomials over integers Galois-field with characteristic 2, element evaluation first variable special version     

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapigf2evfvs(r, G, M) 
single r;
pol G;
matrix M;

.SH DESCRIPTION
mapigf2evfvs() returns the matrix of polynomials in r-1
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
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	29.02.96	S.Schmitt
   DATE mapigf2evfvs  : 960501
H*/

#include <_matr3.h>

matrix mapigf2evfvs(r,G,M)
single r;
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
			k=pigf2evalfvs(r,G,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


