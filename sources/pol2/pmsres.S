/*M
.SH NAME
pmsres - polynomial over modular singles resultant

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsres(r, p, P1, P2, n) 
single r, p, n; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over Z/pZ.
.TP 4
.B n
is an integer number, 1 <= n < 3.
.PP
pmsres returns the resultant, say P3, of P1 and P2, so P3 is a polynomial in r-1 variables.
.PP
The value of n determines the algorithm used by pmsres as follows :
.IP
 n = 1: computation of the determinant of the
        Sylvester matrix (s. psylvester),
 n = 2: computation of the determinant of the
        Bezout matrix (s. pmsbezout),
 n = 3: Collins algorithm (s. pmsrescoll).           
.PP
For r = 1, pmsres uses the Collins algorithm (independent of n).

.SH CAUTION
In some cases, it could be possible that the Collins algorithm does not lead to
a result, then pmsres returns ERROR.
.PP
The determinant of the Bezout matrix can differ from the resultant by the factor -1.

.SH SEE ALSO
 psylvester
 pmsbezout
 pmsrescoll
                                                  
M*/
             
/*H
	Version 1       01.10.1987      B. Weis
   DATE pmsres        : 890501
H*/


#include <_pol2.h>

pol pmsres(r,m,P1,P2,n)
single r;
single m;
pol P1, P2;
single n;
{
	single e1, e2;
	pol H, P3, k1, k2;
	bind2(P1,P2);
	init4(H,P3,k1,k2);

/* Sonderfaelle und Minimierung des Problems */

	if (!P1  ||  !P2) P3 = 0;
	else if (!lfirst(P1)  &&  !lfirst(P2)) P3 = pvinsert(0,1,r-1);
	else if (!lfirst(P1)) P3 = pmsexp(r-1,m,lsecond(P1),lfirst(P2));
	else if (!lfirst(P2)) P3 = pmsexp(r-1,m,lsecond(P2),lfirst(P1));
	else {
		H = P1;
		while (H != _0) {
			e1 = lfirst(H);
			H = lred(H);
			k1 = lfirst(H);
			H = lred(H);
			}
		H = P2;
		while (H != _0) {
			e2 = lfirst(H);
			H = lred(H);
			k2 = lfirst(H);
			H = lred(H);
			}
		if (e1  &&  e2) P3 = 0;
		else if (e1) {
			P1 = ppmvquot(r,P1,e1);
			H = pmsexp(r-1,m,k2,e1);
			if (!lfirst(P1)) P3 = pmsexp(r-1,m,lsecond(P1),lfirst(P2));
			else if (r == 1) P3 = upmsres(m,P1,P2);
			else switch(n) {
				case 1: P3 = psylvester(r,P1,P2);
					P3 = mapmsdet(r-1,m,P3);
					break;
				case 2: P3 = pmsbezout(r,m,P1,P2);
					P3 = mapmsdet(r-1,m,P3);
					break;
				case 3: P3 = pmsrescoll(r,m,P1,P2);
					break;
				default: break;
				}
			P3 = pmsprod(r-1,m,P3,H);
			}
		else if (e2) {
			P2 = ppmvquot(r,P2,e2);
			H = pmsexp(r-1,m,k1,e2);
			if (sodd(e2)  &&  sodd(lfirst(P1))) H = pmsneg(r-1,m,H);
			if (!lfirst(P2)) P3 = pmsexp(r-1,m,lsecond(P2),lfirst(P1));
			else if (r == 1) P3 = upmsres(m,P1,P2);
			else switch(n) {
				case 1: P3 = psylvester(r,P1,P2);
					P3 = mapmsdet(r-1,m,P3);
					break;
				case 2: P3 = pmsbezout(r,m,P1,P2);
					P3 = mapmsdet(r-1,m,P3);
					break;
				case 3: P3 = pmsrescoll(r,m,P1,P2);
					break;
				default: break;
				}
			P3 = pmsprod(r-1,m,P3,H);
			}
		else if (r == 1) P3 = upmsres(m,P1,P2);
		else switch(n) {
			case 1: P3 = psylvester(r,P1,P2);
				P3 = mapmsdet(r-1,m,P3);
				break;
			case 2: P3 = pmsbezout(r,m,P1,P2);
				P3 = mapmsdet(r-1,m,P3);
				break;
			case 3: P3 = pmsrescoll(r,m,P1,P2);
				break;
			default: break;
			}
		}

/* Ausgabe */

	return(P3);
}
