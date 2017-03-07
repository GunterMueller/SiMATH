/*M
.SH NAME
pieval - polynomial over integers evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>
                                                                                
pol pieval(r, P, A) 
single r;
int A; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pieval returns P(A) (the evaluation of P at A) with regard to the main variable.
                                                                
M*/                                                                             
      
/*H
	Version 1	31.05.1987      B. Weis
   DATE pieval        : 890501
H*/


#include <_pol1.h>

pol pieval(r,P,A)
single r;
pol P;
int A;
{
	single e, e1;
	pol P1, k;
	bind2(P,A);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				if (r) P1 = piiprod(r,P1,A);
				else P1 = iprod(P1,A);
				}
			if (r) P1 = pisum(r,P1,k);
			else P1 = isum(P1,k);
			e = e1;
			}
		for (; e; e--) {
				if (r) P1 = piiprod(r,P1,A);
				else P1 = iprod(P1,A);
				}
		}

/* Ausgabe */

	return(P1);
}
