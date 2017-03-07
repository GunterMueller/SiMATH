/*M
.SH NAME
pisumnorm - polynomial over integers sum norm (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pisumnorm(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pisumnorm returns the sum norm of P, i.e. the sum of the absolute values of the base coefficients.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       03.08.1987      B. Weis
			Fehler verbessert
   DATE pisumnorm     : 890501
H*/


#include <_pol1.h>

int pisumnorm(r,P)
single r;
pol P;
{
	int A, A1;
	pol kP;
	bind(P);
	init3(A,A1,kP);

/* r gleich 0 */

	if (!r) A = iabs(P);

/* r ungleich 0 */

	else {
		A = 0;
		if (P) {
			r--;
			while (P != _0) {
				P = lred(P);
				kP = lfirst(P);
				P = lred(P);
				if (r) A1 = pisumnorm(r,kP);
				else A1 = iabs(kP);
				A = isum(A,A1);
				}
			}
		}

/* Ausgabe */

	return(A);
}
