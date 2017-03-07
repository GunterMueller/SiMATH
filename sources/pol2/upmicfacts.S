/*M
.SH NAME
upmicfacts - univariate polynomial over modular integers, complete factorization special

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmicfacts(p, P)  
int p;
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a monic, univariate polynomial over Z/pZ, with degree of P > 0.
.PP
upmicfacts returns a list L = ( P1, e1, ..., Pk, ek ), where for 1 <= i <= k:
.IP
 ei is a positive single,
 Pi is a monic and irreducible factor of P,
 Pi != Pj, for i != j 
.PP
and
.IP
P = P1^e1 * ... * Pk^ek.

M*/

/*H
	Version 1       05.08.91	J.Schmitt
   DATE upmicfacts    : 910915
H*/

# include <_pol2.h>

list upmicfacts(p,A)
int p;
pol A;
{
	list L,L1,L2,L3,L4,M;
	pol P,P1;
	single e,i,l;
	bind(p,A);
	init(L,L1,L2,L3,L4,M,P,P1);

	if ( lfirst(A) == 1 ) {
		L = list2(A,1);
		return(L);
	}

	M = _0;
	L = upmisfact(p,A);
	while ( L != _0 ) {
		L1 = lfirst(L);
		L  = lred(L);
		e  = lfirst(L1);
		P  = lsecond(L1);
		L2 = _0;
		if ( lfirst(P) > 1 ) L3 = upmiddfact(p,P);
		else L3 = list2(P,1);
		while ( L3 != _0 ) {
			P1 = lfirst(L3);
			L3 = lred(L3);
			l  = lfirst(L3);
			L3 = lred(L3);
			L4 = upmibfact(p,P1,l);
			while ( L4 != _0 ) {
				 L2 = lcomp(lfirst(L4),L2);
				 L4 = lred(L4);
			}
		}
		while ( L2 != _0 ) {
			P  = lfirst(L2);
			L2 = lred(L2);
			M  = lcomp2(P,e,M);
		}
	}
	return(M);

}
