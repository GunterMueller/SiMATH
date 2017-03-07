/*M
.SH NAME
macopy - matrix copy

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix macopy(M)
matrix M;

.SH DESCRIPTION
macopy() returns a copy of the matrix M.
M*/
/*H
	Version 1       14.07.1988              Klaus Petry
	Version 2       22.11.1988              Klaus Petry
   DATE macopy        : 890501
H*/


# include <_matr1.h>

matrix macopy(M)
matrix M;

{
	matrix N=0;

	bind(M,N);
	for (N=_0;M!=_0;M=lred(M)) N = lcomp(linv(lcinv(lfirst(M))),N);
	N = linv(N);

	return( N );
}
