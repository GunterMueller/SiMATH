/*M
.SH NAME
upisfp - univariate polynomial over integers, squarefree part

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upisfp(P)  
pol P;

.SH DESCRIPTION
.TP 4
.B P
is an univariate, monic polynomial over the integer numbers, deg(P) > 0.
.PP
upisfp returns the square-free part of P (say P1), i.e.
.PP
P = P1 * P2^2,	and g.c.d.(P1, P2) = 1.

M*/

/*H
	Version 1	24.06.94	S.Schmitt
   DATE	upisfp	      : 941201
H*/

#include <_pol2.h>

pol upisfp(P)
pol P;
{
	obj L,P1,c;
	single i;
	bind(P);
	init(L,P1,c);

	L=lsecond(P);
	P1=list2(0,1);
	if(icomp(L,0)<0) i = (-1);
	else i = 1;
	P=piiprod(1,P,i);
	c=piicont(1,P);
	P=piiquot(1,P,c);

/* Berechnung von P1 */

	L = pisfact(1,P);
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = piprod(1,P1,lsecond(P));
		}
	P1=piiprod(1,P1,i);
	c=isfp(c);
	P1=piiprod(1,P1,c);
	return(P1);
}
