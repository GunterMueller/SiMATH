/*M
.SH NAME
pgf2exp - polynomial over Galois-field with characteristic 2 exponentiation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2exp(r, G, P, n)  
single r, n; 
obj G; 
pol P; 
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a polynomial in r variables over GF(2^n) with coefficients in spezial bit-representation.
.TP 4
.B n
is a positive single.
.PP
pgf2exp returns a polynomial over GF(2^n), say P1, where
.IP
P1 = P^n.

.SH SEE ALSO
udpm2tosb

M*/
                                            
/*H
	Version 1  	28.04.93	J.Schmitt
   DATE pgf2exp       : 930531
H*/

#include <_pol3.h>

pol pgf2exp(r,G,P,n)
single r;
obj G;	
pol P;
single n;
{
	single e,m;
	pol P3;
	bind(G,P);
	init(P3);

	if (n == 1) return(P);
	if (n == 2) {
		P3 = pgf2square(r,G,P);
		return(P3);
	}

	e = 2;
	while(e<=n) e*=2;
	e = e/2;
	m = n-e;
	P3 = P;
	do {
		P3 = pgf2square(r,G,P3);
		e = e/2;
		if (m>=e) { 
			P3 = pgf2prod(r,G,P3,P);
			m-=e;
		}
	} while (e!=1);
	return(P3);
}
