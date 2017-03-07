/*M
.SH NAME
pmsucont - polynomial over modular singles univariate content, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsucont(r, p, P) 
single r, p; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 2 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P
is a polynomial in the r variables X1,...,Xr over Z/pZ.
.PP
pmsucont returns the polynomial P1, which is the content of P over Z/pZ[X1].
                                                   
M*/
                              
/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsucont      : 890501
H*/


#include <_pol2.h>

pol pmsucont(r,m,P)
single r;
single m;
pol P;
{
	pol P1, P2;
	bind(P);
	init2(P1,P2);

/* Berechnung des Inhaltes von P */

	if (P) {
		r--;
		if (r == 1) {
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			while (P != _0  &&  lfirst(P1)) {
				P = lred(P);
				P2 = lfirst(P);
				P = lred(P);
				P1 = upmsgcd(m,P2,P1);
				}
			}
		else {
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			P1 = pmsucont(r,m,P1);
			while (P != _0  &&  lfirst(P1)) {
				P = lred(P);
				P2 = lfirst(P);
				P = lred(P);
				P2 = pmsucont(r,m,P2);
				P1 = upmsgcd(m,P2,P1);
				}
			}
		}
	else P1 = 0;

/* Ausgabe */

	return(P1);
}
