/*M
.SH NAME
picra - polynomial over integers chinese remainder algorithm (recursive)
.SH SYNOPSIS
.nf
#include<_pol1.h>

pol picra(r, P1, P2, M, m, a)  
single r, m, a; 
pol P1, P2; 
int M; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B M 
is an integer number, M > 0.
.TP 4
.B m 
is an integer number, 1 <= m < BASIS.
 The gcd(m,M) must be 1.
.TP 4
.B a 
is the multipicative inverse of mshom(m,M).
.TP 4
.B P1 
is a polynomial in r variables over Z/MZ, its base coefficients must be units in Z/MZ.
.TP 4
.B P2
is a polynomial in r variables over Z/mZ.
.PP
picra computes the unique polynomial P in r variables, whose base coefficients are units in Z/MmZ, and with 
.PP
    P congruent to P1 modulo M,
    P congruent to P2 modulo m.

.SH SEE ALSO
mshom

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	14.05.1992	kP1, kP2 und kP3 gebunden.  US
   DATE picra         : 890501.920601
H*/


#include <_pol1.h>

pol picra(r,P1,P2,M,m,a)
single r;
pol P1, P2;
int M;
single m, a;
{
	single eP1, eP2, eP3;
	pol P3, kP1, kP2, kP3;
	bind3(P1,P2,M);
	init(P3,kP1,kP2,kP3);

/* r gleich 0 */

	if (!r) P3 = miscra(M,m,a,P1,P2);

/* r ungleich 0 */

	else {
		if (!P1) P1 = _0;
		if (!P2) P2 = _0;
		r--;
		P3 = _0;
		while (P1 != _0  ||  P2 != _0) {
			if (P1 == _0) {
				kP1 = 0;
				eP3 = lfirst(P2);
				P2 = lred(P2);
				kP2 = lfirst(P2);
				P2 =lred(P2);
				}
			else {
				if (P2 == _0) {
					kP2 = 0;
					eP3 = lfirst(P1);
					P1 = lred(P1);
					kP1 = lfirst(P1);
					P1 = lred(P1);
					}
				else {
					eP1 = lfirst(P1);
					eP2 = lfirst(P2);
					if (eP1 > eP2) {
						kP2 = 0;
						eP3 = eP1;
						P1 = lred(P1);
						kP1 = lfirst(P1);
						P1 = lred(P1);
						}
					else {
						if (eP1 < eP2) {
							eP3 = eP2;
							kP1 = 0;
							P2 = lred(P2);
							kP2 = lfirst(P2);
							P2 = lred(P2);
							}
						else {
							eP3 = eP1;
							P1 = lred(P1);
							kP1 = lfirst(P1);
							P1 = lred(P1);
							P2 = lred(P2);
							kP2 = lfirst(P2);
							P2 = lred(P2);
							}
						}
					}
				}
			if (r) kP3 = picra(r,kP1,kP2,M,m,a);
			else kP3 = miscra(M,m,a,kP1,kP2);
			P3 = lcomp2(kP3,eP3,P3);
			}
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
		}

/* Ausgabe */

	return(P3);
}
