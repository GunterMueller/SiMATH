/*M
.SH NAME
pgfsgcdcf - polynomial over Galois-field of single characteristic gcd and cofactors
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsgcdcf(r, p, AL, P1, P2, pQ1, pQ2)
single r, p; 
list AL; 
pol P1, P2, *pQ1, *pQ2;
       
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P1, P2
are polynomials in r variables over GF(p^n).
.TP 4
.B pQ1, pQ2
point on two polynomials.
.PP
pgfsgcdcf returns the greatest common divisor, say Q, of P1 and P2.
pgfsgcdcf writes two polynomials, say *pQ1, *pQ2 to pQ1 and pQ2 respectively, where
.IP
.nf
*pQ1 = P1/Q, *pQ2 = P2/Q, if Q != 0
*pQ1 = *pQ2 = 0, else.                     
                                           
.SH SEE ALSO
gfsalgen

M*/
                              
/*H
        Version 1       02.05.95       	Wolfgang Schwarz 
   DATE pgfsgcdcf     : 951201
H*/

#include <_pol3.h>

pol pgfsgcdcf(r,p,AL,P1,P2,pQ1,pQ2)
single r,p;
list AL;
pol P1, P2;
pol *pQ1, *pQ2;
{
    single sch=1, e1, e2, g, rs, t, d;
    gfel cs, dgf, muell;
    list U, U1, U2, US, U1S, U2S;
    pol P3, P1S, P2S, P3S, P1T, P2T, P3T;
    pol cP1, cP2, cP3;
    pol P1D, P2D, ppQ1, ppQ2, pQ1S, pQ2S, Q, P1SD, P2SD, P3SD;
    pol ad, bd, cd, at, bt, ct, h, qt, aq, bq, ctd;
    bind(AL,P1,P2);
    init(cs,dgf,muell,ppQ1,ppQ2,U,U1,U2,US,U1S,U2S);
    init(P3,P1S,P2S,P3S,P1T,P2T,P3T,cP1,cP2,cP3);
    init(P1D,P2D,pQ1S,pQ2S,Q,P1SD,P2SD,P3SD);
    init(ad,bd,cd,at,bt,ct,h,qt,aq,bq,ctd);

/* P1,P2 gleich 0 */

    if (!P1  &&  !P2) {
        P3 = 0;
        *pQ1 = 0;
        *pQ2 = 0;
    }

/* P1 gleich 0 */

    else if (!P1) {
        P3 = pgfsmonic(r,p,AL,P2);
        ppQ2 = plbc(r,P2);
        *pQ2 = pvinsert(0,plbc(r,P2),r);
        *pQ1 = 0;
    }

/* P2 gleich 0 */

    else if (!P2) {
        P3 = pgfsmonic(r,p,AL,P1);
        ppQ1 = plbc(r,P1);
        *pQ1 = pvinsert(0,plbc(r,P1),r);
        *pQ2 = 0;
    }

/* r gleich 1 */

    else if (r == 1) {
        P3 = upgfsgcd(p,AL,P1,P2);
        ppQ1 = pgfsquot(r,p,AL,P1,P3);
        *pQ2 = pgfsquot(r,p,AL,P2,P3);
        *pQ1 = ppQ1;
    }

/* allgemeiner Fall */

    else {

/* Berechnung des univariate-Inhalts und primitiven Anteils von P1 und P2 */

        cP1 = pgfsucont(r,p,AL,P1);
        P1D = pgfsupgfsq(r,p,AL,P1,cP1); 
        cP2 = pgfsucont(r,p,AL,P2);
        P2D = pgfsupgfsq(r,p,AL,P2,cP2);
        cP3 = upgfsgcd(p,AL,cP1,cP2);

/* Berechnung des Normalisierungsfaktors */

        rs = r-1;
        ad = plbc(rs,P1D);
        bd = plbc(rs,P2D);
        cd = upgfsgcd(p,AL,ad,bd);

/* Berechnung der Grade */

        U1 = pdegvec(rs,P1D);
        U2 = pdegvec(rs,P2D);
        e1 = pdegreesv(r,P1D,1);
        e2 = pdegreesv(r,P2D,1);
        g = pdegree(1,cd) + smax(e1,e2);

/* Initialisierung Element und Gradvektor */

        U = lred(U1);
        d = lfirst(U1)+1;
        U = lcomp(d,U);

/* Schleife */

        for ( d = 0; d<p; d++) {
	    dgf = itopi(1,d);
            cs = pgfseval(1,p,AL,cd,dgf);
            if (!cs) continue;
            P1S = pgfsevalsv(r,p,AL,P1D,1,dgf);
            U1S = pdegvec(rs,P1S);
            if (!oequal(U1,U1S)) continue;
            P2S = pgfsevalsv(r,p,AL,P2D,1,dgf);
            U2S = pdegvec(rs,P2S);
            if (!oequal(U2,U2S)) continue;
            if ((P3S = pgfsgcdcf(rs,p,AL,P1S,P2S,&P1SD,&P2SD)) == ERROR) {d = p; break;}
            if (ispconst(rs,P3S,&muell)) {
                P3 = pvinsert(0,cP3,rs);
                ppQ1 = pgfsupgfsq(r,p,AL,P1,cP3);
                *pQ2 = pgfsupgfsq(r,p,AL,P2,cP3);
                *pQ1 = ppQ1;
                sch = 0;
                break;
            }
            US = pdegvec(rs,P3S);
            t = lscomps(U,US);
            if (t >= 2) {
                Q = list2(0,list2(0,1));
                P1T = 0;
                P2T = 0;
                P3T = 0;
                U = lsmins(U,US);
            }
            if (t == 1  ||  t == 3  ||  (!t  &&  pdegree(1,Q) > g)) continue;
            P3SD = pgfsgfsprod(rs,p,AL,P3S,cs);
            qt = pgfseval(1,p,AL,Q,dgf);
            qt = gfsinv(p,AL,qt);
            P3T = pgfsinter(r,p,AL,Q,P3T,P3SD,dgf,qt);
            P1T = pgfsinter(r,p,AL,Q,P1T,P1SD,dgf,qt);
            P2T = pgfsinter(r,p,AL,Q,P2T,P2SD,dgf,qt);
            h = gfsneg(p,AL,dgf);
            if (h) h = list4(1,list2(0,1),0,h); else h=list2(1,list2(0,1));
            Q = pgfsprod(1,p,AL,Q,h);
            if (pdegree(1,Q) <= g) continue;
            ct = pdegreesv(r,P3T,1);
            at = pdegreesv(r,P1T,1);
            bt = pdegreesv(r,P2T,1);
            ct += smax(at,bt);
            if (pdegree(1,Q) > ct) break;
        }
        if (d == p) {P3 = ERROR; *pQ1 = 0; *pQ2 = 0;}
        else if (sch) {
            ct = pgfsucont(r,p,AL,P3T);
            P3 = pgfsupgfsq(r,p,AL,P3T,ct);
            ctd = pgfsquot(1,p,AL,cd,ct);
            ppQ1 = pgfsupgfsq(r,p,AL,P1T,ctd);
            ppQ2 = pgfsupgfsq(r,p,AL,P2T,ctd);
            P3 = pgfsupgfsp(r,p,AL,P3,cP3);
            aq = pgfsquot(1,p,AL,cP1,cP3);
            ppQ1 = pgfsupgfsp(r,p,AL,ppQ1,aq);
            bq = pgfsquot(1,p,AL,cP2,cP3);
            *pQ2 = pgfsupgfsp(r,p,AL,ppQ2,bq);
            *pQ1 = ppQ1;
        }
    }

/* Ausgabe */

    return(P3);
}
