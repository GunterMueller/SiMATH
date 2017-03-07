/*M
.SH NAME
mardet - matrix of rational numbers, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

rat mardet(M)
matrix M;

.SH DESCRIPTION
mardet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix of rational numbers.
M*/




/*H
	Version 1       09.06.1988      Klaus Petry     (Kopie von mapidet)
	Version 2       22.11.1988      Klaus Petry     Null entfaellt
   DATE mardet        : 890501
H*/


#include <_matr1.h>

int mardet(M)
matrix M;
{
	single i, j, v=1;
	list Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	rat H, R, R1, R1S, R1T, R2, R2S, R3;

	bind(M);
	init(MT,Z1,Z2,Z3,H,R,R1,R1S,R1T,R2,R2S,R3);

	R1T = 0; R = 1;

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

		if (!lfirst(Z1)) {R = 0; break;}

/* Aktualisiere Vorzeichen */

		if (seven(i)) v = -v;

/* Berechne MT */

		R1 = lfirst(Z1);
		Z1 = lred(Z1);
		MT = _0;
		j = 0;
		do {
			j++;
			Z2 = lfirst(M);
			M = lred(M);
			if (j != i) {
				R2 = lfirst(Z2);
				Z2 = lred(Z2);
				Z3 = _0;
				Z1S = Z1;
				do {
					R1S = lfirst(Z1S);
					Z1S = lred(Z1S);
					R2S = lfirst(Z2);
					Z2 = lred(Z2);
					R3 = rprod(R1,R2S);
					H = rprod(R2,R1S);
					R3 = rdif(R3,H);
					if (R1T) R3 = rquot(R3,R1T);
					Z3 = lcomp(R3,Z3);
					}
				while (Z1S != _0);
				MT = lcomp(Z3,MT);
				}
			}
		while (M != _0);
		R1T = R1;
		M = MT;
		}
	if (R) {R = lfirst(lfirst(M)); if (v < 0 ) R = rneg(R);}

/* Ausgabe */

	return(R);
}
