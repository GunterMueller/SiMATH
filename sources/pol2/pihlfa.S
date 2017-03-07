/*M
.SH NAME
pihlfa - polynomial over integers, Hensel lemma factorization approximation

.SH SYNOPSIS
.nf
#include<_pol2.h>

list pihlfa(r, p, L, M, S, P) 
single r, p;
list L, S;
int M;
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.                     
.TP 4
.B p
is a prime number, p < BASIS.                      
.TP 4
.B P
is a polynomial in the r variables X1,...,Xr over the integer numbers. p has not
to divide the leading coefficient of P.         
.TP 4
.B L
= (P1,...,Pn) is a list, consisting of univariate, monic and coprime polynomials over Z/pZ of positive degree, whereat
.IP
P(0,...,0,X) = P1 * ... * Pn mod p.
.TP 4
.B M
= p^j, for a positive integer j.
.TP 4
.B S
= (s1,...,s(r-1)) is a list, consisting of non negative singles.
.PP
Let I be the Ideal spanned by (X1^s1,...,X(r-1)^s(r-1)), then 
pihlfa returns a list, say L = (H1,...,Hn), of monic polynomials in
Z/M*Z[X1,...,X(r-1),X] / I, where
.IP
 P = H1 * ... * Hn mod M,
.PP
and for 1 <= i <= n is
.IP
 Hi congruent to Pi, and
 deg(Hi) = deg(Pi) with regard to X.

M*/

/*H
	Version 1       03.03.1989      A.Stein
	Version 1.2     13.09.1990      ueberfl. Testausgaben rausgeworfen. AS
   DATE pihlfa        : 891101.9003__.901120
H*/


#include <_pol2.h>

list pihlfa(r,p,L,M,S,P)
single r,p;
list L,S;
int M;
pol P;
{
	single i,hr;
	list L1,S1;
	pol Q,Ph,P1,P2,F1,F2;
	bind(L,M,S,P);
	init(L1,S1,P1,P2,F1,F2,Ph);

/* Initialisierungen */

	hr = r-1;
	L1 = _0;
	Ph = pimidhom(r,S,P);
	Ph = pitopmi(r,Ph,M);

	for(S1=_0,i=hr;i--;S1=lcomp(1,S1));

/* Hensel-Lemma fuer jeden Faktor von L */

	while( L!=_0) {

/* Berechne P1,P2,F1 und F2 */

		P1 = lfirst(L);
		L = lred(L);
		P2 = ptoup(r,Ph);
		P2 = pitopmi(1,P2,p);
		P2 = pmiquot(1,p,P2,P1);
		Q = upmsegcd(p,P1,P2,&F1,&F2);
		P1 = pvinsert(1,P1,hr);
		P2 = pvinsert(1,P2,hr);
		F1 = pvinsert(1,F1,hr);
		F2 = pvinsert(1,F2,hr);
		P1 = pmimidqhl(r,p,S1,P1,P2,F1,F2,M,S,Ph,&Q);
		L1 = lcomp(P1,L1);
		if( L!=_0 ) Ph = pmimidqrem(r,M,S,Ph,P1,&Q);
	}
	L1 = linv(L1);

/* Ausgabe */

	return(L1);

}
