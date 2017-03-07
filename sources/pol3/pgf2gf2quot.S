/*M
.SH NAME
pgf2gf2quot - polynomial over Galois-field with characteristic 2, Galois-field with characteristic 2 element quotient
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2gf2quot(r, G, P, a) 
single r; 
obj G; 
pol P; 
gfel a;
    
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
.TP 4
.B a
is an element in GF(2^n), a != 0.
.PP
pgf2gf2quot returns a polynomial over GF(2^n), say P1, where
.IP
P1 = P/a.
 
.SH SEE ALSO
udpm2tosb

M*/
                 
/*H
	Version 1	24.04.94	S.Schmitt
   DATE pgf2gf2quot   : 941201
H*/

#include <_pol3.h>
 
pol pgf2gf2quot(r,G,P,a)
single r;
obj G;
pol P;
gfel a;
{
	single e;
	pol P1, k;
	bind(P,G,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = gf2quot(G,P,a);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pgf2gf2quot(r,G,k,a);
			else k = gf2quot(G,k,a);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
