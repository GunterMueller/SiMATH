/*M
.SH NAME
upmisfact - univariate polynomial over modular integers squarefree factorization, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmisfact(p,P)  
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate polynomial over Z/pZ, deg(P) > 0.
.PP
upmisfact returns a list L = ((e1, P1), ..., (en, Pn)), where for 1 <= i <= n:
.PP
 the ei's  are integer numbers, ei > ... > e2 > e1 > 0,
 the Pi's are coprime, monic and square-free factors of P, and
.PP
P = P1^e1 * ... * Pn^en.
  
M*/

/*H
	Version 1	24.07.91	J.Schmitt
   DATE upmisfact     : 910915
H*/

#include <_pol2.h>

list upmisfact(ip,P)
int ip;
pol P;
{
	single e;
	list LS, M;
	pol P1, P2, P3, P4;
	bind(ip,P);
	init(LS,M,P1,P2,P3,P4);

	LS = _0;
	M  = pmideriv(1,ip,P);

	/* (1) Berechnung der Pi, fuer die ei kein Viefaches von ip ist. */

	if ( M ) {
		P2 = upmigcd(ip,P,M);
		P3 = pmiquot(1,ip,P,P2); /* P3 = P1 * ... * Pn */
		e  = 1;
		do {
			P4 = upmigcd(ip,P2,P3);
			P1 = pmiquot(1,ip,P3,P4);
			if ( lfirst(P1) ) {
				P1 = list2(e,P1);
				LS = lcomp(P1,LS);
			}
			if ( lfirst(P4) ) {
				P3 = P4;
				P2 = pmiquot(1,ip,P2,P3);
				e++;
			}
		} while ( lfirst(P4) );
	}
	else P2 = P;

	/* (2) Berechnung der Pi, fuer die ei Viefaches von ip ist. */

	if ( lfirst(P2) == 0 ) P1 = linv(LS);
	else {
		P3 = _0;
		do {
			e  = lfirst(P2);
			P2 = lred(P2);
			P4 = lfirst(P2);
			P2 = lred(P2);
			e  = iquot(e,ip);
			P3 = lcomp2(P4,e,P3);
		} while (P2 != _0);
		P2 = linv(P3);
		M  = upmisfact(ip,P2);
		P4 = M;
		do {
			P3 = lfirst(P4);
			P4 = lred(P4);
			e  = iprod(ip,lfirst(P3));
			lsfirst(P3,e);
		} while (P4 != _0);
		M  = linv(M);

	/* Mischen der beiden Listen aus (1) und (2). */

		P1 = _0;
		while (LS != _0  &&  M != _0) {
			if ( lfirst(lfirst(LS)) > lfirst(lfirst(M)) ) {
				P4 = lfirst(LS);
				LS = lred(LS);
			}
			else {
				P4 = lfirst(M);
				M = lred(M);
			}
			P1 = lcomp(P4,P1);
		}
		if ( M == _0 ) LS = linv(LS);
		else LS = linv(M);
		P1 = lconc(LS,P1);
	}

	return(P1);
}
