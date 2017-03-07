/*M
.SH NAME
mapmidet - matrix of polynomials over modular integers, determinant

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapmidet(r, m, M)
single r;
int m;
matrix M;

.SH DESCRIPTION
mapmidet() returns the determinant det(M) of the matrix M.

.PP
.TP 4
.B M
is a square matrix of polynomials in r variables over Z/mZ.
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE mapmidet      : 910915
H*/

#include <_matr1.h>

pol mapmidet(r,m,M)
single r;
int m;
matrix M;
{
	single i, j, v=1;
	list Z1, Z1S, Z2, Z3;
	matrix MS, MT;
	pol H, P, P1, P1S, P1T, P2, P2S, P3;
	bind(m,M);
	init(MT,Z1,Z2,Z3,H,P,P1,P1S,P1T,P2,P2S,P3);

	P1T = 0;
	P   = 1;


	while (lred(M) != _0) {

/* Suche Pivot-Zeile */

		MS = M;
		i = 0;
		do {
			i++;
			Z1 = lfirst(MS);
			MS = lred(MS);
		} while ( lfirst(Z1) == 0  &&  MS != _0 );

/* M hat nicht vollen Rang */
		if (!lfirst(Z1)) {
			P = 0; 
			break;
		}

		if (seven(i)) v = -v;

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
					P3 = pmiprod(r,m,P1,P2S);
					H = pmiprod(r,m,P2,P1S);
					P3 = pmidif(r,m,P3,H);
					if (P1T) P3 = pmiquot(r,m,P3,P1T);
					Z3 = lcomp(P3,Z3);
				} while (Z1S != _0);
				MT = lcomp(Z3,MT);
			}
		} while (M != _0);
		P1T = P1;
		M = MT;
	}
	if (P) {
		P = lfirst(lfirst(M)); 
		if (v < 0 ) P = pmineg(r,m,P);
	}

	return(P);
}
