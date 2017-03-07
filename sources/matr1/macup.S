/*M
.SH NAME
macup - matrix of coefficients of univariate polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix macup(n, L)
single n;
list L;

.SH DESCRIPTION
macup() returns the matrix M constructed from
the list of univariate polynomials.
Let L the list of univariate polynomials of degree <n.
Then M=((m[1,0], ... ,m[1,n-1]), ... ,(m[r,0], ... ,m[r,n-1]))
is the matrix of the coefficients of L1, ..., Lr.
I.e it holds for i= 1, ..., r that
.PP
Li = m[i,0] X^0 + m[i,1] X^1 + ... + m[i,n-1] X^(n-1).

.PP
.TP 4
.B L
= (L1,...,Lr), is a list of univariate polynomials of degree <n.
M*/
/*H
	Version 1       09.06.1987              Pascale Serf
	Version 2       05.01.1988              B. Weis
			Typ matrix eingefuehrt
   DATE macup         : 890501
H*/


# include <_matr1.h>

matrix macup(n,L)
single n;
list L;
{
	single i,k;
	matrix M;
	pol P;

	bind(L);
	init2(M,P);

	M = _0;
	while ( L != _0 ) {
		P = lfirst(L); L = lred(L);
		P = ptodp(1,P);
		k = lfirst(P);
		P = lred(P);
		for ( i=1 ; i<= n-k-1 ; i++ ) P = lcomp(0,P);
		M = lcomp(linv(P),M);
	}
	return(linv(M));
}
