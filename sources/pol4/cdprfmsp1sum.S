/*M
.SH NAME
cdprfmsp1sum - common denominator polynomial over rational functions over modular single prime, transcendence degree 1, sum

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1sum(p, P1, P2)  
single p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.     
.TP 4
.B P1, P2
are univariate CD- polynomials over the rational function
field over Z/(pZ) (s. cdprfmsp1fcl).
.PP
cdprfmsp1sum returns a CD-polynomial, say P, where
.IP
P = P1 + P2.
 
.SH SEE ALSO
cdprfmsp1fcl

M*/
               
/*H
	Version 1       25.10.89        J.Schmitt
   DATE cdprfmsp1sum  : 901120.9311__
H*/

#include<_pol4.h>

pol cdprfmsp1sum(p,P1,P2)
single p;
pol P1,P2;         
{
	pol k1,k2,N1,N2,P3,N;
	single e1,e2,n;
	init(k1,k2,N1,N2,P3,N);
	bind(P1,P2);
                       
	if (P1 == 0) return(P2);
	if (P2 == 0) return(P1);
	N1= lfirst(P1);
	P1= lred(P1);
	N2= lfirst(P2);
	P2= lred(P2);
	N = pmsprod(1,p,N1,N2);                                                        

	P3 = _0;
	do {
		e1 = lfirst(P1);
		e2 = lfirst(P2);
		if (e1 > e2) {
			P1 = lred(P1);
			k1 = lfirst(P1);
			P1 = lred(P1);
			k2 = upmsgcd(p,k1,N1);
			k1 = pmsquot(1,p,k1,k2);
			k2 = pmsquot(1,p,N1,k2);
			k1 = list2(k1,k2);
			P3 = lcomp2(k1,e1,P3);
		}
		else {
			if (e1 < e2) {
				P2 = lred(P2);
				k2 = lfirst(P2);
				P2 = lred(P2);
				k1 = upmsgcd(p,k2,N2);
				k2 = pmsquot(1,p,k2,k1);
				k1 = pmsquot(1,p,N2,k1);
				k2 = list2(k2,k1);
				P3 = lcomp2(k2,e2,P3);
			}
			else {
				P1 = lred(P1);
				P2 = lred(P2);
				k1 = lfirst(P1);
				k2 = lfirst(P2);  
				P1 = lred(P1);
				P2 = lred(P2);
				k1 = pmsprod(1,p,k1,N2);
				k2 = pmsprod(1,p,k2,N1);
				k1 = pmssum(1,p,k1,k2);
				if (k1) {
					k2 = upmsgcd(p,k1,N);
					k1 = pmsquot(1,p,k1,k2);
					k2 = pmsquot(1,p,N,k2);
					k1 = list2(k1,k2);
				        P3 = lcomp2(k1,e1,P3);
				}
			}
		}
	} while (P1 != _0  &&  P2 != _0);
	if (P1 == _0) {
		P1 = P2;
		N1 = N2;
		P2 = _0;
	}
	while ( P1 != _0 ) {
		e1 = lfirst(P1);
		P1 = lred(P1);
		k1 = lfirst(P1);
		P1 = lred(P1);
		k2 = upmsgcd(p,k1,N1);
		k1 = pmsquot(1,p,k1,k2);
		k2 = pmsquot(1,p,N1,k2);
		k1 = list2(k1,k2);
		P2 = lcomp2(k1,e1,P2);
	}
	if (P2 != _0) P1 = linv(P2);
	if (P3 == _0) P3 = P1;
	else {
		P2 = P3;
		P3 = linv(P2);
		lsred(P2,P1);
	}
	if (P3 == _0) return(0);

	N = list2(0,1);
	N1 = P3;
	while ( P3!=_0 ) {
		P3 = lred(P3);
		k1 = lfirst(P3);
		P3 = lred(P3);                  
		k1 = lsecond(k1);
		k2 = upmsgcd(p,k1,N);
		k1 = pmsprod(1,p,k1,N);
		N = pmsquot(1,p,k1,k2);
	}		    
	while ( N1!=_0 ) {
		e1 = lfirst(N1);
		N1 = lred(N1);
		k1 = lfirst(N1);
		N1 = lred(N1);
		k2 = pmsquot(1,p,N,lsecond(k1));
		k1 = pmsprod(1,p,lfirst(k1),k2);
		P3 = lcomp2(k1,e1,P3);
	}
	P3 = linv(P3);
	P3 = lcomp(N,P3);              

	return(P3);
}
