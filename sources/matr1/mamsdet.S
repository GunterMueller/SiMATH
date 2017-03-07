/*M
.SH NAME
mamsdet - matrix of modular singles, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

single mamsdet(m, M)
single m;
matrix M;

.SH DESCRIPTION
mamsdet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix over Z/mZ.
M*/


/*H
	Version 1       27.06.1988      Klaus Petry
	Version 2       11.10.1988      Klaus Petry     kein Macro mehr
   DATE mamsdet       : 890501.9203__
H*/

#include <_matr1.h>

single mamsdet (m,M)
single m;
matrix M;

{
	return (mihom(m,maidet(M)));
}
