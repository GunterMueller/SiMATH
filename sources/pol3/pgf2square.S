/*M
.SH NAME
pgf2square - polynomial over Galois-field with characteristic 2 square
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2square(r, G, P)  
single r; 
obj G; 
pol P;
     
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a polynomial in r variables over GF(2^n) with coefficients in spezial bit-representation.                        
.PP
pgf2square returns a polynomial over GF(2^n), say P1, where
.IP
P1 = P^2.

.SH SEE ALSO
udpm2tosb

M*/
                                 
/*H
	Version 1  	28.04.93	J.Schmitt
   DATE pgf2square    : 930531
H*/

#include <_pol3.h>

pol pgf2square(r,G,P)
single r;
obj G;	
pol P;
{
	single e;
	pol P3,k;
	bind(G,P);
	init(P3,k);

	if (P == 0) return(0);
	if (r == 0) {
		P3 = gf2squ(G,P);
		return(P3);
	}
	P3 = _0;
	while (P!=_0) {
		e = 2 * lfirst(P);
		P = lred(P);
		k = pgf2square((r-1),G,lfirst(P));
		P = lred(P);
		P3= lcomp2(k,e,P3);
	}
	P3 = linv(P3);
	return(P3);
}
