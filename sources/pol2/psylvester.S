/*M
.SH NAME
psylvester - polynomial Sylvester matrix

.SH SYNOPSIS
.nf
#include<_pol2.h>

matrix psylvester(r, P1, P2) 
single r; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.    
.TP 4
.B P1, P2
are polynomials in r variables of positive degree.
.PP
psylvester returns the Sylvester matrix of P1 and P2.
  
M*/

/*H
	Version 1       30.09.1987      B. Weis
	Version 2       05.01.1988      B. Weis
			Typ matrix eingefuehrt
   DATE psylvester    : 890501
H*/


#include <_pol2.h>

matrix psylvester(r,P1,P2)
single r;
pol P1, P2;
{
	single e1, e2, i, j;
	pol P;
	matrix M;
	bind2(P1,P2);
	init2(M,P);

/* Initialisierungen */

	e1 = lfirst(P1);
	e2 = lfirst(P2);
	M = _0;

/* Erstelle M */

	for (i = e2; i; i--) {
		P = ppmvprod(r,P1,i-1);
		P = ptodp(1,P);
		P = lred(P);
		for (j = e2; j > i; j--) P = lcomp(0,P);
		M = lcomp(P,M);
		}
	for (i = e1; i; i--) {
		P = ppmvprod(r,P2,i-1);
		P = ptodp(1,P);
		P = lred(P);
		for (j = e1; j > i; j--) P = lcomp(0,P);
		M = lcomp(P,M);
		}
	M = linv(M);

/* Ausgabe */

	return(M);
}
