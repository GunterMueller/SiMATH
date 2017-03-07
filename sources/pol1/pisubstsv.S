/*M
.SH NAME
pisubstsv - polynomial over integers substitution, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pisubstsv(r, P1, n, P2) 
single r, n; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B n
is an integer number, 0 < n <= r.
.TP 4
.B P1
is a polynomial in r variables over the integer numbers.
.TP 4
.B P2
is a polynomial in n-1 variables over the integer numbers.
.PP
pisubstsv returns the polynomial P3 in r-1 variables over the integer numbers, where
.TP 16                                                                          
P3 = P1(P2),                                                                    
(the substitution of the n-th variable of P1 by P2).                            

.SH SEE ALSO
pisubst

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pisubstsv     : 890501
H*/


#include <_pol1.h>

pol pisubstsv(r,P1,n,P2)
single r;
pol P1;
single n;
pol P2;
{
	single e;
	pol P3, k;
	bind2(P1,P2);
	init2(P3,k);

/* P1 gleich 0 */


if (P1 == 0) P3 = 0;

/* n gleich r */

	else if (n == r) P3 = pisubst(r,P1,P2);

/* allgemeiner Fall: P1 ungleich 0, n ungleich r */

	else {
		r--;
		P3 = _0;
		do {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			k = pisubstsv(r,k,n,P2);
			if (k) P3 = lcomp2(k,e,P3);
			}
		while (P1 != _0);
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
		}

/* Ausgabe */

	return(P3);
}
