/*M
.SH NAME
prexp - polynomial over rationals exponentiation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prexp(r, P, n)  
single r, n; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B n
is an integer number, 0 <= n < BASIS.
.TP 4
.B P                                                                            
is a polynomial in r variables over the rational numbers.     
.PP
prexp returns the polynomial P1 = P ^ n.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	28.11.1994	M. Conrad
   DATE prexp         : 890501.941201
H*/

#include <_pol1.h>

pol prexp(r,P,n)
single r;
pol P;
single n;
{
	pol P1;
	bind(P);
	init(P1);

/* n gleich 0 */

	if (!n) P1 = pvinsert(0,itor(1),r);

/* P gleich 0 */

	else if (!P) P1 = 0;

/* n,P ungleich 0 */

	else {
		P1 = P;
		for (--n; n; n--) P1 = prprod(r,P1,P);
		}

/* Ausgabe */

	return(P1);
}
