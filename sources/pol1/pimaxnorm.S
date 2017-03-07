/*M
.SH NAME
pimaxnorm - polynomial over integers maximum norm (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pimaxnorm(r, P) 
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
pimaxnorm returns the maximum norm of P, i.e. the maximum of the absolute values of the coefficients of P.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       03.08.1987      B. Weis
			Fehler beseitigt
   DATE pimaxnorm     : 890501
H*/


#include <_pol1.h>

int pimaxnorm(r,P)
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
				if (r) A1 = pimaxnorm(r,kP);
				else A1 = iabs(kP);
				A = imax(A,A1);
				}
			}
		}

/* Ausgabe */

	return(A);
}
