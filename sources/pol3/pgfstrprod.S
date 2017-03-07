/*M
.SH NAME
pgfstrprod - polynomial over Galois-field of single characteristic truncated product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfstrprod(r, p, AL, P1, P2, v, d)  
single r, p, v, d; 
list AL; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P1, P2
are polynomials in the r variables X1,...,Xr (say) over GF(p^n).
.TP 4
.B d
is an integer number, 1 <= d < BASIS.
.TP 4
.B v
is an integer number, 0 <= v <= r.
.PP
pgfstrprod returns a polynomial, say P3, where
.IP
P3 = P1 * P2 mod (X1,...,Xr-v)^d.   

.SH SEE ALSO
gfsalgen

M*/
               
/*H
	Version 1	15.03.95	Wolfgang Schwarz
   DATE pgfstrprod    : 951201 
H*/

#include <_pol3.h>

pol pgfstrprod(r,p,AL,P1,P2,v,d)
single r,p,v,d;
list AL;
pol P1, P2;
{
	single e1, e2, rs, vs, ds, dss;
	pol P1S, P3, P3S, k1, k2;
	bind(P1,P2,AL);
	init(P1S,P3,P3S,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P3 = gfsprod(p,AL,P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

	else {
		P1 = lcinv(P1);
		P2 = lcinv(P2);
		P3 = 0;
		rs = r-1;
		if (v) vs = v-1; else vs=0;
		do {
			k2 = lfirst(P2);
			P2 = lred(P2);
			e2 = lfirst(P2);
                        if (v) ds=d;
                        else {ds = d-e2; if (ds <= 0) break;}
                        P2 = lred(P2);
                        P1S = P1;
                        P3S = _0;
                        do {
                                k1 = lfirst(P1S);
                                P1S = lred(P1S);
                                e1 = lfirst(P1S);
                                if (v) dss=ds;
                                else {dss = ds-e1; if (dss <= 0) break;}
                                P1S = lred(P1S);
                                if (rs) k1 = pgfstrprod(rs,p,AL,k1,k2,vs,dss);
                                else k1 = gfsprod(p,AL,k1,k2);
                                if (k1) P3S = lcomp2(e1+e2,k1,P3S);
                                }
                        while (P1S != _0);
                        if (P3S == _0) P3S = 0;
                        P3 = pgfssum(r,p,AL,P3,P3S);
                        }
                while (P2 != _0);
                }

/* Ausgabe */

        return(P3);
}
