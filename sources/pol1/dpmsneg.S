/*M
.SH NAME
dpmsneg - dense polynomial over modular singles negation, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dpmsneg(r, m, P) 
single r, m; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P
is a dense polynomial in r variables over Z/mZ.     
.PP
dpmsneg returns the polynomial P1, where                                        
.IP                                                                             
P1 = - P.                                                                       
               
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE dpmsneg       : 890501
H*/


#include <_pol1.h>

pol dpmsneg(r,m,P)
single r;
single m;
pol P;
{
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (!P) P1 = 0;

/* r gleich 0 */

	else if (!r) P1 = msneg(m,P);

/* r,P ungleich 0 */

	else {
		r--;
		k = lfirst(P);
		P = lred(P);
		P1 = list1(k);
		if (r)
			do {
				k = lfirst(P);
				P = lred(P);
				k = dpmsneg(r,m,k);
				P1 = lcomp(k,P1);
				}
			while (P != _0);
		else
			do {
				k = lfirst(P);
				P = lred(P);
				k = msneg(m,k);
				P1 = lcomp(k,P1);
				}
			while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
