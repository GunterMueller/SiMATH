/*M
.SH NAME
pvpermut - polynomial variable permutation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pvpermut(r, P, PP)  
single r; 
pol P; 
list PP;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in the r variables X1, ...,Xr (say).
.TP 4
.B PP
is a list, consisting of the r integer numbers 
 1 ... r, representing a permutation, i.e.
.IP
PP = (pi(1) ...pi(r)), where
 1 <= pi(i) <= r; for 1 <= i <= r, and
 pi(i) != pi(j) ; for 1 <= i,j <= r; i != j.
.IP
For r = 0, PP is the empty list.
.PP
pvpermut returns the polynomial P1, that is the polynomial P with permuted variables, i.e.
.PP
P1 = P(Xpi(1), ...,Xpi(r)). 
 
M*/

/*H
	Version 1       23.11.1987      B. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE pvpermut      : 890501.941201
H*/

#include <_pol1.h>

pol pvpermut(r,P,PP)
single r;
pol P;
list PP;
{
	list E, ES;
	pol P1, P1S, P1SS, k;
	bind2(P,PP);
	init6(P1,P1S,P1SS,E,ES,k);

/* P,r ungleich 0 */

	if (P  &&  r) {
		P = ptodip(r,P);
		P1 = _0;
		while (P != _0) {
			k = lfirst(P);
			P = lred(P);
			E = lfirst(P);
			P = lred(P);
			E = lcinv(E);
			E = lpermut(E,PP);
			E = linv(E);
			if (P1 == _0) P1 = list2(k,E);
			else {
				P1S = lred(P1);
				ES = lfirst(P1S);
				if (lscomp(E,ES) > 0) P1 = lcomp2(k,E,P1);
				else {
					P1SS = P1S;
					P1S = lred(P1S);
					while (P1S != _0) {
						ES = lsecond(P1S);
						if (lscomp(E,ES) > 0) break;
						P1S = lred(P1S);
						P1SS = P1S;
						P1S = lred(P1S);
						}
					P1S = lcomp2(k,E,P1S);
					lsred(P1SS,P1S);
					}
				}
			}
		P1 = diptop(r,P1);
		}

/* P oder r gleich 0 */

	else P1 = P;

/* Ausgabe */

	return(P1);
}
