/*M
.SH NAME
upgfssfp - univariate polynomial over Galois-field with single characteristic squarefree part

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfssfp(p, AL, P)  
single p; 
list AL;  
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4                       
.B P
is a monic and univariate polynomial over GF(p^n) of positive degree.
.PP
upgfssfp returns the squarefree part of P, i.e. a polynomial, say P1, such that
.PP
P = P1 * P2^2 and gcd(P1, P1') = 1 holds.
              
.SH SEE ALSO
gfsalgen

M*/
      
/*H
	Version 1         13.04.88           J.Schmitt
   DATE upgfssfp      : 890501.9203__
H*/


#include <_pol3.h>

pol upgfssfp(p,AL,P)
single p;
list AL;
pol P;
{
	list L;
	pol P1;
	bind(AL,P);
	init(L,P1);

/* Berechnung von P1 */
	L = upgfssfact(p,AL,P);
	P1 = list2(0,1);
	P1 = list2(0,P1);
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = pgfsprod(1,p,AL,P1,lsecond(P));
		}
	return(P1);
}
