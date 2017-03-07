/*M
.SH NAME
upgfscfacts - univariate polynomial over Galois-field with single characteristic complete factorization special

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfscfacts(p, AL, P)  
single p; 
list AL; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is an univariate and monic polynomial of positive degree over GF(p^n).
.PP
upgfscfacts returns a list (P_1, e_1, ..., P_r, e_r), 1 <= r <= BASIS, such that
.PP
e_i is a positive single,
.PP
P_i is an univariate, monic and irreducible polynomial over GF(p^n),
.PP
P_i != P_j for i != j and
.PP
P = (P_1)^(e_1) * ... * (P_r)^(e_r).

.SH SEE ALSO
 upgfscfact
 gfsalgen

M*/
                                           
/*H
	Version 1       13.02.90	J.Schmitt
   DATE upgfscfacts   : 900301.9203__.9211__
H*/


#include <_pol3.h>

list upgfscfacts(p,AL,P)
single p;
list AL;
pol P;
{
	list L,L1,L2,L3,L4,M;
	pol P1;
	single e,l;

	bind(AL,P);
	init(L,L1,L2,L3,L4,M,P1);

	if ( lfirst(P) == 1 ) {
		L1 = list2(P,1);
		return(L1);
	}

	M = _0;
	L = upgfssfact(p,AL,P);
	while ( L != _0 ) {
		L1 = lfirst(L);
		L  = lred(L);
		e  = lfirst(L1);
		P  = lsecond(L1);
		L2 = _0;
		if ( lfirst(P) > 1 ) L3 = upgfsddfact(p,AL,P);
		else L3 = list2(P,1);
		while (L3 != _0) {
			P1 = lfirst(L3);
			L3 = lred(L3);
			l  = lfirst(L3);
			L3 = lred(L3);
			L4 = upgfsbfact(p,AL,P1,l);
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
