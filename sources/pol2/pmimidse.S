/*M
.SH NAME
pmimidse - polynomial over modular integers modular ideal solution of equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmimidse(r, M, S, P1, P2, F1, F2, H, pV) 
single r;
int M;
list S;
pol P1, P2, F1, F2, H, *pV;
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4                                         
.B M
is an integer number, M > 0.
.TP 4
.B S
= (s1,...,s(r-1)) is a list, consisting of non negative singles. 
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
.B H
is a polynomial in Z/M*Z[X1,...,X(r-1),Y] / I.
.PP
pmimidse computes the two polynomials U and V (say) in Z/M*Z[X1,...,X(r-1),Y] / I, so that
.IP
 P1 * U + P2 * V = H, and
 deg(V) < deg(P1) with regard to Y.
.PP
pmimidse returns U and writes V to *pV.
                          
M*/
            
/*H
	Version 1       23.02.89        A.Stein
   DATE pmimidse      : 891101
H*/


#include <_pol2.h>

pol pmimidse(r,M,S,P1,P2,F1,F2,H,pV)
single r;
int M;
list S;
pol P1,P2,F1,F2,H,*pV;
{
	pol PU,Q1,Q2,V;
	bind(M,S,P1,P2,F1,F2,H);
	init(PU,Q1,Q2,V);

/* H = H * ( P1 * F1 + P2 * F2 ) = H * P1 * F1 + H * P2 * F2.  */
/* H * F2 = q * P1 + r => pV = r und PU = F1 * H + P2 * q .    */


	Q1 = pmimidprod(r,M,S,F2,H);
	Q2 = pmimidqrem(r,M,S,Q1,P1,&V);
/* pV = ( F2 * H ) % P1 . */

	*pV = V;
	Q1 = pmimidprod(r,M,S,F1,H);
	Q2 = pmimidprod(r,M,S,P2,Q2);
	PU = pmisum(r,M,Q1,Q2);
/* PU = F1 * H + P2 * ( ( F2 * H ) / P1 ) .  */


/* Ausgabe */

	return(PU);
}
