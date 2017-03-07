/*M
.SH NAME
pmsrescoll - polynomial over modular singles resultant, Collins algorithm, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsrescoll(r, p, P1, P2) 
single r, p; 
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
are polynomials in r variables over Z/pZ of positive degree.
.PP
pmsrescoll returns the resultant (say P3) of P1 and P2, so P3 is a polynomial in r-1 variables over Z/pZ.    
In order to compute the resultant, pmsrescoll uses the Collins algorithm.
In some cases, it could be possible that the Collins algorithm does not lead to
a result, then pmsrescoll returns ERROR.

.SH SEE ALSO
 pmsres
 literature: G.E. Collins, The Calculation of Multivariate
             Polynomial Resultants,
             Journal ACM, No. 4,18 (Oct. 1971), 515-532.
                                          
M*/

/*H
	Version 1       05.10.1987      B. Weis
   DATE pmsrescoll    : 890501
H*/


#include <_pol2.h>

pol pmsrescoll(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single a, e1, e2, es1, es2, i, k, rs;
	pol D, DS, P1S, P2S, P3, P3S;
	bind2(P1,P2);
	init6(D,DS,P1S,P2S,P3,P3S);

/* r gleich 1 */

	if (r == 1) P3 = upmsres(m,P1,P2);
	else {

/* Initialisierungen */

		e1 = lfirst(P1);
		es1 = pdegreesv(r,P1,1);
		e2 = lfirst(P2);
		es2 = pdegreesv(r,P2,1);
		k = e1*es2+e2*es1;
		rs = r-1;
		P3 = 0;
		D = list2(0,1);

/* Rekursion */

		for (i = 0 ; i < m; i++) {
			P1S = pmsevalsv(r,m,P1,1,i);
			if (pdegree(r,P1S) == e1) {
				P2S = pmsevalsv(r,m,P2,1,i);
				if (pdegree(r,P2S) == e2) {
					if ((P3S = pmsrescoll(rs,m,P1S,P2S)) == -BASIS-1) {P3 = P3S; break;}
					a = pmseval(1,m,D,i);
					a = msinv(m,a);
					P3 = pmsinter(rs,m,D,P3,P3S,i,a);
					DS = list4(1,1,0,m-i);
					D = pmsprod(1,m,D,DS);
					if (pdegree(1,D) > k) break;
					}
				}
			}
		if (i == m) P3 = -BASIS-1;
		}

/* Ausgabe */

	return(P3);
}
