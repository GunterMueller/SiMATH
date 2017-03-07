/*M
.SH NAME
cdmarid - common denominator matrix of rational numbers, identity construction

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix cdmarid(n)
single n;

.SH DESCRIPTION
cdmarid() returns a list A of n lists of rational numbers.
Each of these lists has length (n+1).
A represents a common-denominator (CD-) matrix of rational numbers.
In this respect, A is the n x n unity matrix over the rational numbers.

In general, a m x (n+1) CD-matrix of integers corresponds
to a m x n matrix of rational numbers.
In particular, every row of the CD-matrix must begin
with an element not equal to zero.
More precisely, the m rows of the matrices are mapped using

.nf
            (d_1, r_2, ..., r_(n+1) ) 
<-->
         (r_2 / d_1, ..., r_(n+1) / d_1 ).
.fi

.PP
.TP 4
.B n
is a positive single.

.SH SEE ALSO
cdmarhermred, cdmarfmsp1hr
M*/
/*H
	Version 1       15.05.89        J.Schmitt
	Version 2	20.10.1994	Dokumentation korrigiert. MP
   DATE cdmarid       : 891101.9001__.941201
H*/

#include<_matr1.h>

matrix cdmarid(n)
single n;
{
	matrix M,M1,Mz;
	init(M,M1,Mz);

	M = maconsdiag(n,1);
	M1 = M;
	while (M != _0) {
		Mz = lcomp(1,lfirst(M));
		lsfirst(M,Mz);
		M = lred(M);
	}
	return(M1);
}
