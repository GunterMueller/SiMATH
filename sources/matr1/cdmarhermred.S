/*M
.SH NAME
cdmarhermred - common denominator matrix of rational numbers, hermitian reduction

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix cdmarhermred(M)
matrix M;

.SH DESCRIPTION
Let k be the least common multiple of all non-zero entries of M.
Let Mint be the matrix k*M, i.e. a matrix of integers.
The number of columns of Mint must be equal to the rank of Mint.
Let R be the module generated by the rows of Mint over integers.
Finally, let Mred be the square upper triangular matrix over integers,
whose rows form a Z-basis of R in Hermite normal form.

Then cdmarhermred() returns the matrix Mr = (1/k) * Mred of rational numbers.

.PP
.TP 4
.B M
is a CD-matrix of of rational numbers, see cdmarid.

.SH SEE ALSO
cdmarid, cdmarfmsp1id
M*/
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdmarhermred  : 891101.9001__
H*/

#include<_matr1.h>

matrix cdmarhermred(M)
matrix M;
{
	matrix M1, M2, Mz;
	int z, ml, D;
	bind(M);
	init(z,ml,D,M1,M2,Mz);

	M1 = M;
	ml = 1;
	while (M1 != _0) {
		Mz = lfirst(M1);
		M1 = lred(M1);
		z = lfirst(Mz);
		ml = ilcm(ml,z);
	}
	M2 = _0;
	M1 = M;
	while (M1 != _0) {
		Mz = lfirst(M1);
		M1 = lred(M1);
		z = lfirst(Mz);
		Mz = lred(Mz);
		z = iquot(ml,z);
		Mz = vecismul(z,Mz);
		M2 = lcomp(Mz,M2);
	}
	z = llength(Mz);
	M2 = linv(M2);
	M1 = maihermspec(M2,z,&D);
	M2 = M1;
	while ( M2 != _0) {
		Mz = lfirst(M2);
		Mz = lcomp(ml,Mz);
		lsfirst(M2,Mz);
		M2 = lred(M2);
	}
	return(M1);
}
