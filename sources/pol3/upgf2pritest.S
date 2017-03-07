/*M
.SH NAME
upgf2pritest - univariate polynomial over Galois-field with characteristic 2 primitivity test

.SH SYNOPSIS
.nf
#include <_pol3.h>

upgf2pritest(G,P)
pol G,P;

I = upgf2pritest(G,P);

.SH DESCRIPTION
upgf2pritest() tests the primitivity of P.
The exponent of a polynomial P(X) over GF(2^n) is the minimal e such that P(X) 
divides X^e-1. The polynomial P(X) is primitive, if the exponent of P(X) has 
the maximal possible value 2^n-1.
.TP 4
.B G
is an irreducible, univariate polynomial in special
bit representation (see udpm2tosb() for a description).
G is a generating polynomial for GF(2^n).
.TP 4
.B P
is an univariate polynomial over GF(2^n).
.TP 4
.B I
is 1, if P ist primitive; 0, if it could be shown that P is reducible;
< 0, if P ist not primitive.
M*/
/*H
	Version 1	07.10.1996	Joachim Schmitt
	DATE upgf2pritest	: 961201
H*/

#include <_pol3.h>

int upgf2pritest(G,P)

pol G,P;
{
	single m,n;
	int I,Q;
	list L;
	pol H;
	bind(G,P);
	init(I,Q,L,H);

	H = pgf2eval(1,G,P,0); if(!H){/*printf("\n !!! x | P(x) !!!");*/ return(-1);}
	H = lsecond(P);if(!oequal(H,list2(0,1))){/*printf("\n P not monic !!!");*/ return (-2);}

	n = lfirst(G);
	Q = iexp(2,n);
	m = pdegree(1,P);
	I = idif(iexp(Q,m),1);
	H = upgf2mprem(G,list2(0,1),I,P);
	if(!oequal(H,list2(0,list2(0,1)))){/*printf("\n P not irreducible !!!");*/ return (0);}

	L = ifact(I);
	while(L!=_0) {
		Q = lfirst(L); L = lred(L);
		while((L!=_0)&&(oequal(Q,lfirst(L)))) L=lred(L);
		Q = iquot(I,Q);
		H = upgf2mprem(G,list2(0,1),Q,P);
		if(oequal(H,list2(0,list2(0,1)))) return(ineg(Q));
		/* putpgf2(1,G,H,list1(list1('x')),list1(list1('a'))); printf("\n"); */
	}	
	return(1);
}
