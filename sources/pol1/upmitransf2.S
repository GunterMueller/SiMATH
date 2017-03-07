/*M
.SH NAME
upmitransf2 - univariate polynomial over modular integers transformation version2

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmitransf2(M, P, r, P1)  
int M; 
pol P, P1; 
single r;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.          
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P
is an univariate polynomial over Z/(M*Z).
.TP 4
.B P1 
is a polynomial in r variables over Z/(M*Z).
.PP
upmitransf2 returns the polynomial P2, which arises from the substitution of the variable in P by P1.
.PP
In contrast to upmitransf, upmitransf2 uses Horner's method.

M*/

/*H
	Version 1	02.08.91	J.Schmitt
   DATE upmitransf2   : 910915
H*/

#include <_pol1.h>

pol upmitransf2(M,P,r,P1)
int M;
pol P;
single r;
int P1;
{
	single e, e1, i;
	pol P2, k;
	bind(M,P,P1);
	init(P2,k);

	if (P == 0) P2 = 0;
	else {
		e  = lfirst(P);
		P  = lred(P);
		P2 = list2(0,lfirst(P));
		for(i=1;i<r;i++) P2 = list2(0,P2);
		P  = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P  = lred(P);
			k = list2(0,lfirst(P));
			for(i=1;i<r;i++) k = list2(0,k);
			P  = lred(P);
			for (e -= e1; e; e--) P2 = pmiprod(r,M,P2,P1);
			P2 = pmisum(r,M,P2,k);
			e = e1;
		}
		for (; e; e--) P2 = pmiprod(r,M,P2,P1);
	}
	return(P2);
}
