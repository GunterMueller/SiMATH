/*M
.SH NAME
ismaeqel - is matrix of equal elements

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismaeqel(M, el)
matrix M;
obj el;

.SH DESCRIPTION
ismaeqel() returns 1, if all entries of the matrix M are equal to
the ring element el and 0 otherwise.
M*/
/*H
	Version 1       31.10.1988      Klaus Petry
   DATE ismaeqel      : 890501
H*/

#include <_matr1.h>

single ismaeqel (M, el)
matrix M;
obj el;

{
	list Z;

	bind (M, el);
	init (Z);

	while (M != _0) {
		Z = lfirst (M);
		M = lred (M);
		while (Z != _0) {
			if (!oequal (lfirst (Z), el)) return (0);
			Z = lred (Z);
			}
		}
	return (1);
}
