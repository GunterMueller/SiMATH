/*M
.SH NAME
afmsp1expsp - algebraic function over modular single prime, transcendence degree 1, exponentiation special

.SH SYNOPSIS
.nf
#include<_arith4.h>

pol afmsp1expsp(p, F, a, e, M) 
single p; 
pol F, a, M; 
int e;  

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x].
The algebra A arises by the adjunction of a zero of F, say u. 
.TP 4
.B a
is an element in A, represented by a CD-polynomial (s. cdprfmsp1fcl).
.TP 4
.B e
is a non-negative single.
.TP 4
.B M
is a polynomial in x over (Z/pZ).
.PP
afmsp1expsp returns a CD-polynomial, which represents a^e in A. If the polynomial M is not the zero polynomial, all products needed for the computation of a^e will be reduced modulo (M*(Z/pZ)[x])[u] (s. afmsp1prodsp).

.SH SEE ALSO
.nf
cdprfmsp1fcl
afmsp1prodsp

M*/
                 
/*H
	Version 1       16.01.90        J.Schmitt
   DATE afmsp1expsp   : 901120
H*/

#include<_arith4.h>

pol afmsp1expsp(p,F,a,e,M)
single p,e;
pol F,a,M;
{
	single i;
	pol ap;
	init(ap);
	bind(F,a,M);

	ap = list2(0,1);
	ap = list3(ap,0,ap);
	while ( e != 0 ) {
		i = mods(e,2);
		e = divs(e,2);
		if (i) ap = afmsp1prodsp(p,F,ap,a,M);
		if (e) a = afmsp1prodsp(p,F,a,a,M);
	}
	return(ap);
}
