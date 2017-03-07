/*M
.SH NAME
udpmirem - univariate dense polynomial over modular integers remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmirem(m, P1, P2)  
int m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
is a prime number.    
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over Z/mZ, P2 != 0.
.PP
udpmirem returns the remainder on dividing P1 by P2.

.SH SEE ALSO
 udpmiquot
 udpmiqrem

M*/

/*H
	Version 1	24.07.91	J.Schmitt
   DATE udpmirem      : 910915
H*/

#include <_pol1.h>

pol udpmirem(ip,P,P2)
int ip;
pol P, P2;
{
	single e1, e2, s;
	int c, k1, k2, k2s;
	pol P1, P1S, P1SS, P2S, P3;
	bind(ip,P,P2);
	init(c,k1,k2,k2s,P1,P1S,P1SS);

	P1 = lcopy(P);
	e2 = lfirst(P2);
	P3 = 0;

	if (e2) {
		P2 = lred(P2);
		k2 = lfirst(P2);
		P2 = lred(P2);
		k2s = miinv(ip,k2);
		do {
			e1 = lfirst(P1);
			P1S = lred(P1);
			s = -1;
			k1 = lfirst(P1S);
			P1SS = lred(P1S);
			c = miprod(ip,k1,k2s);
			P2S = P2;
			do {
				k2 = lfirst(P2S);
				P2S = lred(P2S);
				k2 = miprod(ip,k2,c);
				k1 = lfirst(P1SS);
				k1 = midif(ip,k1,k2);
				e1--;
				if (s < 0  &&  k1) {s = e1; P1 = P1S;}
				lsfirst(P1SS,k1);
				P1S = P1SS;
				P1SS = lred(P1S);
			} while (P2S != _0);
			while (s < 0  &&  P1SS != _0) {
				e1--;
				if (lfirst(P1SS)) {s = e1; P1 = P1S;}
				P1S = P1SS;
				P1SS = lred(P1S);
			}
			if (s >= 0) lsfirst(P1,s);
		} while (s >= e2);
		if (s >= 0) P3 = P1;
	}

	return(P3);
}
