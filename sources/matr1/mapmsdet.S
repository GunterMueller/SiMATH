/*M
.SH NAME
mapmsdet - matrix of polynomials over modular singles, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapmsdet(r, m, M)
single r, m;
matrix M;

.SH DESCRIPTION
mapmsdet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix of polynomials in r variables over Z/mZ.
M*/

/*H
	Version 1       21.09.1987      B. Weis
	Version 2       05.01.1988      B. Weis
			Typ matrix eingefuehrt
	Version 3       22.11.1987      Klaus Petry     Null entfaellt
   DATE mapmsdet      : 890501.9203__
H*/


#include <_matr1.h>

pol mapmsdet(r,m,M)
single r;
single m;
matrix M;
{
	single i, j, v=1;
	list Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	pol H, P, P1, P1S, P1T, P2, P2S, P3;
	bind(M);
	init6(MT,Z1,Z2,Z3,H,P);
	init6(P1,P1S,P1T,P2,P2S,P3);
	P1T = 0; P = 1;


/* Schleife */

	while (lred(M) != _0) {

/* Suche Pivot-Zeile */

		MS = M;
		i = 0;
		do {
			i++;
			Z1 = lfirst(MS);
			MS = lred(MS);
			}
		while (lfirst(Z1) == 0  &&  MS != _0);

/* M hat nicht vollen Rang */

		if (!lfirst(Z1)) {P = 0; break;}

/* Aktualisiere Vorzeichen */

		if (seven(i)) v = -v;

/* Berechne MT */

		P1 = lfirst(Z1);
		Z1 = lred(Z1);
		MT = _0;
		j = 0;
		do {
			j++;
			Z2 = lfirst(M);
			M = lred(M);
			if (j != i) {
				P2 = lfirst(Z2);
				Z2 = lred(Z2);
				Z3 = _0;
				Z1S = Z1;
				do {
					P1S = lfirst(Z1S);
					Z1S = lred(Z1S);
					P2S = lfirst(Z2);
					Z2 = lred(Z2);
					P3 = pmsprod(r,m,P1,P2S);
					H = pmsprod(r,m,P2,P1S);
					P3 = pmsdif(r,m,P3,H);
					if (P1T) P3 = pmsquot(r,m,P3,P1T);
					Z3 = lcomp(P3,Z3);
					}
				while (Z1S != _0);
				MT = lcomp(Z3,MT);
				}
			}
		while (M != _0);
		P1T = P1;
		M = MT;
		}
	if (P) {P = lfirst(lfirst(M)); if (v < 0 ) P = pmsneg(r,m,P);}

/* Ausgabe */

	return(P);
}
