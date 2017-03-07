/*M
.SH NAME
pmidiscrhank - polynomial over modular integers discriminant via Hankel matrix

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmidiscrhank(r, p, P)  
single r; 
int p; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.      
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a polynomial in r variables over Z/pZ, deg(P) > 0.
.PP
pmidiscrhank returns the discriminant of P (a polynomial in r-1 variables) with regard to the main variable.

.SH SEE ALSO
For a description of the algorithm, please conference E. Weiss, Algebraic Number Theory, p. 105.   
 
M*/

/*H
        Version 1       07.01.93        M.Conrad                           
	Version 2	13.10.93	stand versehentlich in 'pol1.  PS
   DATE pmidiscrhank  : 930531.931130
H*/

#include<_pol2.h>        

#ifndef itopmi 
#define itopmi( r, M, A ) pvinsert(0, mihom( M, A ) ,r)
#endif
#define ind(i, j) (((j)-1) + n * ((i)-1))

int pmidiscrhank(r, M, q)
	int M;
	single r;
	pol q;
{
	list A, AA, SS, S;

	int a, b, c, a0, b0;
	int mkk, mik;
	single n, npe, i, j, k;

	int *enn, *eoz;
	int *pk, *aaa, *pii, *pki, *pik, *pkk, *pi;

	bind(q, M);
	init(mik, mkk);
	init(S, SS, a, b, c, A, a0, b0);

	n = pdegree(1, q);
	npe = n + 1;
/* Erzeugen des Vektors S */
	q = ptodp(1, q);
	r--;
	AA = lred(lred(q));
	a0 = lfirst(lred(q));
	b0 = pmiexp(r, M, a0, 2 * n - 2);

	SS = list1(pmiprod(r, M, itopmi(r, M, n), b0));
	for (k = 1; k <= 2 * n - 2; k++) {
		S = SS;
		A = AA;
		b = 0;
		for (i = 1; i < k; i++) {
			if (A != _0) {
				a = lfirst(A);
				A = lred(A);
			} else
				a = 0;
			c = lfirst(S);
			S = lred(S);
			b = pmisum(r, M, b, pmiprod(r, M, a, c));
		}
		if (A != _0) {
			a = lfirst(A);
			A = lred(A);
			if (a0 != 1)
				a = pmiprod(r, M, a, b0);
		} else
			a = 0;
		b = pmisum(r, M, b, pmiprod(r, M, itopmi(r, M, k), a));
		b = pmiquot(r, M, b, a0);
		b = pmineg(r, M, b);
		SS = lcomp(b, SS);

	}

	if (a0 != 1) {
		S = lred(SS);
		b0 = pvinsert(0, 1, r);

		while (S != _0) {
			a = lfirst(S);
			b0 = pmiprod(r, M, a0, b0);
			a = pmiquot(r, M, a, b0);
			lsfirst(S, a);
			S = lred(S);
		}
	}
/* Erzeugen der 'Matrix' mit Hilfe des Vektors SS (Achtung:  keine Matrix im  */
/* SIMATH'schen Sinne).                                                       */ 
/* aaa ist ein virtuelles 2-dimensionales Array, das als Eintraege Referenzen */
/* auf die Matrixinhalte enthaelt.                                            */

	if ((aaa = (int *) malloc(((j = n * n) * sizeof(int)))) == NULL) {
		fprintf(stderr, "*** memory overflow in pidiscrhank() ***\n");
		return (ERROR);
	}
	enn = aaa + (j - 1);
	pk = enn + 1;
	A = _0;
	for (i = 1; i <= n; i++) {
		S = SS;
		for (j = 1; j <= n; j++) {
			c = lfirst(S);
			S = lred(S);
			A = lcomp(c, A);
			*(--pk) = A;
		}
		SS = lred(SS);
	}
	pkk = aaa;
	c = pvinsert(0, 1, r);
	for (k = 1; k < n; k++) {
		if (lfirst(*pkk) == 0) {

			j = k;
			pii = pkk;
			do {
				j++;
				pii += npe;
			} while (j <= n && !lfirst(*(pii)));
			if (j <= n) {
				pk = pkk;
				pi = aaa + ind(j, k);
				for (i = k; i <= n; i++) {
					a = lfirst(*pk);
					lsfirst(*pk, lfirst(*pi));
					lsfirst(*pi, a);
					pk++;
					pi++;
				}
				pk = pkk;
				pi = aaa + ind(k, j);
				for (i = k; i <= n; i++) {
					a = lfirst(*pk);
					lsfirst(*pk, lfirst(*pi));
					lsfirst(*pi, a);
					pk += n;
					pi += n;
				}

			} else if (M != 2) {
/* bei Charakter. 2 ist dieser Schritt nicht moeglich     */
				j = k + 1;
				pi = aaa + ind(k, j);
				while (j <= n && !lfirst(*(pi++)))
					j++;
				if (j <= n) {
					pk = pkk;
					pi = aaa + ind(j, k);
					for (i = k; i <= n; i++) {
						a = lfirst(*pk);
						lsfirst(*pk, pmisum(r, M, a, lfirst(*pi)));
						pk++;
						pi++;
					}
					pk = pkk;
					pi = aaa + ind(k, j);
					for (i = k; i <= n; i++) {
						a = lfirst(*pk);
						lsfirst(*pk, pmisum(r, M, a, lfirst(*pi)));
						pk += n;
						pi += n;
					}

				} else {
					free((char *) aaa);
					return (0);
				}
			} else {
/* Sonderbehandlung bei Char. 2: Berechnung mit mapmsdet( )   */
/* Speichern der Restmatrix in eine SIMATH-Matrix             */
/* und berechnen der Determinante mit mapmsdet                */ 
				SS = _0;
				for (i = n; i >= k; i--) {
					S = _0;
					for (j = n; j >= k; j--) {
						pi = aaa + ind(i, j);
						S = lcomp(lfirst(*pi), S);
					}
					SS = lcomp(S, SS);
				}
				S = _0; A = _0; 
				S = mapmsdet(r, M, SS);
				SS = pmiexp(r, M, c, n - k);
				A = pmiquot(r, M, S, SS);

				goto fertig;
			}

		}
		mkk = lfirst(*(pkk));
		pik = pii = pki = pkk;
		eoz = pkk + (npe - k);
		while (pii != enn) {
			pik += n;
			pii += npe;
			pki++;
			mik = lfirst(*(pik));
			pi = pii;
			pk = pki;
			while (pk != eoz) {
				a = pmiprod(r, M, mkk, lfirst(*(pi)));
				b = pmiprod(r, M, mik, lfirst(*(pk++)));
				a = pmidif(r, M, a, b);
				lsfirst(*(pi++), pmiquot(r, M, a, c));
			}
		}
		pii = pkk + npe;
		eoz += (n - 1);

		while (pii != enn) {
			pk = pi = pii;
			while (pi != eoz) {
				pk += n;
				lsfirst(*(pk), lfirst(*(++pi)));
			}
			eoz += n;
			pii += npe;
		}
		c = mkk;
		pkk += npe;
	}

	A = lfirst(*pkk);      

fertig: 
	c = n * n - 3 * n + 2;
	b0 = pmiexp(r, M, a0, c);
	free((char *) aaa);
	return (pmiquot(r, M, A, b0));
}
