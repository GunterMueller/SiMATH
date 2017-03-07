/*M
.SH NAME
ecgf2mopto - elliptic curve over Galois-field with characteristic 2, multiple of the order of a point to exact order of the point

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecgf2mopto(G, a1, a2, a3, a4, a6, PL, N)
obj G; 
gf2el a1, a2, a3, a4, a6; 
list PL; 
int N; 
          
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a1, a2, a3, a4, a6
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation.
The a_i's are the coefficients of an elliptic curve (say E) in Weierstrass normal form over GF(2^n).
.TP 4
.B PL
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on the curve E.
.TP 4
.B N
is an integer number and a multiple of the order of P, i.e.
.IP
N * P = O, where O denotes the neutral element of the 
           group of rational points E(GF(2^n)).
 
.PP
ecgf2mopto returns the exact order of the point P.

.SH SEE ALSO
udpm2tosb

M*/
   
/*H
	Version 1  	25.04.93	Joachim Schmitt
   DATE ecgf2mopto    : 930531
H*/

#include <_ec2.h>

int ecgf2mopto(G, a1, a2, a3, a4, a6, P, N)
obj G;
gf2el a1, a2, a3, a4, a6;
list P;
int N;
{
	single exp,h;
	int ho,ord,pme;
	list HP,L;

	bind(G,a1,a2,a3,a4,a6,P,N);
	init(ho,ord,pme,HP,L);

	ord = 1;
	L = ifact(N);
	L = ifel(L);
	while (L != _0) {
		pme = lfirst(L);
		exp = lsecond(L);
		L = lred2(L);
		if(exp==1) {			
			ho = iquot(N,pme);
			HP = ecgf2mul(G,a1,a2,a3,a4,a6,ho,P);
			if(!isppecgf2pai(G,HP)) ord=iprod(ord,pme);
			else N = ho;
		}
		else {
			h  = 0;
			ho = iquot(N, iexp(pme, exp));
			HP = ecgf2mul(G,a1,a2,a3,a4,a6,ho,P);
			if (isppecgf2pai(G,HP)) N = ho;
			else {
				do {
    					h++;
	    				HP = ecgf2mul(G,a1,a2,a3,a4,a6,pme,HP);
				} while (isppecgf2pai(G,HP) == 0); 
				HP = iexp(pme,h);
				ord = iprod(ord,HP);
				N  = iprod(ho,HP);
			}
		}
	}
	return (ord);
}
