/*M
.SH NAME
ecmpsnfmopto - elliptic curve over modular primes, short normal form, multiple of the order of a point to exact order of the point

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecmpsnfmopto(p, a4, a6, PL, mul)  
int p, a4, a6, mul; 
list PL;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p > 37.
.TP 4
.B a4, a6
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ.
.TP 4
.B PL
is a list of three elements of Z/pZ, defining a point, say P, on E in projective representation.
.TP 4
.B mul
is a multiple of the order of the point P, i.e.
.IP
mul * P = O, where O denotes the neutral element of 
             the group of rational points E(Z/pZ).
.PP
ecmpsnfmopto returns the exact order of the point P. 

M*/
         
/*H
        Version 1	15.01.93 	Joachim Schmitt
   DATE ecmpsnfmopto  : 930531
H*/

#include <_ec2.h>

int ecmpsnfmopto(p,a4,a6,P,mul)
int p, a4, a6, mul;
list P;
{
	single exp,h;
	int ho,ord,pme;
	list HP,L;

	bind(p,a4,a6,P,mul);
	init(ho,ord,pme,HP,L);

	ord = 1;
	L = ifact(mul);
	L = ifel(L);
	while (L != _0) {
		pme = lfirst(L);
		exp = lsecond(L);
		L = lred2(L);
		if(exp==1) {			
			ho = iquot(mul,pme);
			HP = ecmpsnfmul(p,a4,a6,ho,P);
			if(!isppecmppai(p,HP)) ord=iprod(ord,pme);
			else mul = ho;
		}
		else {
			h  = 0;
			ho = iquot(mul, iexp(pme, exp));
			HP = ecmpsnfmul(p, a4, a6, ho, P);
			if (isppecmppai(p,HP)) mul = ho;
			else {
				do {
    					h++;
	    				HP = ecmpsnfmul(p, a4, a6, pme, HP);
				} while (isppecmppai(p, HP) == 0); 
				HP = iexp(pme,h);
				ord = iprod(ord,HP);
				mul = iprod(ho,HP);
			}
		}
	}
	return (ord);
}
