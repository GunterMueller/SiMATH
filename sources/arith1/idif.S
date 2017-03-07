/*M
.SH NAME
idif - integer difference

.SH SYNOPSIS
.nf
#include<_arith1.h>

int idif(A, B)
int A, B;

.SH DESCRIPTION
idif() returns A-B.
M*/

/*H
	Version 1	28.07.1986	R. Boeffgen
	Version 2       03.07.1992	kein Macro mehr.  MC
	Version 3	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE idif          : 890501.921130.941201
H*/


#include <_arith1.h>

#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }
#define lpmoc_start( AA ) { if ( AVAIL == _0 ) gc(); AA = AVAIL; }

/* zur Arbeitsweise dieser beiden Macros siehe Doku zu isum */

int idif(A, B)
	int A, B;
{
	/***    A oder B Null    ***/
	if (A == 0)
		return (ineg(B));
	if (B == 0)
		return (A);
	/***    A und B einfach-genau    ***/
	if (isatom(A) && isatom(B)) {
		int D;

		if ((D = A - B) >= BASIS)
			return (list2(D - BASIS, 1));
		if (D <= -BASIS)
			return (list2(D + BASIS, -1));
		return (D);
	}
	/***    Vorbesetzungen    ***/
	{
		obj a, b;
		single c, u, s = isign(A), t = -isign(B);
		list C0, CC;

		bind(A, B);
		init(CC);


		/***    gleiche Vorzeichen von A und -B   ***/
		lpmoc_start(CC)
			if (s == t) {
			if (isatom(A))
				a = A, A = _0;
			else
				a = lfirst(A), A = lred(A);

			if (isatom(B))
				b = B, B = _0;
			else
				b = lfirst(B), B = lred(B);

			c = a - b;

			if (c >= BASIS)
				c -= BASIS, u = 1;
			else if (c <= -BASIS)
				c += BASIS, u = -1;
			else
				u = 0;
			lpmoc(C0, c)
				while (u || (A != _0 && B != _0)) {
				if (A != _0)
					a = lfirst(A), A = lred(A);
				else
					a = 0;
				if (B != _0)
					b = lfirst(B), B = lred(B);
				else
					b = 0;
				c = (a - b) + u;
				if (c >= BASIS)
					c -= BASIS, u = 1;
				else if (c <= -BASIS)
					c += BASIS, u = -1;
				else
					u = 0;
				lpmoc(C0, c)
			}
			if (A == _0) {
				while (B != _0) {
					b = lfirst(B);
					B = lred(B);
					lpmoc(C0, -b)
				}
				lsred(C0, _0);
			} else
				lsred(C0, A);
		} else
			/***    unterschiedliche Vorzeichen von A und -B   ***/
		{
			single v = 0;

			if (isatom(A))
				a = A, A = _0;
			else
				a = lfirst(A), A = lred(A);
			if (isatom(B))
				c = a - B, B = _0;
			else
				c = a - lfirst(B), B = lred(B);
			if (c != 0)
				v = c;
			lpmoc(C0, c)
				while (A != _0 && B != _0) {
				a = lfirst(A), A = lred(A);
				b = lfirst(B), B = lred(B);
				c = a - b;
				if (c != 0)
					v = c;
				lpmoc(C0, c)
			}
			/***    Ergebnis Null    ***/
			if (v == 0 && A == _0 && B == _0) {
				return (0);
			}
			/***    uebriger Teil von A    ***/
			if (A != _0 && s != ssign(v)) {
				do {
					v = lfirst(A);
					A = lred(A);
					lpmoc(C0, v)
				}
				while (v == 0);
			} else if (B != _0 && t != ssign(v))
				do {
					v = -lfirst(B);
					B = lred(B);
					lpmoc(C0, v)
				}
				while (v == 0);

/* 		  	vereinheitliche Vorzeichen              */
/* a und b jetzt Hilfsvariablen, die auf Listenelemente zeigen 	*/

			a = CC;
			u = 0;

			do {
				c = lfirst(a);
				c += u;
				if (v > 0 && c < 0)
					c += BASIS, u = -1;
				else if (v < 0 && c > 0)
					c -= BASIS, u = 1;
				else
					u = 0;
				if (c != 0)
					b = a;
				lsfirst(a, c);
				a = lred(a);
			}
			while (a != AVAIL);
			/***    Concatenation bzw. Loeschen fuehrender Nullen    ***/
			if (A != _0)
				lsred(C0, A);
			else if (B != _0) {
				do {
					a = lfirst(B);
					B = lred(B);
					lpmoc(C0, -a);
				} while (B != _0);
				lsred(C0, _0);
			} else {
				lsred(b, _0);
				if (lred(CC) == _0)
					CC = lfirst(CC);
			}
		}
		return (CC);
	}
}
