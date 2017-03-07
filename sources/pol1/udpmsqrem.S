/*M
.SH NAME
udpmsqrem - univariate dense polynomial over modular singles quotient and remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsqrem(m, P1, P2, pR)
single m;
pol P1, P2, *pR;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 0 <= m <= BASIS.
.TP 4
.B P1, P2
are univariate dense polynomials over Z/mZ, P2 != 0.
.PP
udpmsqrem computes the division with remainder of P1 by P2:                     
.TP 4                                                                           
P1 = P2 * P3 + Prem,                                                            
where Prem is the remainder of the division.                                    
.PP                                                                             
udpmsqrem returns P3. Prem can be found at *pR.                                   
.SH SEE ALSO
 udpmsrem
 udpmsquot

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE udpmsqrem     : 890501
H*/


#include <_pol1.h>

pol udpmsqrem(m,P1,P2,pP3)
single m;
pol P1, P2;
pol *pP3;
{
	single e2, e3, fk2, fk3, k3;
	pol P3, P4, P2S, P3S;
	bind2(P1,P2);
	init2(P3,P4);

/* P1 gleich 0 */

	if (P1 == 0) {P4 = 0; *pP3 = 0;}

/* Grad(P1) kleiner Grad(P2) */

	else if (lfirst(P1) < lfirst(P2)) {P4 = 0; *pP3 = P1;}

/* Grad(P1) groesser gleich Grad(P2) */

	else {
		P3 = lcinv(P1);
		P3 = linv(P3);
		e3 = lfirst(P3);
		P3 = lred(P3);
		e2 = lfirst(P2);
		P2 = lred(P2);
		fk2 = lfirst(P2);
		P2 = lred(P2);
		fk2 = msinv(m,fk2);
		P4 = list1(e3 - e2);
		while (e3 >= e2) {
			P2S = P2;
			fk3 = msprod(m,lfirst(P3),fk2);
			P4 = lcomp(fk3,P4);
			P3 = lred(P3);
			P3S = P3;
			e3--;
			if (fk3 != 0) {
				while (P2S != _0) {
					k3 = msprod(m,lfirst(P2S),fk3);
					k3 = msdif(m,lfirst(P3S),k3);
					lsfirst(P3S,k3);
					P2S = lred(P2S);
					P3S = lred(P3S);
					}
			}
		}
		while (P3 != _0  &&  lfirst(P3) == 0) {
			P3 = lred(P3);
			e3--;
			}
		if (P3 == _0) P3 = 0;
		else P3 = lcomp(e3,P3);
		P4 = linv(P4);
		*pP3 = P3;
		}

/* Ausgabe */

	return(P4);
}
