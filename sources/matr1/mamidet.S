/*M
.SH NAME
mamidet - matrix of modular integers, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

int mamidet(m, M)
int m;
matrix M;

.SH DESCRIPTION
mamidet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix over Z/mZ.
M*/


/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE mamidet       : 920331
H*/

#include <_matr1.h>

int mamidet (mi,M)
int mi;
matrix M;

{
	return (mihom(mi,maidet(M)));
}
