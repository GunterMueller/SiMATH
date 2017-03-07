/*M
.SH NAME
pmimidqrem - polynomial over modular integers monic, modular ideal quotient and remainder

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmimidqrem(r, M, S, P1, P2, pR) 
single r;
int M;
list S; 
pol P1, P2, *pR;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.        
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B SL
= (s1,...,s(r-1)) is a list, consisting of non negative singles.
.PP
Let I be the Ideal spanned by (X1^s1,...,X(r-1)^s(r-1)), then
.TP 4
.B P1, P2
are polynomials in Z/M*Z[X1,...,X(r-1),Y] / I, P2 is monic.
.PP
pmimidqrem computes the division with remainder of P1 by P2
.IP 
P1 = P2 * P3 + Prem,
.PP
where Prem is the remainder of the division,so that
.PP
deg(P2) > deg(Prem) with regard to Y.  
pmimidqrem returns P3. Prem can be found at *pR.

M*/

/*H
	Version 1       23.02.89        A.Stein
   DATE pmimidqrem    : 891101
H*/


#include <_pol2.h>

pol pmimidqrem(r,M,S,P1,P2,pR)
single r;
int M;
list S;
pol P1, P2;
pol *pR;
{
	single e1,e2,d;
	pol P,Q,LC;
	bind(M,S,P1,P2);
	init(P,LC);

/* Initialisierungen */

		e2 = pdegree(r,P2);
		P2 = pred(r,P2);
		P = _0;

/* Berechnung von P1/P2 und P1%P2 */

		while (P1) {
			e1 = pdegree(r,P1);
			if ( (d = e1-e2) < 0 ) break;
			LC = plc(r,P1);
			P = lcomp2(LC,d,P);
			Q = pmimidprod(r,M,S,P2,list2(d,LC));
			P1 = pmidif(r,M,pred(r,P1),Q);
		}
		P = ( P == _0) ? ( 0 ) : ( linv(P) ) ;
		*pR = P1;

/* Ausgabe */

	return(P);
}
