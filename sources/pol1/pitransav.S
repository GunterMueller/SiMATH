/*M
.SH NAME
pitransav - polynomial over integers translation, all variables
(recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitransav(r, P, L) 
single r; 
pol P; 
list L;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P                                                                           
is a polynomial in r variables over the integer numbers.
.TP 4
.B L
.SM = ( Ar ... A2 A1 )     int A1, ..., Ar;
 is a list of r integer numbers.
.PP
pitransav returns the polynomial P1 in r variables over the integer numbers, where
.IP
P1(X1, X2, ...,Xr) = P(X1+A1, X2+A2, ..., Xr+Ar).

.SH SEE ALSO
pitrans

M*/

/*H
	Version 1       26.10.1987      B. Weis
   DATE pitransav     : 890501
H*/


#include <_pol1.h>

pol pitransav(r,P,LI)
single r;
pol P;
list LI;
{
	single e;
	int A;
	pol P1, P1S, k;
	bind2(P,LI);
	init3(P1,P1S,k);

/* Translation der Hauptvariablen */

	A = lfirst(LI);
	P1 = pitrans(r,P,A);
	LI = lred(LI);

/* Translation der Nebenvariablen */

	r--;
	if (r  &&  P1) {
		P1S = _0;
		while (P1 != _0) {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			k = pitransav(r,k,LI);
			P1S = lcomp2(k,e,P1S);
			}
		P1 = linv(P1S);
		}

/* Ausgabe */

	return(P1);
}
