/*M
.SH NAME
pgf2monic - polynomial over Galois-field with characteristic 2 monic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2monic(r, G, P)  
single r; 
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
.PP
pgf2monic returns the monic polynomial associated to P.   

.SH SEE ALSO
udpm2tosb

M*/
                                 
/*H
	Version 1 	28.04.93	J.Schmitt
   DATE pgf2monic     : 930531
H*/

#include <_pol3.h>

pol pgf2monic(r,P2,P)
single r;
pol P2,P;
{
	gf2el a;
	bind(P2,P);
	init(a);
/* Berechnung des zu P assozierten, normierten Polynoms */

	if (P) {
		a = plbc(r,P);
		a = gf2inv(P2,a);
		P = pgf2gf2prod(r,P2,P,a);
	}

/* Ausgabe */

	return(P);
}
