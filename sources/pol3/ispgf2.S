/*M
.SH NAME
ispgf2 - is polynomial over Galois-field with characteristic 2 ?
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single ispgfs(r, G, P)  
obj r, G, P;

.SH DESCRIPTION
ispgf2 returns 1 if:
.IP
G can be deemed to be an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb) of degree n (say), generating GF(2^n) (s. gf2algen).
.IP
P can be deemed to be a polynomial in r variables  ( < BASIS) over GF(2^n).
.PP
Else, ispgf2 returns 0.

.SH SEE ALSO
.nf
udpm2tosb
gf2algen

M*/
                    
/*H
	Version 1	23.06.94	S.Schmitt
   DATE ispgf2	      : 941201
H*/

#include <_pol3.h>

single ispgf2(r,G,P)
single r;
obj G, P;
{
    single erg=0, e, e1, k, c;
    bind(P,G);

    if (P == 0) erg = 1;
    else {
	if (r == 0) erg = isgf2el(G,P);
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
			if (islist(k)) k = ispgf2(r,G,k);
			else {erg = 0; break;}
		    }
		    else k = isgf2el(G,k);
		    if (k == 0) {erg = 0; break;}
		}
	    }
	}
    }

/* Ausgabe */

    return(erg);
}
