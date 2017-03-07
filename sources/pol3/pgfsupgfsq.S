/*M
.SH NAME
pgfsupgfsp - polynomial over Galois-field with single characteristic, univariate polynomial over Galois-field with single characteristic quotient
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsupgfsq(r, p, AL, P1, P2)  
single r, p; 
list AL; 
pol P1, P2;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 2 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
is the arithmetic list of a finite field of characteristic p, say Fq.
.TP 4
.B P1
is a polynomial in Fq[X1, ..., Xr].
.TP 4
.B P2
is a polynomial in Fq[X1], P2 divides P1.
.PP
pgfsupgfsq returns a polynomial, say P3, where
.IP
P3 = P1 / P2.

M*/
             
/*H
	Version 1 	02.05.95	Wolfgang Schwarz	
   DATE pgfsupgfsq    : 951201
H*/

#include <_pol3.h>

pol pgfsupgfsq(r,p,AL,P1,P2)
single r,p;
list AL;
pol P1, P2;
{
	single eP1;
	pol P3, kP1;
	bind(AL,P1,P2);
	init(P3,kP1);

/* P1 ungleich 0 */

	if (P1) {
		r--;
		P3 = _0;
		while (P1 != _0) {
			eP1 = lfirst(P1);
			P1 = lred(P1);
			kP1 = lfirst(P1);
			P1 =lred(P1);
			if (r == 1) kP1 = pgfsquot(r,p,AL,kP1,P2);
			else kP1 = pgfsupgfsq(r,p,AL,kP1,P2);
			P3 = lcomp2(kP1,eP1,P3);
		}
		P3 = linv(P3);
	}

/* P1 gleich 0 */

	else P3 = 0;

/* Ausgabe */

	return(P3);
}
