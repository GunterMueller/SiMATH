/*M
.SH NAME
udpmsderiv - univariate dense polynomial over modular singles derivation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsderiv(m, P)  
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m 
is an integer number, 0 < m < BASIS. 
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.
.PP
udpmsderiv returns the derivation of P.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	25.11.94	Logik der if(k)-Abfrage 
					korrigiert. AS
   DATE udpmsderiv    : 890501.941201
H*/


#include <_pol1.h>

pol udpmsderiv(m,P)
single m;
pol P;
{
        single e, e1=(-1), k;
	pol P1;
	bind(P);
	init(P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		e = lfirst(P);
		P = lred(P);
		P1 = _0;
		do {
			k = lfirst(P);
			P = lred(P);
			k = msprod(m,k,e);
			if ( (e1 == -1) || !e ) {
				if ( k ) {
					e1 = e-1;
					P1 = lcomp(k,P1);
				}
			}
			else P1 = lcomp(k,P1);
			e--;
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else {P1 = linv(P1); P1 = lcomp(e1,P1);}
		}

/* Ausgabe */

	return(P1);
}
