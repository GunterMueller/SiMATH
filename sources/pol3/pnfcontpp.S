/*M
.SH NAME
pnfcontpp - polynomial over number field content and primitive part

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfcontpp(r, F, D, P, pPP) 
single r; 
int D; 
pol F, P, *pPP;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B F
is a monic polynomial in dense representation.
.PP
Let t denote a zero of F, then t generates a number field, say K.
.TP 4
.B D
is a natural number, such that the ring of integers of K is in 1/D * Z[t] (s. ouspidenic).
.TP 4
.B P
is a polynomial in r variables over K.
.PP
pnfcontpp returns a monic polynomial in r-1 variables, which is the content of P with regard to the main variable, and writes the primtive part of P to *pPP.

.SH SEE ALSO
ouspidenic
                 
M*/

/*H
	Version 1	02.03.95	Wolfgang Schwarz
   DATE pnfcontpp     : 951201
H*/

#include <_pol3.h>

pol pnfcontpp(r,F,D,P,pPP)
single r;
int D;
pol F,P;
pol *pPP;
{
	single e;
	nfel C;
	pol P1, ppPP, k;
	bind(F,D,P);
	init(P1,ppPP,k,C);

/* P ungleich 0 */

	if (P) {
		P1 = pnfcont(r,F,D,P);
		r--;
		if (ispconst(r,P1,&C)) *pPP = P;
		else {
			ppPP = _0;
			while (P != _0) {
				e = lfirst(P);
				P = lred(P);
				k = lfirst(P);
				P = lred(P);
				k = pnfquot(r,F,k,P1);
				ppPP = lcomp2(k,e,ppPP);
				}
			*pPP = linv(ppPP);
			}
		}

/* P gleich 0 */

	else {P1 = 0; *pPP = 0;}

/* Ausgabe */

	return(P1);
}
