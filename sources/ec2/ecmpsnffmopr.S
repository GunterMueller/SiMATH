/*M
.SH NAME
ecmpsnffmopr - elliptic curve over modular primes, short normal form, finding a multiple of the order of a point with the Pollard Rho method

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecmpsnffmopr(p, a4, a6, PL, k) 
int p, a4, a6; 
list PL; 
single k;
 
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
.B k
is a non negative single, which should be between 3 and 30.
.PP
ecmpsnffmopr computes with help of a technique, basing on the Pollard-rho method, an integer number, say M, where 
.IP
M * P = O, where O denotes the neutral element of
           the group of rational points E(Z/pZ).
.PP
ecmpsnffmopr returns M by success and -1 else.

.SH NOTES
The running time of ecmpsnffmopr lies at 3*sqrt(p)*D_add, wher D_add denotes the average time, used to add two points of E(Z/pZ). Therewith, the running time of ecmpsnffmopr is bigger than the running time of ecmpsnffmopl and ecmpsnfcssa.

.SH SEE ALSO
 ecmpsnffmopl
 ecmpsnfcssa
 ecmpsnfmopto
 Literature: A.K. Lenstra and H.W. Lenstra: Algorithms in 
             number theory, Technical Report of the 
             University of Chicago, May 1987.

M*/
                       
/*H
	Version 1	14.01.93	Joachim Schmitt
   DATE ecmpsnffmopr  : 930531
H*/

#include<_ec2.h>

int ecmpsnffmopr(p,a,b,P,k)
int p, a, b;
list P;
single k;
{
	single i,h;
	list LZ,LP,P1,P2;
	int E1,E2;
	bind(p,a,b,P);
	init(LZ,LP,P1,P2,E1,E2);

	E1 = isqrt(p);
	E1 = isprod(E1,2);
	E1 = isum(E1,p);
	LZ = _0;
	for (i=0;i<k;i++) {
		E2 = irand(E1);
		E2 = isum(E2,2);
		LZ = lcomp(E2,LZ);
	}
	LP = _0;
	for(i=0;i<k;i++) {
		E1 = lelt(LZ,(k-i));
		P1 = ecmpsnfmul(p,a,b,E1,P);
		if (!lthird(P1)) return(E1);
		LP = lcomp(P1,LP);
	}

	P1 = lfirst(LP);
	E1 = lfirst(LZ);
	P2 = P1;
	E2 = E1;
	h  = mshom(k,lfirst(P2));
	h++;
	E2 = isum(E2,lelt(LZ,h));
	P2 = ecmpsnfsum(p,a,b,P2,lelt(LP,h));			
	if (!lfirst(P2)) if (!lthird(P2)) return(E2);
	for(;;) {
		for(i=0;i<2;i++) {
			h  = mshom(k,lfirst(P2));
			h++;
			E2 = isum(E2,lelt(LZ,h));
			P2 = ecmpsnfsum(p,a,b,P2,lelt(LP,h));			
			if (!lfirst(P2)) {
				if (!lthird(P2)) return(E2);
			}
		}
		h  = mshom(k,lfirst(P1));
		h++;
		E1 = isum(E1,lelt(LZ,h));
		P1 = ecmpsnfsum(p,a,b,P1,lelt(LP,h));
		if (oequal(P1,P2)) {
			E2 = idif(E2,E1);
			return(E2);
		}
	}
}	

