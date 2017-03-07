/*M
.SH NAME
pgf2eval - polynomial over Galois-field with characteristic 2 evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2eval(r, G, P, a)  
single r; 
obj G; 
pol P; 
gf2el a;
   
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
is a polynomial in r variables over GF(2^n).
.TP 4
.B a
is an element in GF(2^n).
.PP
pgf2eval returns a polynomial, say P1, over GF(2^n), where
.IP
P1 = P(a) (with regard to the main variable).

.SH SEE ALSO
udpm2tosb

M*/
                                 
/*H
	Version 1	25.08.1993	S.Schmitt
   DATE pgf2eval      : 931130
H*/


#include <_pol3.h>

pol pgf2eval(r,G,P,a)
single r;
obj G;
pol P;
gf2el a;
{
	single e, e1;
	pol P1, k;
	bind(P,G,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		r--;
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
				if (r) P1 = pgf2gf2prod(r,G,P1,a);
				else P1 = gf2prod(G,P1,a);
				}
			if (r) P1 = pgf2sum(r,G,P1,k);
			else P1 = gf2sum(G,P1,k);
			e = e1;
			}
		for (; e; e--) {
				if (r) P1 = pgf2gf2prod(r,G,P1,a);
				else P1 = gf2prod(G,P1,a);
				}
		}

/* Ausgabe */

	return(P1);
}
