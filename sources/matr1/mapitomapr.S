/*M
.SH NAME
mapitomapr - matrix of polynomials over integers to matrix of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapitomapr(r, M)
single r;
matrix M;

.SH DESCRIPTION
mapitomapr() returns the matrix M with all entries converted to
polynomials in r variables over the rational numbers.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
M*/
/*H
	Version 1       14.11.1988      Klaus Petry
   DATE mapitomapr    : 890501
H*/


# include <_matr1.h>

matrix mapitomapr (r,  M)
single r;
matrix M;

{
	list ZM, ZL;
	pol a, b;
	matrix L;

	bind (M);
	init (ZL, L, b);

	L = _0;

	while (M != _0) {
		ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0) {
			a = lfirst (ZM);
			b = pitopr (r, a);
			ZL = lcomp (b, ZL);
			ZM = lred (ZM);
			}
		ZL = linv (ZL);
		L = lcomp (ZL, L);
		M = lred (M);
		}
	L = linv (L);

/* Ausgabe */

	return (L);
}
