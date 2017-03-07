/*M
.SH NAME
pmimidprod - polynomial over modular integers, modular ideal product

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmimidprod(r, M, S, P1, P2) 
single r;
int M;
list S;
pol P1, P2;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.               
.TP 4
.B M
is an integer number.
.TP 4
.B S
= (s1 ... s(r-1)) is a list, consisting of non negative singles.  
.PP
Let I be the ideal, spanned by (X1^s1,...,X(r-1)^s(r-1)), then
.TP 4
.B P1, P2
are polynomials in Z/M*Z[X1,...,X(r-1),Y] / I.
.PP                                            
pmimidprod returns the polynomial P3, where
.IP
P3 = P1 * P2.
                                      
M*/

/*H
	Version 1       23.02.1989      A.Stein
   DATE pmimidprod    : 891101
H*/


#include <_pol2.h>
 
pol pmimidprod(r,M,S,P1,P2)
single r;
int M;
list S;
pol P1,P2;
{
	pol P;
	bind(M,S,P1,P2);
	init(P);

	P = pimidprod(r,S,P1,P2);

/* Ausgabe */

	return( pitopmi(r,P,M) );
}
