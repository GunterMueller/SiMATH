/*M
.SH NAME
upmirelpfact - univariate polynomial over modular integers relative prime factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmirelpfact(p, P, Fac, pA2)  
int p; 
pol P, Fac, *pA2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate polynomial over Z/pZ.
.TP 4
.B Fac
is an univariate polynomial over Z/pZ, Fac divides P. 
.PP
upmirelpfact computes the univariate polynomials A1, A2 over Z/pZ, so that
.IP
 A1 * A2 = P,
 gcd (A1, Fac) = 1 and
 A2 | Fac^deg(P)
.PP
holds.
.PP
upmirelpfact returns A1 and writes A2 to pA2.

M*/

/*H
	Version 1       05.08.91	J.Schmitt
   DATE upmirelpfact  : 910915
H*/

#include<_pol2.h>

pol upmirelpfact(P,F,Fak,pA2)
int P;
pol F,Fak;
pol *pA2;
{
	pol A1,A2;
	init(A1,A2);
	bind(P,F,Fak);

	A1 = F;
	A2 = list2(0,1);

	do {
		A2  = pmiprod(1,P,Fak,A2);
		A1  = pmiquot(1,P,A1,Fak);
		Fak = upmigcd(P,A1,A2);
	}
	while ( lfirst(Fak) > 0 );  
	*pA2 = A2;
	return(A1);
}
