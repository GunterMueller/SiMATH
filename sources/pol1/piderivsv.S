/*M
.SH NAME
piderivsv - polynomial over integers derivation, specified variable (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol piderivsv(r, P, n) 
single r, n; 
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
piderivsv returns the derivation of P with respect to the n-th variable of P.
                                                                
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE piderivsv     : 890501
H*/


#include <_pol1.h>

pol piderivsv(r,P,i)
single r;
pol P;
single i;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (i == r) P1 = pideriv(r,P);

/* allgemeiner Fall: i ungleich r und P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = piderivsv(r,k,i);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
