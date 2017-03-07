/*M
.SH NAME
cdmarfmsp1id - common denominator matrix of rational functions over modular single primes, transcendence degree 1, identity construction

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix cdmarfmsp1id(n)
single n;

.SH DESCRIPTION
cdmarfmsp1id() returns a list A of n lists of polynomials in one variable
over Z/pZ. Each of these lists has length (n+1).
A represents a common-denominator (CD-) matrix of rational
functions over Z/pZ for a single prime p.
In this respect, A is the n x n unity matrix over this function field.

In general, a m x (n+1) CD-matrix of polynomials in one variable
over Z/pZ corresponds to a m x n matrix of rational functions
over Z/pZ. In particular, every row of the CD-matrix must begin
with a polynomial not equal to zero.
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
cdmarfmsp1hr
M*/



/*H
	Version 1       15.10.89        J.Schmitt
   DATE cdmarfmsp1id  : 901120
H*/

#include<_matr2.h>

matrix cdmarfmsp1id(n)
single n;
{
	matrix M,M1,M2,Mz;
	init(M,M1,M2,Mz);

	M2 = list2(0,1);
	M = maconsdiag(n,M2);
	M1 = M;
	while (M != _0) {
		Mz = lcomp(M2,lfirst(M));
		lsfirst(M,Mz);
		M = lred(M);
	}
	return(M1);
}
