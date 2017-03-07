/*M
.SH NAME
udpipsrem - univariate dense polynomial over integers pseudo remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpipsrem(P1, P2)  
pol P1, P2;

.SH DESCRIPTION
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over the integer numbers, P2 != 0.
.PP
udpipsrem returns the pseudo remainder P3 of P1 and P2.
.PP
For k = the leading coefficient of P2 , 
    t = k^(deg(P1)-deg(P2)+1)         , is 
.PP
P3 = ( t * P1 ) mod P2, if deg(P1) >= deg(P2)
   = P1               , else.
  
M*/

/*H
	Version 1       01.08.1988      Pascale Serf
   DATE udpipsrem     : 890501
H*/


# include <_pol1.h>

pol udpipsrem(P1,P2)
pol P1, P2;
{
	single e1, e2, e3;
	pol P3, P3S, P2D, P2Q, P2S, k3;
	bind(P1,P2);
	init(P3,P3S,P2D,P2Q,P2S,k3);

/* Grad von P2 ist 0 */

	e2 = ( P2==0 ? 0 : lfirst(P2) );        /* Grad von P2 */
	if (!e2) P3 = 0;

/* Grad von P2 ist groesser 0 */

	else {
		e1 = ( P1==0 ? 0 : lfirst(P1) );        /* Grad von P1 */
		P3 = P1;
		P2Q = dpred(1,P2);
		P2S = lsecond(P2);              /* Leitkoeffizient von P2 */
		P2S = list2(0,P2S);
		for ( ; e1 >= e2; e1--) {
			if (!P3) break;
			e3 = lfirst(P3);        /* Grad von P3 */
			if (e3 == e1) {
				k3 = lsecond(P3);       /* Leitkoeffizient von P3 */
				P3 = dpred(1,P3);
				P3 = udpiprod(P3,P2S);
				P3S = list2(e3-e2,k3);
				P3S = ptodp(1,P3S);
				P2D = udpiprod(P2Q,P3S);
				P3 = udpidif(P3,P2D);
				}
			else P3 = udpiprod(P3,P2S);
			}
		}

/* Ausgabe */

	return(P3);
}
