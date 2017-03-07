/*M
.SH NAME
pgfsinter - polynomial over Galois-field of single characteristic interpolation
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsinter(r, p, AL, P1, P2, P3, a, b)
single r, p; 
list AL; 
pol P1, P2, P3; 
gfel a, b;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL                 
is the arithmetic list of a finite field with characteristic p, say K.
.TP 4
.B P1
is a polynomial over K in the variable X1.
.TP 4
.B P2
is a polynomial over K in the r variables X1,...,Xr. P2 = 0 or deg(P2) < deg(P1) (with regard to X1).
.TP 4
.B P3
is a polynomial over K in the r-1 variables X2,...,Xr.
.TP 4
.B a
is an element in K, P1(a) != 0. 
.TP 4
.B b
is equal to P1(a)^(-1).
.PP
pgfsinter returns the unique polynomial, say P4, over K in the variables X1, ..., Xr, such that
.PP
 P4(X1,...,Xr) = P2(X1,...,Xr) mod P1(X1),
 P4(a,X2,...,Xr) = P3(X2,...,Xr);
 deg(P4) < deg(P1) (with regard to X1).
 
M*/
                      
/*H
	Version 1 	02.05.95	Wolfgang Schwarz	
   DATE pgfsinter     : 951201
H*/

#include <_pol3.h>

pol pgfsinter(r,p,AL,P1,P2,P3,a,b)
single r,p;
list AL;
pol P1;
pol P2;
pol P3;
gfel a, b;
{
	single e, eP2, eP3;
	gfel c;
	pol P, P4, kP2, kP3;
	bind(AL,P1,P2,P3,a,b);
	init(c,P,P4,kP2,kP3);

/* Grad(P1) gleich 0 */

	e = pdegree(1,P1);
	if (!e) P4 = pvinsert(r-1,P3,1);

/* r gleich 1 */

	else if (r == 1) {
		c = pgfseval(r,p,AL,P2,a);
		c = gfsdif(p,AL,P3,c);
		if (c) {
			c = gfsprod(p,AL,c,b);
			P4 = pgfsgfsprod(1,p,AL,P1,c);
			P4 = pgfssum(1,p,AL,P4,P2);
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
			P = pgfsinter(r,p,AL,P1,kP2,kP3,a,b);
			P4 = lcomp2(P,e,P4);
		}
		if (P4 == _0) P4 = 0;
		else P4 = linv(P4);
	}

/* Ausgabe */

	return(P4);
}
