/*M
.SH NAME
cdprfmsp1fup - common denominator polynomial over rational functions over modular single prime, transcendence degree 1, from univariate polynomial over rational functions over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1fup(p, P) 
single p; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B P
is a univariate polynomial over the rational function
field over Z/(pZ) in sparse representation.
.PP
cdprfmsp1fup returns the representation of P as a CD-poly-nomial (s. cdprfmsp1fcl).

.SH SEE ALSO
cdprfmsp1fcl

M*/
              
/*H
	Version 1       15.10.89        J.Schmitt
   DATE cdprfmsp1fup  : 901120
H*/

#include<_pol4.h>

pol cdprfmsp1fup(p,P)
single p;
pol P;              
{
	pol k,l,q,P1;
	single e;
	init(k,l,q,P1);
	bind(P);

	if (P == 0) return(0);

	k = list2(0,1);
	P1 = P;
	while (P1 != _0) {
		P1 = lred(P1);
		l = lfirst(P1);
		P1 = lred(P1);
		l = lsecond(l);
		q = pmsprod(1,p,k,l);
		k = pmsquot(1,p,q,upmsgcd(p,k,l));
	}
	while (P!=_0) {
		e = lfirst(P);
		P = lred(P);
		l = lfirst(P);
		P = lred(P);    
		q = lfirst(l);
		l = lsecond(l);
		l = pmsprod(1,p,q,pmsquot(1,p,k,l));
		P1=lcomp2(l,e,P1);
	}
	P1 = linv(P1);
	P1 = lcomp(k,P1);
	return(P1);
}
