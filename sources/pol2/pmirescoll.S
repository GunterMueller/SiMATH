/*M
.SH NAME
pmirescoll - polynomial over modular integers resultant, Collins algorithm

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmirescoll(r, p, P1, P2)  
single r; 
int p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number.                         
.TP 4
.B P1, P2
are polynomials in r variables over Z/pZ of positive degree.
.PP
pmirescoll returns the resultant (say P3) of P1 and P2, so P3 is a polynomial in r-1 variables over Z/pZ.
In order to compute the resultant, pmirescoll uses the Collins algorithm.
In some cases, it could be possible that the Collins algorithm does not lead to
a result, then pmirescoll returns ERROR.
       
.SH SEE ALSO
 pmires
 literature: G.E. Collins, The Calculation of Multivariate
             Polynomial Resultants,
             Journal ACM, No. 4,18 (Oct. 1971), 515-532.
       
M*/
                             
/*H
	Version 1 	16.08.91	J.Schmitt
   DATE pmirescoll    : 910915
H*/

#include <_pol2.h>

pol pmirescoll(r,m,P1,P2)
single r;
int m;
pol P1, P2;
{
	single e1, e2, es1, es2, k, rs;
	int a, i;
	pol D, DS, P1S, P2S, P3, P3S;
	bind(m,P1,P2);
	init(a,i,D,DS,P1S,P2S,P3,P3S);

/* r gleich 1 */

	if (r == 1) P3 = upmires(m,P1,P2);
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

		for (i = 0 ; icomp(i,m) < 0; i= isum(i,1) ) {
			P1S = pmievalsv(r,m,P1,1,i);
			if (pdegree(r,P1S) == e1) {
				P2S = pmievalsv(r,m,P2,1,i);
				if (pdegree(r,P2S) == e2) {
	if ((P3S = pmirescoll(rs,m,P1S,P2S)) == ERROR ) {P3 = P3S; break;}
					a = pmieval(1,m,D,i);
					a = miinv(m,a);
					P3 = pmiinter(rs,m,D,P3,P3S,i,a);
					DS = list4(1,1,0,idif(m,i));
					D = pmiprod(1,m,D,DS);
					if (pdegree(1,D) > k) break;
				}
			}
		}
		if ( !icomp(i,m) ) P3 = ERROR;
	}

/* Ausgabe */

	return(P3);
}
