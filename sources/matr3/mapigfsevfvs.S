/*M
.SH NAME
mapigfsevfvs - matrix of polynomials over integers, Galois-field with single characteristic element, evaluation first variable, special version

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapigfsevfvs(r, p, AL, M)
single r,p;
list AL;
matrix M;

.SH DESCRIPTION
mapigfsevfvs() returns the matrix M with the first
variable of its variable list replaced by the
generating element of the finite field GF(p^n) determined by AL.
The result is a matrix of polynomials in r-1
variables over this finite field.
 
.PP
.TP 4
.B p
>2, must be prime.
.TP 4
.B AL
is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
M*/






/*H
	Version 1	03.06.93	S.Schmitt
   DATE mapigfsevfvs  : 931130
H*/


#include <_matr3.h>

matrix mapigfsevfvs(r,p,AL,M)
single r,p;
list AL;
matrix M;
{	matrix N;
	list V,W;
	obj k;
	init(N,V,W,k);
	bind(AL,M);

	N=_0;
	while(M!=_0)
	{	V=lfirst(M);
		M=lred(M);
		W=_0;	
		while(V!=_0)
		{	k=lfirst(V);
			V=lred(V);
			k=pigfsevalfvs(r,p,AL,k);
			W=lcomp(k,W);
		}
		W=linv(W);
		N=lcomp(W,N);
	}
	N=linv(N);
	return(N);
}


