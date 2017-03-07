/*M
.SH NAME
pmimidqhls - polynomial over modular integers, modular ideal, Hensel lemma quadratic step on a single variable

.SH SYNOPSIS
.nf
#include<_pol2.h>

list pmimidqhls(r, M, S, P1, P2, F1, F2, i, l, H) 
single r, i, l;
int M;
list S;
pol P1, P2, F1, F2, H;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 < r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B S
= (s1,...,s(r-1)) is a list, consisting of positive singles.    
.PP
Let I be the Ideal spanned by (X1^s1,...,X(r-1)^s(r-1)), then
.TP 4
.B P1, P2, F1, F2
are polynomials in Z/M*Z[X1,...,X(r-1),Y] / I, whereat
.IP
 P1 is monic and of positive degree with regard to Y,
 and
P1 * F1 + P2 * F2 = 1 holds. 
.TP 4
.B i
is an integer number, 0 < i < r.
.TP 4
.B l
is an integer number, 0 <= l < BASIS.
.TP 4
.B H
is a polynomial in the r variables X1,...,Xr over Z/M*Z, where
.IP
P1 * P2 is congruent to H.
.PP
Let J be the ideal, spanned by (X1^s1,...,X(i-1)^s(i-1),Xi^l,X(i+1)^s(i+1),...,X(r-1)^s(r-1)), then
pmimidqhls returns a list L consisting of the polynomials Q1,Q2,G1,G2 in Z/M*Z[X1,...X(r-1),Y] / J, Q1 monic, so that
.IP
 Q1 is congruent to P1,
 Q2 is congruent to P2,
 G1 is congruent to F1,
 G2 is congruent to F2,
 deg(Q1) = deg(P1) with regard to Y and
 Q1 * Q2 is congruent to H.
.PP
The list L will be changed to 
.IP
 (s(1),...,s(i-1),l,s(i+1),...,s(r-1)).                                                                         
M*/
         
/*H
	Version 1       01.03.1989      A.Stein
   DATE pmimidqhls    : 800901.9003__
H*/


#include <_pol2.h>

list pmimidqhls(r,M,S,P1,P2,F1,F2,i,l,H)
single r,i,l;
int M;
list S;
pol P1,P2,F1,F2,H;
{
	single si;
	list L,S1,SW;
	pol P1a,P2a,HR,R1,PU,PV,ID;
	bind(M,S,P1,P2,F1,F2,H);
	init(L,S1,SW,P1a,P2a,PU,PV,ID,HR);

/* Initialisierungen */

	ID = list2(0,1);
	ID = pvinsert(1,ID,r-1);
	SW = lcopy(S);

/* Forme S um zu (s(1),..,s(i-1),l,s(i+1),..,s(r-1)) */

	S1 = lreduct(S,i-1);
	si = lfirst(S1);
	lsfirst(S1,l);

/* Bereite SW und S1 zum Wiederholungsschritt auf */

	S1 = lreduct(SW,i-1);
 
	while( si<l ) {

/* Berechne PU und PV */

		HR = pmimidprod(r,M,S,P1,P2);
		HR = pmidif(r,M,H,HR);
		HR = ppvquot(r,HR,i,si);
		PU = pmimidse(r,M,SW,P1,P2,F1,F2,HR,&PV);

/* Berechne P1a und P2a */

		PU = ppvquot(r,PU,i,-si);
		PV = ppvquot(r,PV,i,-si);
		P1a = pmisum(r,M,P1,PV);
		P2a = pmisum(r,M,P2,PU);

/* Berechne nun neue PU und PV */

		HR = pmimidprod(r,M,S,P1a,F1);
		R1 = pmimidprod(r,M,S,P2a,F2);
		HR = pmisum(r,M,HR,R1);
		HR = pmidif(r,M,HR,ID);
		HR = ppvquot(r,HR,i,si);
		PU = pmimidse(r,M,SW,P1,P2,F1,F2,HR,&PV);

/* Berechne neue F1 und F2 */

		R1 = ppvquot(r,PU,i,-si);
		F1 = pmidif(r,M,F1,R1);
		R1 = ppvquot(r,PV,i,-si);
		F2 = pmidif(r,M,F2,R1);

/* Wiederholung vorbereiten */

		si += si;
		lsfirst(S1,si);
		P1 = P1a;
		P2 = P2a;

	}/* Ende while */


	if( si > l ) {
		P1 = pimidhom(r,S,P1);
		P2 = pimidhom(r,S,P2);
		F1 = pimidhom(r,S,F1);
		F2 = pimidhom(r,S,F2);
	}

	L = list4(P1,P2,F1,F2);

/* Ausgabe */

	return(L);

}
