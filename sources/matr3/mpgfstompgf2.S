/*M
.SH NAME
mpgfstompgf2 - matrix of polynomials over Galois-field with single characteristic to matrix of polynomials over Galois-field with characteristic 2 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpgfstompgf2(r, G, M) 
single r;
pol G;
matrix M;

.SH DESCRIPTION
mpgfstompgf2() returns the matrix M represented as a matrix over
polynomials over GF(2^n), that means the coefficients are
polynomials in one variable over  Z/2Z of degree <n in
special bit-representation (type gf2el).
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j) where the entries
are of type gfel.
M*/
/*H
	Version  1      14.03.1996      S.Schmitt
   DATE mpgfstompgf2  : 960501
H*/

#include <_matr3.h>

matrix mpgfstompgf2(r,G,M)
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
			k=pgfstopgf2(r,G,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


