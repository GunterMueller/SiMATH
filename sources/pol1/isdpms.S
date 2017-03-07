/*M
.SH NAME
isdpms - is dense polynomial over modular singles ? (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdpms(r, m, P) 
obj r, m, P;

.SH DESCRIPTION
isdpms returns
.TP 4
1,
if P can be interpreted as a dense polynomial in r variables over Z/mZ,
 ( m, r integer numbers; 0 < m; 0 <= r; m,r < BASIS )
.TP 4
0, else.

 
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE isdpms        : 890501
H*/


#include <_pol1.h>

single isdpms(r,m,P)
obj r, m, P;
{
    single erg=0, e, k;

    if (isatom(r)  &&  r >= 0  &&  isatom(m)  &&  m > 0) {
	if (P == 0) erg = 1;
	else {
	    if (!r) erg = isms(m,P);
	    else {
		if (islist(P)) {
		    e = lfirst(P);
		    if (isatom(e)  &&  e >= 0  &&  llength(P) == e+2) {
			r--;
			P = lred(P);
			erg = 1;
			while (P != _0  &&  erg) {
			    k = lfirst(P);
			    P = lred(P);
			    if (r) erg = isdpms(r,m,k);
			    else erg = isms(m,k);
			    }
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
