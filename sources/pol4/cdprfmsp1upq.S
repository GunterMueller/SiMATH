/*M
.SH NAME
cdprfmsp1upq - common denominator polynomial over rational functions over modular single prime, transcendence degree 1, univariate polynomial over modular single prime quotient

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1upq(p, F, P) 
single p; 
pol F, P; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.     
.TP 4
.B F
is a univariate CD-polynomial over Z/(pZ)(x) (s. cdprfmsp1fcl).
.TP 4
.B P
is an element in Z/(pZ)[x], F != 0.
.PP
cdprfmsp1upq returns a CD-polynomial, say F1, where
.IP
F1 = F / P.

.SH SEE ALSO
cdprfmsp1fcl

M*/
          
/*H
	Version 1       25.10.89        J.Schmitt
   DATE cdprfmsp1upq  : 901120
H*/

#include<_pol4.h>

pol cdprfmsp1upq(p,F,P)
single p;
pol F,P;
{
	single e;
	pol P1,d,k,l;
	init(P1,d,k,l);
	bind(F,P);

	if ( F == 0 ) return(0);
	d = pmsprod(1,p,lfirst(F),P);
	F = lred(F);
	P1 = F;
	k = d;
	while (P1!=_0) {
		P1 = lred(P1);
		l  = lfirst(P1);
		P1 = lred(P1);
		k  = upmsgcd(p,k,l);
	}
	while (F!=_0) {
		e = lfirst(F);
		F = lred(F);
		l = lfirst(F);
		F = lred(F);
		l = pmsquot(1,p,l,k);
		P1= lcomp2(l,e,P1);
	}		
	P1 = linv(P1);
	d  = pmsquot(1,p,d,k);
	P1 = lcomp(d,P1);
	return(P1);
}
