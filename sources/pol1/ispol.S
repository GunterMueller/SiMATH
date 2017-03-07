/*M
.SH NAME
ispol - is polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispol(r, P) 
obj r, P;

.SH DESCRIPTION
ispol returns
.TP 4
1,
if P can be interpreted as a polynomial in r            (0 <= r < BASIS) variables,
.TP 4
0,
else.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE ispol         : 890501
H*/


#include <_pol1.h>

single ispol(r,P)
obj r, P;
{
    single erg=0, e, e1, k;
    bind(P);

    if (isatom(r)  &&  r >= 0) {
	if (P == 0) erg = 1;
	else {
	    if (r == 0) erg = 1;
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
			    if (islist(k)) erg = ispol(r,k);
			    else erg = 0;
			    }
			if (erg == 0) break;
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
