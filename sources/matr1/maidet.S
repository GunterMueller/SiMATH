/*M
.SH NAME
maidet - matrix of integers, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

int maidet(M)
matrix M;

.SH DESCRIPTION
maidet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix over Z/mZ.
M*/


/*H
	Version 1       17.05.1988      Klaus Petry     (Kopie von mapidet)
	Version 2       22.11.1988      Klaus Petry     Null entfaellt
   DATE maidet        : 890501
H*/


#include <_matr1.h>

int maidet(M)
matrix M;
{
	single i, j, v=1;
	list Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	int H, I, I1, I1S, I1T, I2, I2S, I3;
	bind(M);
	init(MT,Z1,Z2,Z3,H,I,I1,I1S,I1T,I2,I2S,I3);
	I1T = 0; I = 0;

	I = 1;
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
		if (!lfirst(Z1)) {I = 0; break;}
/* Aktualisiere Vorzeichen */
		if (seven(i)) v = -v;
/* Berechne MT */
		I1 = lfirst(Z1);
		Z1 = lred(Z1);
		MT = _0;
		j = 0;
		do {
			j++;
			Z2 = lfirst(M);
			M = lred(M);
			if (j != i) {
				I2 = lfirst(Z2);
				Z2 = lred(Z2);
				Z3 = _0;
				Z1S = Z1;
				do {
					I1S = lfirst(Z1S);
					Z1S = lred(Z1S);
					I2S = lfirst(Z2);
					Z2 = lred(Z2);
					I3 = iprod(I1,I2S);
					H = iprod(I2,I1S);
					I3 = idif(I3,H);
					if (I1T) I3 = iquot(I3,I1T);
					Z3 = lcomp(I3,Z3);
					}
				while (Z1S != _0);
				MT = lcomp(Z3,MT);
				}
			}
		while (M != _0);
		I1T = I1;
		M = MT;
		}
	if (I) {I = lfirst(lfirst(M)); if (v < 0 ) I = ineg(I);}
/* Ausgabe */
	return(I);
}
