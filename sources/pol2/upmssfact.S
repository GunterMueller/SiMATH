/*M
.SH NAME
upmssfact - univariate polynomial over modular singles squarefree factorization, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmssfact(p ,P) 
single p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate polynomial over Z/pZ, deg(P) > 0.
.PP
upmssfact returns a list L = ((e1, P1), ..., (en, Pn)), where for 1 <= i <= n:  
.PP                                                                             
 the ei's  are integer numbers, ei > ... > e2 > e1 > 0,                         
 the Pi's are coprime, monic and square-free factors of P, and                  
.PP                                                                             
P = P1^e1 * ... * Pn^en.                                                        
                                                          
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE upmssfact     : 890501
H*/


#include <_pol2.h>

list upmssfact(m,P)
single m;
pol P;
{
	single e2, j, k2;
	list L, LS, L1, M, MS, M1;
	pol PS, P1, P2, P3, P4, P2S;
	bind(P);
	init6(L,LS,L1,M,MS,M1);
	init6(PS,P1,P2,P3,P4,P2S);

/* Initialisierungen */

	LS = _0;
	PS = pmsderiv(1,m,P);

/* Berechnung der Pi, fuer die ei nicht durch m teilbar ist */

	if (PS) {
		P2 = upmsgcd(m,P,PS);
		P3 = pmsquot(1,m,P,P2);
		j = 1;
		do {
			P4 = upmsgcd(m,P2,P3);
			P1 = pmsquot(1,m,P3,P4);
			if (lfirst(P1)) {
				P1 = list2(j,P1);
				LS = lcomp(P1,LS);
				}
			if (lfirst(P4)) {
				P3 = P4;
				P2 = pmsquot(1,m,P2,P3);
				j++;
				}
			}
		while (lfirst(P4));
		}
	else P2 = P;

/* Berechnung der Pi, fuer die ei durch m teilbar ist */

	if (lfirst(P2) == 0) L = linv(LS);
	else {
		P2S = _0;
		do {
			e2 = lfirst(P2);
			P2 = lred(P2);
			k2 = lfirst(P2);
			P2 = lred(P2);
			e2 /= m;
			P2S = lcomp2(k2,e2,P2S);
			}
		while (P2 != _0);
		P2 = linv(P2S);
		M = upmssfact(m,P2);
		MS = M;
		do {
			M1 = lfirst(MS);
			MS = lred(MS);
			e2 = m * lfirst(M1);
			lsfirst(M1,e2);
			}
		while (MS != _0);
		M = linv(M);
		L = _0;

		/* Mischen von LS und M */

		while (LS != _0  &&  M != _0) {
			if (lfirst(lfirst(LS)) > lfirst(lfirst(M))) {
				L1 = lfirst(LS);
				LS = lred(LS);
				}
			else {
				L1 = lfirst(M);
				M = lred(M);
				}
			L = lcomp(L1,L);
			}
		if (M == _0) LS = linv(LS);
		else LS = linv(M);
		L = lconc(LS,L);
		}

/* Ausgabe */

	return(L);
}
