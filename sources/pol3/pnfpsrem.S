/*M
.SH NAME
pnfpsrem - polynomial over number field pseudo remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfpsrem(r, F, P1, P2) 
single r; 
pol F, P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P1, P2
are polynomials in r variables over K.
.PP
pnfpsrem returns the pseudo-remainder (say P3) of P1 and P2, i.e. for deg(P1) >= deg(P2)
.PP
P3 = (P1*k^(deg(P1)-deg(P2)+1))%P2, where
.PP
k is the leading coefficient of P2.
.PP
For deg(P1) < deg(P2), pnfpsrem returns P1.  

.SH SEE ALSO
pnfrem

M*/
                          
/*H
	Version 1	02.03.95	Wolfgang Schwarz
   DATE pnfpsrem      : 951201
H*/

#include <_pol3.h>

pol pnfpsrem(r,F,P1,P2)
single r;
pol F,P1, P2;
{
	single e1, e2, e3;
	pol P3, P2D, P2S, k3;
	bind(F,P1,P2);
	init(P3,P2D,P2S,k3);

/* Grad von P2 ist 0 */

	e2 = lfirst(P2);
	if (!e2) P3 = 0;

/* Grad von P2 ist groesser 0 */

	else {
		e1 = pdegree(r,P1);
		P3 = P1;
		P2S = lsecond(P2);
		P2 = pred(r,P2);
		P2S = list2(0,P2S);
		for ( ; e1 >= e2; e1--) {
			if (!P3) break;
			e3 = lfirst(P3);
			if (e3 == e1) {
				k3 = lsecond(P3);
				P3 = pred(r,P3);
				P3 = pnfprod(r,F,P3,P2S);
				P2D = list2(e3-e2,k3);
				P2D = pnfprod(r,F,P2,P2D);
				P3 = pnfdif(r,F,P3,P2D);
				}
			else P3 = pnfprod(r,F,P3,P2S);
			}
		}

/* Ausgabe */

	return(P3);
}
