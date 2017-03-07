/*M
.SH NAME
upmigsd - univariate polynomial over modular integers greatest squarefree divisor, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmigsd(p, P)  
int p; 
pol P; 
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate polynomial over Z/pZ.
.PP
upmigsd returns a square-free and univariate polynomial over Z/pZ, say S, so that 
.IP
 S divides P, and
 P divides S^deg(P).

M*/

/*H
	Version 1       24.07.91	J.Schmitt
   DATE upmigsd       : 910915
H*/

#include<_pol2.h>

pol upmigsd(M,P)
int M;
pol P;
{
	single e, k, l;
	pol P1, P2, P3;
	bind(M,P);
	init(P1,P2,P3);

	if (pdegree(1,P) < 2) {
		P1 = pmimonic(1,M,P);
		return(P1);
	}

	if ( issingle(M) == 1 )	{
		k  = 0;
		P1 = P;
		while (P1 != _0) {
			e  = lfirst(P1);
			P1 = lred(P1);
			P1 = lred(P1);
			k  = sgcd(e,k);
			if (k==1) break;
		}
		l = intpp(M,k);
	}
	else l = 1;

	P1 = P;
	if ( l != 1) {
		P2 = _0;
		while (P1 != _0) {
			e = lfirst(P1);
			P1 = lred(P1);
			P3 = lfirst(P1);
			P1 = lred(P1);
			e = divs(e,l);
			P2 = lcomp2(P3,e,P2);
		}
		P1 = linv(P2);
	}

	P2 = pmideriv(1,M,P1);
	P3 = upmigcd(M,P1,P2);
	P1 = pmiquot(1,M,P1,P3);
	P1 = pmimonic(1,M,P1);  
        P2 = P1;

	while (pdegree(1,P2) != 0) {
		P2 = upmigcd(M,P3,P2);
		P3 = pmiquot(1,M,P3,P2);
	}
	P2 = upmigsd(M,P3);
	P3 = pmiprod(1,M,P1,P2);

	return(P3);
}
