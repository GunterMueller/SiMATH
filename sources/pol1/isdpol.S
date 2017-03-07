/*M
.SH NAME
isdpol - is dense polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdpol(r, P) 
obj r, P;

.SH DESCRIPTION
isdpol returns
.TP 4
1,
if P can be interpreted as a dense polynomial in r    (0 <= r < BASIS) variables,
.TP 4
0,
else.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE isdpol        : 890501
H*/


#include <_pol1.h>

single isdpol(r,P)
obj r, P;
{
    single erg=0, e, k;

    if (isatom(r)  &&  r >= 0) {
	if (P == 0) erg = 1;
	else {
	    if (!r) erg = 1;
	    else {
		if (islist(P)) {
		    e = lfirst(P);
		    if (isatom(e)  &&  e >= 0  &&  llength(P) == e+2) {
			r--;
			P = lred(P);
			erg = 1;
			if (r) {
			    while (P != _0  &&  erg) {
				k = lfirst(P);
				P = lred(P);
				erg = isdpol(r,k);
				}
			    }
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
