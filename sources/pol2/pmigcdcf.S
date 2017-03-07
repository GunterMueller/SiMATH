/*M
.SH NAME
pmigcdcf - polynomial over modular integers greatest common divisor and cofactors, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmigcdcf(r, p, P1, P2, pQ1, pQ2)  
single r; 
int p; 
pol P1, P2, *pQ1, *pQ2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number.       
.TP 4
.B P1, P2
are polynomials in r variables over Z/pZ
.PP
pmigcdcf returns the greatest common divisor, say P3, of P1 and P2. Beyond that pmigcdcf computes the polynomials Q1 and Q2, whereat
.IP
 Q1 = P1/P3, Q2 = P2/P3,    for P3 != 0,
 Q1 = Q2 = 0,               else.
.PP                                                   
pmigcdcf writes Q1, Q2 to *pQ1, *pQ2 respectively. 
If pmigcdcf is not able to compute the g.c.d. of P1 and P2, it returns ERROR, and pQ1 resp. pQ2 are 0.
      
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE pmigcdcf      : 910915
H*/

#include <_pol2.h>

pol pmigcdcf(r,m,P1,P2,pQ1,pQ2)
single r;
int m;
pol P1, P2;
pol *pQ1, *pQ2;
{
    single sch=1, e1, e2, g, rs, t;
    int cs, d; 
    list U, U1, U2, US, U1S, U2S;
    pol P3, P1S, P2S, P3S, P1T, P2T, P3T;
    pol cP1, cP2, cP3;
    pol P1D, P2D, ppQ1, ppQ2, pQ1S, pQ2S, Q, P1SD, P2SD, P3SD;
    pol ad, bd, cd, at, bt, ct, h, qt, aq, bq, ctd;
    bind(m,P1,P2);
    init(cs,d,ppQ1,ppQ2,U,U1,U2,US,U1S,U2S);
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
	P3 = pmimonic(r,m,P2);
	ppQ2 = plbc(r,P2);
	*pQ2 = pvinsert(0,plbc(r,P2),r);
	*pQ1 = 0;
    }

/* P2 gleich 0 */

    else if (!P2) {
	P3 = pmimonic(r,m,P1);
	ppQ1 = plbc(r,P1);
	*pQ1 = pvinsert(0,plbc(r,P1),r);
	*pQ2 = 0;
    }

/* r gleich 1 */

    else if (r == 1) {
	P3 = upmigcd(m,P1,P2);
	ppQ1 = pmiquot(r,m,P1,P3);
	*pQ2 = pmiquot(r,m,P2,P3);
	*pQ1 = ppQ1;
    }

/* allgemeiner Fall */

    else {

/* Berechnung des univariate-Inhalts und primitiven Anteils von P1 und P2 */

	cP1 = pmiucont(r,m,P1);
	P1D = pmiupmiquot(r,m,P1,cP1);
	cP2 = pmiucont(r,m,P2);
	P2D = pmiupmiquot(r,m,P2,cP2);
	cP3 = upmigcd(m,cP1,cP2);

/* Berechnung des Normalisierungsfaktors */

	rs = r-1;
	ad = plbc(rs,P1D);
	bd = plbc(rs,P2D);
	cd = upmigcd(m,ad,bd);

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

	for ( d = 0; icomp(d,m) < 0; d= isum(d,1) ) {
	    cs = pmieval(1,m,cd,d);
	    if (!cs) continue;
	    P1S = pmievalsv(r,m,P1D,1,d);
	    U1S = pdegvec(rs,P1S);
	    if (!oequal(U1,U1S)) continue;
	    P2S = pmievalsv(r,m,P2D,1,d);
	    U2S = pdegvec(rs,P2S);
	    if (!oequal(U2,U2S)) continue;
	    if ((P3S = pmigcdcf(rs,m,P1S,P2S,&P1SD,&P2SD)) == ERROR) {d = m; break;}
	    if (ispione(rs,P3S)) {
		P3 = pvinsert(0,cP3,rs);
		ppQ1 = pmiupmiquot(r,m,P1,cP3);
		*pQ2 = pmiupmiquot(r,m,P2,cP3);
		*pQ1 = ppQ1;
		sch = 0;
		break;
	    }
	    US = pdegvec(rs,P3S);
	    t = lscomps(U,US);
	    if (t >= 2) {
		Q = list2(0,1);
		P1T = 0;
		P2T = 0;
		P3T = 0;
		U = lsmins(U,US);
	    }
	    if (t == 1  ||  t == 3  ||  (!t  &&  pdegree(1,Q) > g)) continue;
	    P3SD = pmimiprod(rs,m,P3S,cs);
	    qt = pmieval(1,m,Q,d);
	    qt = miinv(m,qt);
	    P3T = pmiinter(r,m,Q,P3T,P3SD,d,qt);
	    P1T = pmiinter(r,m,Q,P1T,P1SD,d,qt);
	    P2T = pmiinter(r,m,Q,P2T,P2SD,d,qt);
	    h = mineg(m,d);
	    h = list4(1,1,0,h);
	    Q = pmiprod(1,m,Q,h);
	    if (pdegree(1,Q) <= g) continue;
	    ct = pdegreesv(r,P3T,1);
	    at = pdegreesv(r,P1T,1);
	    bt = pdegreesv(r,P2T,1);
	    ct += smax(at,bt);
	    if (pdegree(1,Q) > ct) break;
	}
	if (d == m) {P3 = ERROR; *pQ1 = 0; *pQ2 = 0;}
	else if (sch) {
	    ct = pmiucont(r,m,P3T);
	    P3 = pmiupmiquot(r,m,P3T,ct);
	    ctd = pmiquot(1,m,cd,ct);
	    ppQ1 = pmiupmiquot(r,m,P1T,ctd);
	    ppQ2 = pmiupmiquot(r,m,P2T,ctd);
	    P3 = pmiupmiprod(r,m,P3,cP3);
	    aq = pmiquot(1,m,cP1,cP3);
	    ppQ1 = pmiupmiprod(r,m,ppQ1,aq);
	    bq = pmiquot(1,m,cP2,cP3);
	    *pQ2 = pmiupmiprod(r,m,ppQ2,bq);
	    *pQ1 = ppQ1;
	}
    }

/* Ausgabe */

    return(P3);
}
