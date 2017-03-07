/*M
.SH NAME
pmiucont - polynomial over modular integers univariate content, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmiucont(r,p,P)  
single r; 
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 2 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a polynomial in the r variables X1,...,Xr over Z/pZ.
.PP
pmiucont returns the polynomial P1, which is the content of P over Z/pZ[X1].
                                          
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE pmiucont      : 910915
H*/

#include <_pol2.h>

pol pmiucont(r,m,P)
single r;
int m;
pol P;
{
	pol P1, P2;
	bind(m,P);
	init(P1,P2);

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
				P1 = upmigcd(m,P2,P1);
			}
		}
		else {
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			P1 = pmiucont(r,m,P1);
			while (P != _0  &&  lfirst(P1)) {
				P = lred(P);
				P2 = lfirst(P);
				P = lred(P);
				P2 = pmiucont(r,m,P2);
				P1 = upmigcd(m,P2,P1);
			}
		}
	}
	else P1 = 0;

/* Ausgabe */

	return(P1);
}
