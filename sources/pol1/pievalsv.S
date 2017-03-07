/*M
.SH NAME
pievalsv - polynomial over integers evaluation, specified variable (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>
                                                                                
pol pievalsv(r, P, n, A) 
single r, n; 
int A; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B n
is an integer number, 1 <= n <= r.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pievalsv returns P(A) (the evaluation of P at A) with regard to the n-th variable.                                                                 

M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE pievalsv      : 890501
H*/


#include <_pol1.h>

pol pievalsv(r,P,n,A)
single r;
pol P;
single n;
int A;
{
	single e;
	pol P1, k;
	bind2(P,A);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* n gleich r */

	else if (n == r) P1 = pieval(r,P,A);

/* allgemeiner Fall: P ungleich 0, n ungleich r */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pievalsv(r,k,n,A);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
