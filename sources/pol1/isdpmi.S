/*M
.SH NAME
isdpmi - is dense polynomial over modular integers ? (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdpmi(r, m, P)  
obj r, m, P;

.SH DESCRIPTION
isdpmi returns
.TP 4
1, 
if P can be interpreted as a dense polynomial in r variables over Z/mZ,
 ( m,r integer numbers, m > 0 , 0 <= r < BASIS )
.TP 4
0, else.

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE isdpmi        : 910915
H*/

#include <_pol1.h>

single isdpmi(r,m,P)
obj r, m, P;
{
    single erg=0, e, k;

    if (isatom(r)  &&  r >= 0  &&  isint(m)  &&  icomp(m,0) > 0 ) {
	if (P == 0) erg = 1;
	else {
	    if (!r) erg = ismi(m,P);
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
			    if (r) erg = isdpmi(r,m,k);
			    else erg = ismi(m,k);
			    }
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
