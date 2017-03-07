/*M
.SH NAME
nepousppmsp1 - norm of an element of the polynomial order of an univariate separable polynomial over the polynomial ring over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith4.h>

pol nepousppmsp1(p, F, a) 
single p; 
pol F, a;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.PP
Let R be the polynomial ring (Z/pZ)[x] over Z/pZ and let K be the rational function field (Z/pZ)(x).
.TP 4
.B F
is a monic, separable and univariate polynomial over R, deg(F) > 1.
.PP
Let z be a zero of F.
.TP 4
.B a
is an element in the polynomial order R[z], repre-sented by an univariate polynomial over R with degree smaller than the degree of F.
.PP
nepousppmsp returns an element in R which is  the norm of a as an element in the extension K[z] over K.  

M*/
               
/*H
	Version 1 	08.02.93	J.Schmitt
   DATE nepousppmsp1  : 930531
H*/


#include <_arith4.h>

pol nepousppmsp1(p,F,a)
single p;
pol F, a;
{

	matrix M;
	list N;
	single i,n;
	bind(F,a);
	init(M,N);

        M = _0;
	n = pdegree(2,F);
	for (i=0;i<n;i++) {
		if ( !a ) return(0);
		N = sclfuprfmsp1(a,n);
		M = lcomp(N,M);
		a = ppmvprod(2,a,1);
		if ( pdegree(1,a) >= n ) a = pmsrem(2,p,a,F);
	}	                                     
	M = linv(M);
	N = mapmsdet(1,p,M);
	return(N);    
}
