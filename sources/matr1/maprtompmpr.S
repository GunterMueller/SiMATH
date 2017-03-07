/*M
.SH NAME
maprtompmpr - matrix of polynomials over the rational numbers to matrix of polynomials modulo polynomial over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprtompmpr(r, M, P)
single r;
matrix M;
pol P;

.SH DESCRIPTION
maprtompmpr() returns the matrix M with all entries
reduced modulo P.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over the rational numbers.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
M*/

/*H
	Version 1       25.10.1989      U. Schneiders/C.Hollinger
   DATE maprtompmpr   : 891101.9311__
H*/

# include <_matr1.h>

matrix maprtompmpr( r, M, P )
single r;
matrix M;
pol P;

{
	list ZM, ZL;
	pol a, b;
	matrix L;

	bind ( M,P );
	init( ZM, ZL, L, a, b);

	/*** M = ( aij ), Modulorechnung fuer aij ***/

	L = _0;
	while ( M != _0 )
	{       ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0)
		{       a = lfirst (ZM);
			a = prqrem( r, a, P, &b );
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
