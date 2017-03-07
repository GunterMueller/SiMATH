/*M
.SH NAME
upgf2eval - polynomial over Galois-field with characteristic 2 evaluation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2eval(G, P, a)  
obj G; 
pol P; 
gf2el a;
            
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P
is a monic and univariate polynomial over GF(2^n) with coefficients in special bit-representation.
.TP 4
.B a
is an element in GF(2^n), represented as an univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP
upgf2eval returns the evaluation of P at a, i.e. a polynomial, say P1, where
.IP
P1 = P(a).

.SH SEE ALSO
udpm2tosb

M*/
                     
/*H
	Version 1    	28.04.93	J.Schmitt
   DATE upgf2eval     : 930531
H*/

#include <_pol3.h>

pol upgf2eval(P2,P,a)
pol P2,P;
gf2el a;
{
	single e, e1;
	gf2el P1, k;
	bind(P2,P,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				P1 = gf2prod(P2,P1,a);
			}
			P1 = gf2sum(P2,P1,k);
			e = e1;
		}
		for (; e; e--) {
				P1 = gf2prod(P2,P1,a);
		}
	}
	return(P1);
}
