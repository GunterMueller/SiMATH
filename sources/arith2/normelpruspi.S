/*M
.SH NAME
normelpruspi - norm of an element of the polynomial ring of an univariate separable polynomial over the integers

.SH SYNOPSIS
.nf
#include<_arith2.h>

int normelpruspi(P, a)  
pol P, a;
    
.SH DESCRIPTION
.TP 4
.B P
is a monic, separable and univariate polynomial over the integer numbers of degree > 0.
.PP
Let z be a root of P, and K := Q(z) = Q[z] be the separable algebra over the rational numbers, arising by the adjunction of z to the rational numbers.
.TP 4
.B a
is an element of the polynomial ring Z[z] in K, a is given by an univariate polynomial over the integer numbers of degree < deg(P).
.PP
normelpruspi returns the norm of a with regard to K/Q.

M*/
                             
/*H
	Version 1	03.03.90	J.Schmitt
	Version 2	09.08.91	J.Schmitt : bind(P) -> bind(P,a)
   DATE normelpruspi  : 900301.910915
H*/

#include <_arith2.h>

int normelpruspi( P, a )
pol P, a;
{

	matrix M;
	list N;
	single i,n;
	bind(P,a);
	init(M,N);

        M = _0;
	n = pdegree(1,P);
	for (i=0;i<n;i++) {
		N = sclfupi(a,n);
		M = lcomp(N,M);
		a = ppmvprod(1,a,1);
		if ( pdegree(1,a) >= n ) a = pirem(1,a,P);
	}	                                     
	M = linv(M);
	N = maidet(M);
	return(N);    
}
