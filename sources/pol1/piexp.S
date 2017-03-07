/*M
.SH NAME
piexp - polynomial over integers exponentiation

.SH SYNOPSIS
.nf
#include<_pol1.h>
                                                                                
pol piexp(r, P, n) 
single r,n; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.           
.TP 4
.B n
is an integer number, 0 <= n <= BASIS-1.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
piexp returns the polynomial P1 = P ^ n.
                                                                
M*/ 

/*H
	Version 1	31.05.1987      B. Weis
   DATE piexp         : 890501
H*/


#include <_pol1.h>

pol piexp(r,P,n)
single r;
pol P;
single n;
{
	pol P1;
	bind(P);
	init(P1);

/* n gleich 0 */

	if (!n) P1 = pvinsert(0,1,r);

/* P gleich 0 */

	else if (!P) P1 = 0;

/* n,P ungleich 0 */

	else {
		P1 = P;
		for (--n; n; n--) P1 = piprod(r,P1,P);
		}

/* Ausgabe */

	return(P1);
}
