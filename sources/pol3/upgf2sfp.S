/*M
.SH NAME
upgf2sfp - univariate polynomial over Galois-field with characteristic 2, squarefree part

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2sfp(G, P)  
obj G; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P
is a monic and univariate polynomial over GF(2^n) of positive degree in special bit-representation. 
.PP
upgf2sfp returns the squarefree part of P.
 
.SH SEE ALSO
udpm2tosb


M*/

/*H
	Version 1	23.06.94           S.Schmitt
   DATE upgf2sfp      : 941201
H*/

#include <_pol3.h>

pol upgf2sfp(G,P)
obj G;
pol P;
{
	list L;
	pol P1;
	bind(G,P);
	init(L,P1);

/* Berechnung von P1 */
	L = upgf2sfact(G,P);
	P1 = list2(0,1);
	P1 = list2(0,P1);
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = pgf2prod(1,G,P1,lsecond(P));
		}
	return(P1);
}
