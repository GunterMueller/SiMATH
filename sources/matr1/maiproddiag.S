/*M
.SH NAME
maiproddiag - matrix of integers, product of diagonal elements

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maiproddiag(M)
matrix M;

.SH DESCRIPTION
maiproddiag() returns the product of all
diagonal elements of the matrix M.

.PP
.TP 4
.B M
is a matrix of integers. M does not have to be square.
M*/




/*H
	Version 1	09.12.1993	Marc Conrad
   DATE maiproddiag   : 941201
H*/

#include<_matr1.h>

maiproddiag(M)
	matrix M;

{

	obj Z;
	int A;
	single i, j;


	bind(M);
	init(Z, A);

	A = 1;
	i = 1;
	while (M != _0) {
		Z = lfirst(M);
		M = lred(M);
		for (j = 1; j < i; j++) {
			if (Z != _0)
				Z = lred(Z);
			else
				return (A);
		}
		A = iprod(lfirst(Z), A);
		i++;
	}
	return (A);
}
