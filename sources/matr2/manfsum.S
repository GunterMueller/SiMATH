/*M
.SH NAME
manfsum - matrix of number field elements, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix manfsum(F, M, N)
pol F;
matrix M,N;

.SH DESCRIPTION
manfsum() returns the matrix M+N.

.PP
.PP
.TP 4
.B F
is an irreducible monic dense polynomial in one variable over Z.
.TP 4
.B M,N
M and M are matrices over the number field generated by F.
M and N must have equal dimensions.
M*/


/*H
	Version 1       22.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE manfsum       : 910915.941201
H*/
/*
	For the definition of manfsum please refer to the header file _matr2.h.
*/
