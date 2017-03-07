/*M
.SH NAME
pimidqhl - polynomial over integers, modular ideal, Hensel lemma quadratic step

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pimidqhl(r, p, S, P1, P2, F1, F2, M, H,pB)  
single r, p; 
int M; 
list S;
pol P1, P2, F1, F2, H, *pB;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.       
.TP 4
.B S
= (s1,...,s(r-1)) is a list, consisting of non negative singles.
.PP
Let I be the Ideal spanned by (X1^s1,...,X(r-1)^s(r-1)), then       
.TP 4
.B P1, P2, F1, F2
are polynomials in Z/pZ[X1,...,X(r-1),Y] / I, whereat
.IP
 P1 is monic and of positive degree with regard to Y, 
 and
P1 * F1 + P2 * F2 = 1 holds.
.TP 4
.B M
= p^j, for a positive integer j.  
.TP 4
.B H
is a polynomial in the r variables X1,...,Xr over the integer numbers, where
.IP
P1 * P2 is congruent to H.
.PP
pimidqhl computes the polynomials A and B of Z/M*Z[X1,...,X(r-1),Y] / I, A monic, so that 
.IP
 A is congruent to P1,
 B is congruent to P2,
 A * B is congruent to H and
 deg(A) = deg(P1) with regard to Y.
.PP
pimidqhl returns A and writes B to *pB.

M*/

/*H
	Version 1       27.02.1989      A.Stein
	Version 1.2     13.09.1990      ueberfl. Testausgaben rausgeworfen. AS
   DATE pimidqhl      : 891101.9003__.901120.9203__
H*/


#include <_pol2.h>

pol pimidqhl(r,p,S,P1,P2,F1,F2,M,H,pB)
single r,p;
int M;
list S;
pol P1,P2,F1,F2,H,*pB;
{
	pol PA;
	init(PA);

/* Trivialfall */

	if ( icomp(p,M)==0 ) {
		PA = P1;
		*pB = P2;
	}

	else {
		single ind;
		int p2j,pmod;
		pol ID,P1h,P2h,W,PU,PV,G;
		bind(S,P1,P2,F1,F2,M,H);
		init(p2j,pmod,ID,P1h,P2h,PU,PV,G);

		ID = pvinsert(0,1,r);

		for ( ; ; ) {

/* Berechne PU und PV */

			G = pmimidprod(r,M,S,P1,P2);
			G = pidif(r,H,G);
			G = piiquot(r,G,p);

/* G = ( H - ( P1 * P2 ) ) / p    */

			p2j = iprod(p,p);

			if( (ind = icomp(p2j,M)) > 0 ) {
				pmod = iquot(M,p);
				P1h = pitopmi(r,P1,pmod);
				P2h = pitopmi(r,P2,pmod);
				F1 = pitopmi(r,F1,pmod);
				F2 = pitopmi(r,F2,pmod);
			}
			else {
				pmod = p;
				P1h = P1;
				P2h = P2;
			}

			G = pitopmi(r,G,pmod);
			PU = pmimidse(r,pmod,S,P1h,P2h,F1,F2,G,&PV);

/* PU und PV erfuellen: P1h * PU + P2h * PV = GH    */


/* Berechne neue P1 und P2, als Kandidaten fuer PA und *pB  */

			W = piiprod(r,PV,p);
			P1h = pisum(r,P1,W);
			W = piiprod(r,PU,p);
			P2h = pisum(r,P2,W);

/* Pruefe nach, ob fertig */

			if( ind >= 0 ) {
				PA = P1h;
				*pB = P2h;
				break;
			}

/* Ansonsten  fuehre naechsten Schritt aus mit PU(1) und PV(1) */

			G = pmimidprod(r,p2j,S,P1h,F1);
			W = pmimidprod(r,p2j,S,P2h,F2);
			G = pmisum(r,p2j,G,W);
			G = pmidif(r,p2j,G,ID);
			G = piiquot(r,G,p);

			PU = pmimidse(r,p,S,P1,P2,F1,F2,G,&PV);

/* Berechne neue F1 und F2 */

			W = piiprod(r,PU,p);
			F1 = pmidif(r,p2j,F1,W);
			W = piiprod(r,PV,p);
			F2 = pmidif(r,p2j,F2,W);

/* Aufbereitung zur Wiederholung */

			p = p2j;
			P1 = P1h;
			P2 = P2h;
		}

	}

/* Ausgabe */

	return(PA);

}
