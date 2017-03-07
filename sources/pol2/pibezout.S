/*M
.SH NAME
pibezout - polynomial over integers Bezout-matrix

.SH SYNOPSIS
.nf
#include<_pol2.h>

matrix pibezout(r, P1, P2) 
single r; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the integer numbers, so that
.IP
pdegree(r,P1) >= pdegree(r,P2) >= 1.
.PP
pibezout returns the Bezout-matrix for P1 and P2.
   
.SH NOTE
The determinant of the matrix is ( maybe up to the sign ) equal to the resultant of P1 and P2.

.SH SEE ALSO
piresbez

M*/

/*H
	Version 1       14.09.1987      B. Weis
	Version 2       30.09.1987      B. Weis
			Dokumentation geaendert
	Version 3       05.01.1988      B. Weis
			Typ matrix eingefuehrt
	Version 4       06.07.1988      B. Weis
			Programm berichtigt
   DATE pibezout      : 890501
H*/


#include <_pol2.h>

matrix pibezout(r,P1,P2)
single r;
pol P1, P2;
{
	single e, e1, e2, h, i;
	pol k, D1, D2, P1T, P1TS, P2S, P2T, P2TS;
	matrix M;
	bind(P1,P2);
	init(k,D1,D2,M,P1T,P1TS,P2S,P2T,P2TS);

/* Initialisierungen */

	if (lfirst(P1) < lfirst(P2)) M = P1, P1 = P2, P2 = M;
	e1 = lfirst(P1);
	e2 = e1-lfirst(P2);
	P1T = _0;
	P2S = ppmvprod(r,P2,e2);
	P2T = _0;
	M = _0;

/* Schleife 1 zur Konstruktion der Bezout-Matrix */

	for (i = e1; i > e2; i--) {
		P1TS = P1T;
		while (P1TS != _0) {
			h = lfirst(P1TS);
			lsfirst(P1TS,h+1);
			P1TS = lred2(P1TS);
			}
		if (P1  &&  lfirst(P1) >= i) {
			e = lfirst(P1)-i;
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			if (P1 == _0) P1 = 0;
			P1T = linv(P1T);
			P1T = lcomp2(k,e,P1T);
			P1T = linv(P1T);
			}
		P2TS = P2T;
		while (P2TS != _0) {
			h = lfirst(P2TS);
			lsfirst(P2TS,h+1);
			P2TS = lred2(P2TS);
			}
		if (P2S  &&  lfirst(P2S) >= i) {
			e = lfirst(P2S)-i;
			P2S = lred(P2S);
			k = lfirst(P2S);
			P2S = lred(P2S);
			if (P2S == _0) P2S = 0;
			P2T = linv(P2T);
			P2T = lcomp2(k,e,P2T);
			P2T = linv(P2T);
			}
		D1 = piprod(r,P1T,P2S);
		D2 = piprod(r,P1,P2T);
		D1 = pidif(r,D1,D2);
		if (D1) {
			D1 = ptodp(1,D1);
			e = lfirst(D1);
			D1 = lred(D1);
			}
		else {
			D1 = _0;
			e = -1;
			}
		for (h = e1-1; h > e; h--) D1 = lcomp(0,D1);
		M = lcomp(D1,M);
		}

/* Schleife 2 zur Konstruktion der Bezout-Matrix */

	for ( ; i; ) {
		i--;
		P2T = ppmvprod(r,P2,i);
		P2T = ptodp(1,P2T);
		e = lfirst(P2T);
		P2T = lred(P2T);
		for (h = e1-1; h > e; h--) P2T = lcomp(0,P2T);
		M = lcomp(P2T,M);
		}
	M = linv(M);

/* Ausgabe */

	return(M);
}
