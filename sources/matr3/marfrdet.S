/*M
.SH NAME
marfrdet - matrix of rational functions over the rational numbers, determinant

.SH SYNOPSIS
.nf
#include<_matr3.h>

rfunc marfrdet(r, M)
single r;
matrix M;

.SH DESCRIPTION
marfrdet() returns the determinant det(M).

.PP
.TP 4
.B M
is a square matrix of rational functions in r variables over the rational numbers.
M*/






/*H                                                               
        Version 1       05.06.1989      U. Schneiders, Th. Weis
   DATE marfrdet      : 890801.9109__
H*/


#include <_matr3.h>

rfunc marfrdet(r,M)
single r;
matrix M;
{
	single i, j, v=1;
	list Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	rfunc H, P, P1, P1S, P1T, P2, P2S, P3;
	bind(M);
	init(MT,Z1,Z2,Z3,H,P,P1,P1S,P1T,P2,P2S,P3);
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
					P3 = rfrprod(r,P1,P2S);
					H = rfrprod(r,P2,P1S);
					P3 = rfrdif(r,P3,H);
					if (P1T) P3 = rfrquot(r,P3,P1T);
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
	if (P) {P = lfirst(lfirst(M)); if (v < 0 ) P = rfrneg(r,P);}

/* Ausgabe */

	return(P);
}


