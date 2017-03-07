/*M
.SH NAME
ispmi - is polynomial over modular integer ? (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispmi(r, m, P) 
obj r, m, P;
 
.SH DESCRIPTION
ispmi returns
.TP 4
1,
if P can be interpreted as a polynomial in r variables over Z/mZ,
 ( m,r integer numbers, m > 0 , 0 <= r < BASIS )
.TP 4
0, else.

M*/

/*H
	Version 1       29.02.1988      M. Reichert
   DATE ispmi         : 890501
H*/


#include <_pol1.h>

single ispmi(r,m,P)
obj r, m, P;
{
    single erg=0, e, e1, k;
    bind(P);
    init( k );

    if (isatom(r)  &&  r >= 0  &&  isint(m)  &&  icomp(m,0) > 0) {
	if (P == 0) erg = 1;
	else {
	    if (r == 0) erg = ismi(m,P);
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
			    if (islist(k)) k = ispmi(r,m,k);
			    else {erg = 0; break;}
			    }
			else k = ismi(m,k);
			if (k == 0) {erg = 0; break;}
			}
		    }
		}
	    }
	}

/* Ausgabe */

    return(erg);
}
