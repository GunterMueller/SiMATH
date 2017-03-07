/*M
.SH NAME
upnfsfp - univariate polynomial over number field, squarefree part

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upnfsfp(F, P)  
obj F; 
pol P;
           
.SH DESCRIPTION
Let K be a number field,
.TP 4
.B F
is the respective univariate minimal polynomial of degree >= 1 in dense representation, i.e. K arises by the adjunction of a root of F.
.TP 4
.B P
is a primitive and univariate polynomial of positive degree over K.
.PP
upnfsfp returns the squarefree part of P, i.e. a polynomial, say P1, such that
.PP
P = P1 * P2^2 and gcd(P1, P1') = 1 holds.

M*/
      
/*H
	Version 1 	21.07.94           S.Schmitt
   DATE upnfsfp	      : 941201
H*/

#include <_pol3.h>

pol upnfsfp(F,P)
obj F;
pol P;
{
	list L;
	pol P1;
	bind(F,P);
	init(L,P1);

/* Berechnung von P1 */
	L = upnfsfact(F,P);
	P1 = list2(0,list3(1,0,1));
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = pnfprod(1,F,P1,lsecond(P));
		}
	return(P1);
}
