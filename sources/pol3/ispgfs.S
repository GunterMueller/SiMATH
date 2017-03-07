/*M
.SH NAME
ispgfs - is polynomial over Galois-field with single characteristic ?
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single ispgfs(r, p, AL, P)  
obj r, p, AL, P;
 
.SH DESCRIPTION
ispgfs returns 1, if: 
.IP
r can be deemed to be an integer number,              0 <= r < BASIS.
.IP
p can be deemed to be a prime number.
.IP
AL = (G,AL1) can be deemed to be an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen), and
.IP
P can be deemed to be a polynomial in r variables over GF(p^n).
.PP
Else, ispgfs returns 0.

.SH SEE ALSO
gfsalgen

M*/
     
/*H
	Version 1         23.03.88           J.Schmitt
   DATE ispgfs        : 890501.9203__
H*/


#include <_pol3.h>

single ispgfs(r,p,AL,P)
single r,p;
list AL;
obj P;
{
    single erg=0, e, e1, k, c;
    bind(P,AL);

    if (P == 0) erg = 1;
    else {
	if (r == 0) erg = isgfsel(p,AL,P);
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
			if (islist(k)) k = ispgfs(r,p,AL,k);
			else {erg = 0; break;}
		    }
		    else k = isgfsel(p,AL,k);
		    if (k == 0) {erg = 0; break;}
		}
	    }
	}
    }

/* Ausgabe */

    return(erg);
}
