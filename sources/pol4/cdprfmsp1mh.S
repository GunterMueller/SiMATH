/*M
.SH NAME
cdprfmsp1mh - common denominator polynomial over rational functions over modular single primes, transcendence degree 1, module homomorphism

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1mh(p, P, M)  
single p; 
pol P, M;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.  
.TP 4
.B P
is a CD-polynomial (s. cdprfmsp1fcl) over Z/(pZ)(x) in the unknown y.
.TP 4
.B M
is a polynomial in Z/(pZ)[x], M != 0.
.PP
cdprfmsp1mh returns a CD-polynomial, say P1, over Z/(pZ)(x) in the unknown y, such that
.IP
P1(y) = P(y) mod ( M * (Z/pZ)[x] ) [y]
.PP
holds.

.SH SEE ALSO
cdprfmsp1fcl

M*/
                    
/*H
	Version 1       17.11.89        J.Schmitt
   DATE cdprfmsp1mh   : 901120.9211__
H*/

#include<_pol4.h>

pol cdprfmsp1mh(p,P,M)
single p;
pol P, M;
{
	single e;
	pol al, N, P1, P2, P3;
	init(al, N, P1, P2, P3);
	bind(P,M);

	if ( P == 0 ) return(0);
	al = lfirst(P);
	P  = lred(P);
	N  = pmsprod(1,p,al,M);
	P1 = _0;
	while (P != _0) {
		e = lfirst(P);
		P = lred(P);
		P2= lfirst(P);
		P = lred(P);
		P2= pmsrem(1,p,P2,N);
                if ( P2 != 0 ) P1 = lcomp2(P2,e,P1);
        }
	if ( P1 != _0 ) P2 = linv(P1);
	else return(0);

	P1 = lred(P2);
	N  = lfirst(P1);
	P1 = lred(P1);
	while ( P1!=_0 ) {
		P1 = lred(P1);
		P3 = lfirst(P1);
		P1 = lred(P1);                  
		N  = upmsgcd(p,P3,N);
	}		    
	N = upmsgcd(p,al,N);
	if ( oequal(N,list2(0,1)) ) {
		N = lcomp(al,P2);
		return(N);
	} 
	while ( P2!=_0 ) {
		e  = lfirst(P2);
		P2 = lred(P2);
		P3 = lfirst(P2);
		P2 = lred(P2);
		P3 = pmsquot(1,p,P3,N);
		P1 = lcomp2(P3,e,P1);
	}                        
	P3 = linv(P1);  
	al = pmsquot(1,p,al,N);
	P3 = lcomp(al,P3); 
	return(P3);
}
