/*M
.SH NAME
pidiscrhank - polynomial over integers discriminant via Hankel- matrix

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pidiscrhank(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers of degree > 0.
.PP 
pidiscrhank returns the discriminant of P with regard to the main variable.

.SH NOTES
For a description of the algorithm, please conference E. Weiss, Algebraic Number theory, p. 105.

.SH SEE ALSO
pidiscr

M*/

/*H
	Version 1       07.01.93	M.Conrad
   DATE pidiscrhank   : 930531.9311__
H*/

#include<_pol2.h>
#define ind(i, j) (((j)-1) + n * ((i)-1))

int pidiscrhank(r, q)    
	single r;
	pol q;
{
	list A, AA, SS, S;

	int a, b, c, a0, b0;
	int mkk, mik;
	single n, npe, i, j, k;

	int *enn, *eoz;
	int *pk, *aaa, *pii, *pki, *pik, *pkk, *pi;

	bind(q);
	init(mik, mkk);
	init(S, SS, a, b, c, A, a0, b0);

	n = pdegree(1, q);
	npe = n + 1;
/* Erzeugen des Vektors S */
	q = ptodp(1, q);    
        r--;
	AA = lred(lred(q));
	a0 = lfirst(lred(q));
	b0 = piexp(r, a0, 2 * n - 2);

	SS = list1(piprod(r, itopi(r, n), b0));
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
			b = pisum(r, b, piprod(r, a, c));
		}
		if (A != _0) {
			a = lfirst(A);
			A = lred(A);
			if (a0 != 1)
				a = piprod(r, a, b0);
		} else
			a = 0;
		b = pisum(r, b, piprod(r, itopi(r, k), a));
		b = piquot(r, b, a0);
		b = pineg(r, b);
		SS = lcomp(b, SS);

	}

	if (a0 != 1) {
		S = lred(SS);
		b0 = itopi( r, 1);

		while (S != _0) {
			a = lfirst(S);
			b0 = piprod(r, a0, b0);
			a = piquot(r, a, b0);
			lsfirst(S, a);
			S = lred(S);
		}
	}
/* Erzeugen der 'Matrix' mit Hilfe des Vektors SS (Achtung:  keine Matrix im  */
/* SIMATH'schen Sinne).                                                       */
	if ((aaa = (int *) malloc(((j = n * n) * sizeof(int)))) == NULL) {  
		printf("*** memory overflow in pidiscrhank() ***\n");
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
	c = itopi( r, 1 );
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

			} else {
				j = k + 1;
				pi = aaa + ind(k, j);
				while (j <= n && !lfirst(*(pi++)))
					j++;
				if (j <= n) {
					pk = pkk;
					pi = aaa + ind(j, k);
					for (i = k; i <= n; i++) {
						a = lfirst(*pk);
						lsfirst(*pk, pisum(r, a, lfirst(*pi)));
						pk++;
						pi++;
					}
					pk = pkk;
					pi = aaa + ind(k, j);
					for (i = k; i <= n; i++) {
						a = lfirst(*pk);
						lsfirst(*pk, pisum(r, a, lfirst(*pi)));
						pk += n;
						pi += n;
					}

				} else {
					free((char *) aaa);
					return (0);
				}
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
				a = piprod(r, mkk, lfirst(*(pi)));
				b = piprod(r, mik, lfirst(*(pk++)));
				a = pidif(r, a, b);
				lsfirst(*(pi++), piquot(r, a, c));
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
	b0 = piexp(r, a0, n * n - 3 * n + 2);
	free((char *) aaa);
	return (piquot(r, A, b0));
}



                       






