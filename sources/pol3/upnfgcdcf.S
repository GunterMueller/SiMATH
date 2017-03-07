/*M
.SH NAME
upnfgcdcf - univariate polynomial over number field greatest common divisor and cofactors

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upnfgcdcf(F, P1, P2, pQ1, pQ2) 
pol F, P1, P2, *pQ1, *pQ2;
  
.SH DESCRIPTION
Let K be a number field,
.TP 4
.B F
is the respective univariate minimal polynomial of degree >= 1 in dense representation, i.e. K arises by the adjunction of a root of F.
.TP 4
.B P1, P2
are univariate polynomials over K.
.TP 4
.B pQ1, pQ2
point on two polynomials.
.PP
upnfgcdcf computes the greatest common divisor, say P3, of P1 and P2 and two polynomials, say Q1 and Q2, where
.PP
Q1 = P1 / P3, Q2 = P2 / P3, for P3 != 0, and
.PP
Q1 = 0 = Q2, else.
.PP
Please note, that P3 is monic. upnfgcdcf returns P3 and writes Q1 and Q2 to *pQ1, *pQ2 respectively.
 
.SH SEE ALSO
 upnfgcd
 upnfegcd

M*/
                             
/*H
	Version 1       17.11.1989      A.Stein
   DATE upnfgcdcf     : 900315
H*/


#include <_pol3.h>

pol upnfgcdcf(F,P1,P2,pQ1,pQ2)
pol F, P1, P2;
pol *pQ1,*pQ2;
{
	pol P3;
	bind(F,P1,P2);
	init(P3);

/* P1,P2 gleich 0 */

	if (!P1  &&  !P2) {P3 = 0; *pQ1 = 0; *pQ2 = 0;}

/* P1 gleich 0 */

	else if (!P1) {
		P3 = pnfmonic(1,F,P2);
		*pQ2 = pvinsert(0,plc(1,P2),1);
		*pQ1 = 0;
	}

/* P2 gleich 0 */

	else if (!P2) {
		P3 = pnfmonic(1,F,P1);
		*pQ1 = pvinsert(0,plc(1,P1),1);
		*pQ2 = 0;
	}

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		P3 = upnfgcd(F,P1,P2);
		*pQ1 = pnfquot(1,F,P1,P3);
		*pQ2 = pnfquot(1,F,P2,P3);
	}

/* Ausgabe */

	return(P3);

}
