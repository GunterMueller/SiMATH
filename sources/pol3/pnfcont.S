/*M
.SH NAME
pnfcont - polynomial over number field content

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfcont(r, F, D, P) 
single r; 
int D; 
pol F, P;

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
pnfcont returns a monic polynomial in r-1 variables, which is the content of P with regard to the main variable. 

.SH SEE ALSO
ouspidenic

M*/
  
/*H
	Version 1	02.03.95	Wolfgang Schwarz 
   DATE pnfcont       : 951201
H*/

#include <_pol3.h>

pol pnfcont(r,F,D,P)
single r;
int D;
pol F,P;
{
	pol P1, P1S,muell;
	nfel pC;
	bind(F,D,P);
	init(P1,P1S,muell);
	P1 = 0;

/* P ungleich 0 */

	if (P) {
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		r--;
		if (!r) return(1);  
		while (P != _0) {
			P = lred(P);
			P1S = lfirst(P);
			P = lred(P);
			P1 = pnfgcdcf(r,F,D,P1,P1S,&muell,&muell);
			if (ispconst(r,P1,&muell)) break;
			}
		}

/* Ausgabe */

	return(P1);
}
