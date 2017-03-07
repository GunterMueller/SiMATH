/*M
.SH NAME
upiresulc - univariate polynomial over the integers resultant and cofactor of resultant equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

int upiresulc(P1, P2, pB) 
pol P1, P2, *pB;

.SH DESCRIPTION
.TP 4
.B P1, P2 
are univariate polynomials over the integer numbers with positive degree.
.PP
Let r be the resultant of P1 and P2 (hence r is an integer number), and let B be an univariate polynomial over the integer numbers, such that there exists an univariate polynomial A over the integer numbers with
.IP
P1 * A + P2 * B = r.
.PP
upiresulc returns r and writes B to *pB. ( r will be computed with the help of the Collins algorithm)
 
.SH SEE ALSO
G.E. Collins, The Calculation of Multivariate Polynomial Resultants, Journal ACM, No. 4,18 (Oct. 1971), 515-532.

M*/

/*H
	Version 1       05.05.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Sicherung von *pB;
   DATE upiresulc     : 891101.900101
H*/


#include <_pol2.h>

int upiresulc(P1,P2,pB)
pol P1, P2;
pol *pB;
{

    single e1, e2, i, m, q, *Pl;
    int A1, A2, S, Q, a;
    pol B, BS, P1S, P2S, P3S;
    bind(P1,P2);
    init(A1,A2,S,Q,a,B,BS,P1S,P2S,P3S);

/* Berechnung der Koeffizienten-Schranke */

    A1 = pimaxnorm(1,P1);
    A2 = pimaxnorm(1,P2);
    e1 = lfirst(P1);
    e2 = lfirst(P2);
    A1 = iexp(A1,e2);
    A2 = iexp(A2,e1);
    S = ifactl(e1+e2);
    S = iprod(A1,S);
    S = iprod(A2,S);


    Q = 1;
    a = 0;
    B = 0;
    Pl = LIST_GSP;


    while (icomp(Q,S) < 0) {
	if (*Pl) m = *Pl, Pl++;
	else {
	    m = m - 2;
	    while (issprime(m,&i) != 1) m = m - 2;
        }
	P1S = pitopms(1,P1,m);
	if (pdegree(1,P1S) == e1) {
	    P2S = pitopms(1,P2,m);
	    if (pdegree(1,P2S) == e2) {
		P3S = upmsresulc(m,P1S,P2S,&BS);
		q = mshom(m,Q);
		q = msinv(m,q);
		a = picra(0,a,P3S,Q,m,q);
		B = picra(1,B,BS,Q,m,q);
		Q = isprod(Q,m);
            }
	}
    }

    *pB = B;
    return(a);
}
