/*M
.SH NAME
pvinsert - polynomial insertion of new variables, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pvinsert(r, P, k) 
single r, k; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B k
is an integer number, 0 <= k < BASIS.
.TP 4
.B P
is a polynomial in r variables, say X1, ..., Xr.
.PP
pvinsert returns the polynomial P as a polynomial in r+k variables Y1, ..., Yk, X1, ..., Xr.
  
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pvinsert      : 890501
H*/


#include <_pol1.h>

pol pvinsert(r,P,k)
single r;
pol P;
single k;
{
	single eP;
	pol P1, kP;
	bind(P);
	init2(P1,kP);

/* P oder k gleich 0 */

	if (P == 0  ||  k == 0) P1 = P;

/* r gleich 0 */

	else {
		if (r == 0) {
			P1 = P;
			for ( ; k; k--) P1 = list2(0,P1);
			}

/* allgemeiner Fall: r,k,P ungleich 0 */

		else {
			r--;
			P1 = _0;
			do {
				eP = lfirst(P);
				P = lred(P);
				kP = lfirst(P);
				P = lred(P);
				kP = pvinsert(r,kP,k);
				P1 = lcomp2(kP,eP,P1);
				}
			while (P != _0);
			P1 = linv(P1);
			}
		}

/* Ausgabe */

	return(P1);
}
