/*M
.SH NAME
ispr - is polynomial over rationals ? (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispr(r, P) 
obj r, P;

.SH DESCRIPTION
ispr returns
.TP 4
1,
if P can be interpreted as a polynomial in r variables over the rational numbers,
 ( 0 <= r < BASIS )
.TP 4
0,
else.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE ispr          : 890501
H*/


#include <_pol1.h>

single ispr(r,P)
obj r, P;
{
    single erg=0, e, e1, k;
    bind(P);

    if (isatom(r)  &&  r >= 0) {
	if (P == 0) erg = 1;
	else {
	    if (r == 0) erg = israt(P);
	    else {
		if (islist(P)  &&  seven(llength(P))  &&  P != _0) {
		    r--;
		    e1 = BASIS;
		    erg = 1;
		    while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (e1 <= e  ||  e < 0) {erg = 0; break;}
			e1 = e;
			if (k == 0) {erg = 0; break;}
			if (r) {
			    if (islist(k)) k = ispr(r,k);
			    else {erg = 0; break;}
			    }
			else k = israt(k);
			if (k == 0) {erg = 0; break;}
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
