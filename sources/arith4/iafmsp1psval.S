/*M
.SH NAME
iafmsp1psval - integral algebraic function over modular single prime, transcendence degree 1, P-star valuation

.SH SYNOPSIS
.nf
#include<_arith4.h>

rat iafmsp1psval(p, P, A) 
single p; 
pol P, A;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.   
.TP 4
.B P 
is an irreducible polynomial in the unknown x over Z/pZ.
.TP 4
.B A
is a monic, irreducible and univariate polynomial over (Z/pZ)[x]. A is the minimal polynomial of an integral algebraic element, say J, in a separable algebra over the rational function field (Z/pZ)(x).
.PP
iafmsp1psval returns the P-star value of the element J. Thereby, the P-star value of J is defined as the minimum of all values of J with regard to all extensions of the p-adic valuation from the function field (Z/pZ)(x) into the separable algebra.
  
M*/
              
/*H
	Version 1       09.01.90        J.Schmitt
   DATE iafmsp1psval  : 901120
H*/

#include<_arith4.h>

rat iafmsp1psval(p,P,A)
single p;
pol P,A;
{
	single i,e,n;
	rat v,w,i1,e1;
	int v1,w1;
	pol k;
	init(v,w,i1,e1,v1,w1,k);
	bind(P,A);

	n = lfirst(A);
	v = list2(0,0);
	A = lred2(A);
	if ( A == _0 ) return(0);
	do {
		e = lfirst(A);
		A = lred(A);
		k = lfirst(A);
		A = lred(A);
		i = upmsaddval(p,P,k);
		if (i) {
			i1 = itor(i);
			e  = n-e;
			e1 = itor(e);
			w  = rquot(i1,e1);
			v1 = iprod(lfirst(v),lsecond(w));
			w1 = iprod(lsecond(v),lfirst(w));
			if (icomp(v1,w1) >= 0) v=w;
		}
		else return(0);
	} while (A!=_0);
	return(v);
}
