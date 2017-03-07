/*M
.SH NAME
maiherm - matrix of integers, Hermite normal form

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maiherm(M, ne)
matrix M;
single ne;

.SH DESCRIPTION
maiherm() returns the Hermite normal form H of M.
For ne=0, H will only have positive entries below the principal diagonal.
For ne=1, H will only have negative entries below the principal diagonal.

.PP
.TP 4
.B M
is a square matrix of integers with a non-zero determinant.
.TP 4
.B ne
is a switch as described above.

.SH SEE ALSO
maihermltne, maihermltpe
M*/



/*H
	Version 1       27.01.1989      Klaus Petry
   DATE maiherm       : 890501.9107__
H*/

#include <_matr2.h>

maiherm (A, ne)
matrix A;
single ne;  /** 0 oder 1 **/

{
	int a;          /* A (i,i)                              */
	int b;          /* A (j,i)                              */
	int d;          /* | Det (A) |                          */
	int g;          /* ggT (a, b), bzw ggT (a, d)           */
	int ca;         /* a/g     * in Schritt 1 wird a zu     */
	int cbneg;      /* -b/g    * ggT (a, b) und b zu 0      */
	int p;          /* falls g = ggT(a, b), so gilt:        */
	int q;          /* g = p*a + q*b                        */
	int AColFaktor; /* in Schritt 2 benutzt                 */
	single i;
	single j;
	single k;
	single n;
	vec Zi, Zj;
	int aneu, bneu;

	bind (A);
	init (a, b, aneu, bneu, d, g, ca, cbneg, p, q, AColFaktor);

	A = macopy (A);
	d = iabs (maidet (A));
	n = manrrow (A);
	maam (A, d);
	A = matransp (A);
	for (i=1; i<=n; i++) {
		for (j=i+1; j<=n+i; j++) {
			a = maselel (A, i, i);
			b = maselel (A, j, i);
			g = iegcd (a, b, &p, &q);
			if (g) {
				cbneg = ineg (iquot (b, g));
				ca = iquot (a, g);
				k = 1;
				Zi = lfirst (lreduct (A, i-1));
				Zj = lfirst (lreduct (A, j-1));
				while (Zi != _0) {
					a = lfirst (Zi);
					b = lfirst (Zj);
					aneu = iprod (a, p);
					aneu = isum (aneu, iprod (b, q));
					bneu = iprod (a, cbneg);
					bneu = isum (bneu, iprod (b, ca));
					if (k++ > i) {
						aneu = mihom (d, aneu);
						bneu = mihom (d, bneu);
						}
					lsfirst (Zi, aneu);
					lsfirst (Zj, bneu);
					Zi = lred (Zi);
					Zj = lred (Zj);
					}
				}
			}
		a = maselel (A, i, i);
		g = iegcd (a, d, &p, &q);
		for (j=1; j<i; j++) {
			b = maselel (A, j, i);
			AColFaktor = ineg (iquot (b, g));
			b = isum (b, iprod (AColFaktor, g));
			if (isign (b) > 0) {
				if (ne)
					AColFaktor = isum (AColFaktor, -1);
				}
			else  {
				if (!ne)
					AColFaktor = isum (AColFaktor, 1);
				}
			Zi = lfirst (lreduct (A, i-1));
			Zj = lfirst (lreduct (A, j-1));
			while (Zi != _0) {
				b = iprod (AColFaktor, lfirst (Zi));
				b = isum (b, lfirst (Zj));
				lsfirst (Zj, b);
				Zi = lred (Zi);
				Zj = lred (Zj);
				}
			}
		}
 
	lsred (lreduct (A, n-1), _0); 
	A = matransp (A);

	return (A);
}
