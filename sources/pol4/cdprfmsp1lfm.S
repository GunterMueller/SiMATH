/*M
.SH NAME
common denominator polynomial over rational functions over modular single prime, transcendence degree 1, list from common denominator matrix of rational functions over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_pol4.h>

list cdprfmsp1lfm(M, p) 
matrix M; 
single p; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B M
is a CD-matrix over the rational function field over Z/(pZ).
.PP
The rows of M represent CD-polynomials (s. cdmarfmsp1id and cdprfmsp1fcl).
cdprfmsp1lfm returns a list of these CD-polynomials, beginning with the polynomial represented by the first row of M.
 
.SH SEE ALSO
.nf
cdmarfmsp1id
cdprfmsp1fcl

M*/
             
/*H
	Version 1       25.10.89        J.Schmitt
   DATE cdprfmsp1lfm  : 901120
H*/

#include<_pol4.h>

list cdprfmsp1lfm(M,p)
matrix M;
single p;
{
	list Mz,L;
	pol P;
	init(Mz,L,P);
	bind(M);

	L = _0;
	while ( M != _0 ) {
		Mz = lfirst(M);
		M = lred(M);
		P = cdprfmsp1fcl(Mz,p);
		L = lcomp(P,L);
	}   
	L = linv(L);
	return(L);
}
