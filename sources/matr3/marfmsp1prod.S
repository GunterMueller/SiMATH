/*M
.SH NAME
marfmsp1prod - matrix of rational functions over modular single primes, transcendence degree 1, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfmsp1prod(p,M,N)
single p;
matrix M,N;

.SH DESCRIPTION
marfmsp1prod() returns the matrix M*N.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B M,N
are matrices of rational functions in one variable over Z/pZ.
M and N must have compatible dimensions.
M*/







/*H
	Version 1       01.06.1989      U. Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE marfmsp1prod  : 890801.9109__.941201
H*/
/*
	For the definition of marfmsp1prod please refer to the header file _matr3.h.
*/


