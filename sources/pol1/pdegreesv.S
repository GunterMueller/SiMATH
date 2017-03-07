/*M
.SH NAME
pdegreesv - polynomial degree, specified variable, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single pdegreesv (r, P, n) 
single r, n; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B n
is an integer number, 0 < n <= r.
.TP 4
.B P 
is a polynomial in r variables.
.PP
pdegreesv returns the degree of the polynomial P with regard to the n-th variable.
For P = 0, pdegreesv returns 0.

.SH SEE ALSO
pdegree

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pdegreesv     : 890501
H*/


#include <_pol1.h>

single pdegreesv(r,P,n)
single r;
pol P;
single n;
{
	single a=0, as;
	pol kP;

/* P ungleich 0 */

	if (P) {

/* n gleich r */

		if (n == r) a = lfirst(P);

/* n ungleich r */

		else {
			r--;
			while (P != _0) {
				P = lred(P);
				kP = lfirst(P);
				P = lred(P);
				as = pdegreesv(r,kP,n);
				a = smax(a,as);
				}
			}
		}

/* Ausgabe */

	return(a);
}
