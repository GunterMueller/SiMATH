/*M
.SH NAME
pmimidqhl - polynomial over modular integers, modular ideal, Hensel lemma quadratic step

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmimidqhl(r, p, S, P1, P2, F1, F2, M, SL, H, pB) 
single r, p;
int M;
list S, SL;
pol P1, P2, F1, F2, H, *pB;

.SH DESCRIPTION
TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B S
= (s1,...,s(r-1)) is a list, consisting of positive singles.  
.TP 4
.B SL
= (sl1,...,sl(r-1)) is a list, consisting of positive singles.
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
Let IL be the Ideal spanned by (X1^sl1,...,X(r-1)^sl(r-1)), then  
pmimidqhl computes the polynomials A and B of Z/M*Z[X1,...,X(r-1),Y] / IL, A monic, so that     
.IP
 A is congruent to P1,
 B is congruent to P2,
 A * B is congruent to H and
 deg(A) = deg(P1) with regard to Y.
.PP
pmimidqhl returns A and writes B to *pB.
                                                     
M*/
      
/*H
	Version 1       02.03.1989      A.Stein
	Version 1.2     13.09.1990      ueberfl. Testausgaben rausgeworfen. AS
   DATE pmimidqhl     : 891101.9003__.901120
H*/


#include <_pol2.h>

pol pmimidqhl(r,p,S,P1,P2,F1,F2,M,SL,H,pB)
single r,p;
int M;
list S,SL;
pol P1,P2,F1,F2,H,*pB;
{
	single i,l;
	list S1,L;
	pol PA,Ha;
	bind(M,S,SL,P1,P2,F1,F2,H);
	init(PA,S1,L,Ha);

/* Initialisierungen */

	S = lcopy(S);
	S1 = lcinv(SL);
	Ha = pitopms(r,H,p);

/* Hensel-Lemma in einer Variablen: Liften in Xi */

	for(i=r-1;i>0;i--,S1=lred(S1)) {
		l = lfirst(S1);
		L = pmimidqhls(r,p,S,P1,P2,F1,F2,i,l,Ha);
		P1 = lfirst(L);
		P2 = lsecond(L);
		F1 = lthird(L);
		F2 = lfourth(L);
	}

/* Liften in M */

	PA = pimidqhl(r,p,SL,P1,P2,F1,F2,M,H,&Ha);
	*pB = Ha;

/* Ausgabe */

	return(PA);

}
