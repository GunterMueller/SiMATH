/*M
.SH NAME
pmsinter - polynomial over modular singles interpolation, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsinter(r, p, P1, P2, P3, a, b) 
single r, p; 
pol P1, P2, P3;
int a, b;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1
is an univariate polynomial in the variable X1 over Z/pZ.
.TP 4
.B P2
is a polynomial in the r variables X1,...,Xr over Z/pZ, with deg(P1) > deg(P2) (with regard to the main variable).
.TP 4
.B P3
is a polynomial in the r-1 variables X2,...,Xr over Z/pZ.
.TP 4
.B a
is an element of Z/pZ with P1(a) != 0.
.TP 4
.B b
is an element of Z/pZ, b = P1(a)^(-1).
.PP 
pmsinter returns the unique polynomial, say P4, in the r variables X1,...,Xr over Z/pZ, so that
.IP
 P4(X1,...,Xr) = P2(X1,...,Xr) modulo P1(X1),
 P4(a,X2,...,Xr) = P3(X2,...,Xr), and
 deg(P1) > deg(P4) (with regard to the main
 variable).

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsinter      : 890501
H*/


#include <_pol2.h>

pol pmsinter(r,m,P1,P2,P3,a,b)
single r;
single m;
pol P1;
pol P2;
pol P3;
single a, b;
{
	single c, e, eP2, eP3;
	pol P, P4, kP2, kP3;
	bind3(P1,P2,P3);
	init4(P,P4,kP2,kP3);

/* Grad(P1) gleich 0 */

	e = pdegree(1,P1);
	if (!e) P4 = pvinsert(r-1,P3,1);

/* r gleich 1 */

	else if (r == 1) {
		c = pmseval(r,m,P2,a);
		c = msdif(m,P3,c);
		if (c) {
			c = msprod(m,c,b);
			P4 = pmsmsprod(1,m,P1,c);
			P4 = pmssum(1,m,P4,P2);
			}
		else P4 = P2;
		}

/* r groesser 1 */

	else {
		P4 = _0;
		r--;
		if (!P2) P2 = _0;
		if (!P3) P3 = _0;
		while (P2 != _0  ||  P3 != _0) {
			if (P2 == _0) {
				kP2 = 0;
				e = lfirst(P3);
				P3 = lred(P3);
				kP3 = lfirst(P3);
				P3 = lred(P3);
				}
			else if (P3 == _0) {
				kP3 = 0;
				e = lfirst(P2);
				P2 = lred(P2);
				kP2 = lfirst(P2);
				P2 = lred(P2);
				}
			else {
				eP2 = lfirst(P2);
				eP3 = lfirst(P3);
				e = smax(eP2,eP3);
				kP2 = 0;
				kP3 = 0;
				if (e == eP2) {
					P2 = lred(P2);
					kP2 = lfirst(P2);
					P2 = lred(P2);
					}
				if (e == eP3) {
					P3 = lred(P3);
					kP3 = lfirst(P3);
					P3 = lred(P3);
					}
				}
			P = pmsinter(r,m,P1,kP2,kP3,a,b);
			P4 = lcomp2(P,e,P4);
			}
		if (P4 == _0) P4 = 0;
		else P4 = linv(P4);
		}

/* Ausgabe */

	return(P4);
}
