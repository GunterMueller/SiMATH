/*M
.SH NAME
ifactpp - integer factorization into pseudo primes

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifactpp(N)
int N;

.SH DESCRIPTION
ifactpp() returns the factorization of N as
a list L = ( q1,..., qr ) with 0 < q1 <=...<= qr
and N = q1 *...* qr. 
The numbers q1,...,qr are pseudo primes, i.e. they pass the
Miller-Rabin primality test with 10 randomly chosen bases.
(ten calls to isprime() with random bases,
see the documentation of isprime())
.PP
.TP 4
.B N
> 0, is the number to be factorised.

.SH SEE ALSO
ifact, isiprime, isipprime, ifactcfe.
M*/
/*H     
	Version 1 	02.07.1992	Marc Conrad
	Version 2	03.10.1994	MX-Version entfernt. MP
   DATE ifactpp       : 921130.941201
H*/

/*
	Achtung: Analog zu ifact koennen auch optional Parameter mitueber-
	geben werden. Es wurde aus Uebersichtsgruenden jedoch darauf 
	verzichtet, dieses in der Dokumentation zu erwaehnen.
*/

#include <_arith1.h>
#include <varargs.h>

list ifactpp(va_alist)
    va_dcl
{
	va_list pQ;
	list F, G;		/* F: Liste der gefundenen
				 * Primfaktoren, G: Hilfsliste */
	int M, P, Q, W, A;	/* Q,W: Hilfsvariablen    */

	/* A: alle Primfaktoren < A sind schon getestet */
	single s, c, brk, imp, rho, elc;	/* c : Zufallsvariable     */

	init(F, G, M, P, Q, W, A);

/* ------------   Vorbesetzung   -----------*/
	F = _0;
	brk = 0;
	imp = 5000;
	rho = 2500;
	elc = (1 << 25);
/* ------------ Einlesen der optionalen Parameter -----------*/
	va_start(pQ);
	Q = va_arg(pQ, int);
	if (Q <= 0 && Q > -BASIS) {
		if (Q > -10) {
			brk = -Q;
			Q = va_arg(pQ, int);
			if (brk)
				elc = 200;
		}
		if (Q <= 0 && Q > -BASIS) {
			imp = -Q;
			Q = va_arg(pQ, int);
			if (Q <= 0 && Q > -BASIS) {
				elc = -Q;
				Q = va_arg(pQ, int);
				if (Q <= 0 && Q > -BASIS) {
					rho = -Q;
					Q = va_arg(pQ, int);
				}
			}
		}
	}
	va_end(pQ);
	/* Q  = zu faktorisierende Zahl                   */


/* ---------------    Q < 2^30       --------------------------------- */
	if (issingle(Q))
		return sfact(Q);
/* ---------------    Q  < 2^60      --------------------------------- */
	if (ilog2(Q) <= 60) {
		F = dpipds(1, Q);
		return (linv(F));
	}
/* ---------------   Suche nach ganz kleinen Primfaktoren    --------- */
	F = ispd(Q, &M);
	A = 1000;

/* Suche nach restlichen Primfaktoren ( M ist jetzt zu faktorisieren ) */

	while (M != 1) {
		if (ilog2(M) <= 60) {
			F = lconc(F, dpipds(A, M));
			libsort(F);
			return (F);
		} else {
/*              ----  Miller-Rabin-Pseudo-Primzahltest  ---------	 */
			W = isqrt(M);
			if (icomp(W, A) < 0)
				s = 1;
			else {
				single k = 10;

				while (k-- && (s = isipprime(M, rand() % 1000 + 2)));
			}
/*     ------------    M Primzahl 		 */
			if (s == 1) {
				F = lcomp(M, F);
				M = 1;
				G = _0;
			}
/*       ------  M keine Primzahl  ------------------- 		 */
			else {
/*   Suche durch Probedivision   				 */
				if (A < imp) {
					P = imspds(M, A, imp);
					if (P == 1)
						A = imp;
					else {
						M = isquot(M, P);
						A = P;
						G = list1(P);
						F = lcomp(P, F);
					}
				} else
					P = 1;
/* ...  Suche durch rhopds und elcpds ... 		 */
				if (P == 1) {
					c = rand() % 1000;
					c++;

					do {
						single elcmax = 500000, i = 32;

						P = rhopds(M, c, rho);
						while ((P == 1) && (i <= elc)) {
							i += 32;
							P = elcfds(M, c, elcmax);
							c = rand() % 1000 + c;
							elcmax += elcmax;
						}
						if (P == 0)
							P = elcpds(M, c, elc);
					} while (oequal(P, M));

					if (isqrt(P) > A)
						G = ifactpp(-brk, -imp, -elc, -rho, P);
					else if (P == 1)
						G = _0;
					else
						G = list1(P);
/*  Abbruch falls brk = 1 und  Fehlversuch 					 */
					if (brk) {
						if (P == 1) {
							F = lcomp(M, F);
							libsort(F);
/* err = -1 :  */
							return (lcomp(-1, F));
						}
						if (lfirst(G) < 0) {
							iqrem(M, P, &Q, &W);
							G = lred(G);
							F = lconc(G, F);
							F = lcomp(Q, F);
							libsort(F);
							 /* err = -3 :  */ return (lcomp(-3, F));
						}
					}	/* if (brk)...  */
				}	/* if ( P == 1)...  */
			}	/* if ( s == -1)... */
/*- Herausdividieren der gefundenen Primfaktoren -*/
			while (G != _0) {
				P = lfirst(G);
				G = lred(G);
				iqrem(M, P, &Q, &W);
				while (W == 0) {
					M = Q;
					F = lcomp(P, F);
					iqrem(M, P, &Q, &W);
				}
			}
		}
/* else - Fall von 'if ( ilog2(M) <= 60 )...' */
	}			/* while( M != 1 )...                         */
	libsort(F);
	return (F);
}
