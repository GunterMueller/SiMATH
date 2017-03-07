/*M
.SH NAME
udpgf2remsp - univariate dense polynomial over Galois-field with characteristic 2 remainder, special version

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol udpgf2rem(G,P1,P2,ilc)  
obj G; 
pol P1, P2; 
gf2el ilc;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P1, P2
are univariate dense-polynomials over GF(2^n) with coefficients in special bit-representation, such that deg(P1) > deg(P2). P2 must not be zero.
.TP 4
.B ilc
is the inverse of the leading coefficient of P2. The specification of ilc is not necessary. For ilc = 0, udpgf2remsp computes it.
.PP
udpgf2remsp returns a dense polynomial, say P3, with coefficients in special bit-representation, where 
.IP
P3 = P1 % P2, the remainder of the division of P1 by P2.
.SH CAUTION
P1 will be changed.

.SH NOTES
udpgf2remsp is especially effective, if there is often a reduction by the same polynomial.
   
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1         10.05.93	J.Schmitt
   DATE udpgf2remsp     : 931130
H*/

#include <_pol3.h>

pol udpgf2remsp(G,P1,P2,ilc)
obj G;
pol P1, P2;
gf2el ilc;
{
	single e1, e2, s;
	gf2el c, k1, k2;
	pol P1S, P1SS, P2S;
	bind(G,P1,P2,ilc);
	init(c,k1,k2,P1S,P1SS);

	if (!ilc) ilc = gf2inv(G,lsecond(P2));
	e2 = lfirst(P2);
	if (!e2) return(0);
	P2 = lred(P2);
	k2 = lfirst(P2);
	P2 = lred(P2);
	do {
		e1   = lfirst(P1);
		P1S  = lred(P1);
		s    = (-1);
		k1   = lfirst(P1S);
		P1SS = lred(P1S);
		c    = gf2prod(G,k1,ilc);
		P2S  = P2;
		do {
			k2  = lfirst(P2S);
			P2S = lred(P2S);
			k2  = gf2prod(G,k2,c);
			k1  = lfirst(P1SS);
			k1  = gf2sum(G,k1,k2);
			e1--;
			if (s < 0  &&  k1) s = e1, P1 = P1S;
			lsfirst(P1SS,k1);
			P1S  = P1SS;
			P1SS = lred(P1S);
		} while (P2S != _0);
		while (s < 0  &&  P1SS != _0) {
			e1--;
			if (lfirst(P1SS)) s = e1, P1 = P1S;
			P1S  = P1SS;
			P1SS = lred(P1S);
		}
		if (s >= 0) lsfirst(P1,s);
	} while (s >= e2);
	if (s >= 0) return(P1);
	else return(0);
}
