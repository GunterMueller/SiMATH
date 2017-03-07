/*M
.SH NAME
pigcdcf - polynomial over integers greatest common divisor and cofactors

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pigcdcf(r, P1, P2, pQ1, pQ2) 
single r; 
pol P1, P2, *pQ1, *pQ2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are polynomials in r variables over the integer numbers.
.PP
pigcdcf returns the greatest common divisor, say P3, of P1 and P2. Beyond that pigcdfc computes the polynomials Q1 and Q2, whereat
.IP
 Q1 = P1/P3, Q2 = P2/P3,    for P3 != 0,
 Q1 = Q2 = 0,               else.
.PP
pigcdcf writes Q1, Q2 to *pQ1, *pQ2 respectively.
  
M*/

/*H
	Version 1       04.06.1987      B. Weis
	Version 2       08.10.1987      B. Weis
			umfangreiche Aenderungen
	Version 3       26.11.1987      B. Weis
			im 3. Sonderfall Zuweisung an *pQ1 nach
			Zuweisung an *pQ2
	Version 4       08.12.1987      B. Weis
			veccomp -> lscomps, vecmin -> lsmins 
	Version 5	08.03.1989	Klaus Petry
			aus BSD wurde BsD wegen Apollo BSD4.3   
   DATE pigcdcf       :.890501
H*/


#include <_pol2.h>

pol pigcdcf(r,P1,P2,pQ1,pQ2)
single r;
pol P1, P2;
pol *pQ1, *pQ2;
{
    single sch=0, ass, bss, cs, p, q, qss, t, w, *Pl;
    int a, b, c, css, ad, bd, cd, d, e, f, g, dq, eq, fq, gq;
    int aq, bq, csd, gd, Q;
    list U, V, W, US, VS, WS, WSS;
    pol P3, AD, BD, AS, BS, CS, AQ, BQ, ASD, BsD, CSD;
    pol ASS, BSS, CSS;
    bind2(P1,P2);
    init6(a,b,c,ad,bd,cd);  init5(css,d,e,f,g); init4(dq,eq,fq,gq);
    init5(aq,bq,csd,gd,Q);
    init6(U,V,W,US,VS,WS);
    init6(P3,AD,BD,AS,BS,CS); init5(AQ,BQ,ASD,BsD,CSD);
    init3(ASS,BSS,CSS);

/* P1 und P2 gleich 0 */

    if (!P1  &&  !P2) {P3 = 0; *pQ1 = 0; *pQ2 = 0;}

/* r gleich 0 */

    else if (!r) P3 = igcdcf(P1,P2,pQ1,pQ2);

/* P1 gleich 0 oder P2 gleich 0 */

    else if (!P1) {P3 = piabs(r,P2); *pQ2 = pvinsert(0,pisign(r,P2),r); *pQ1 = 0;}
    else if (!P2) {P3 = piabs(r,P1); *pQ1 = pvinsert(0,pisign(r,P1),r); *pQ2 = 0;}

/* allgemeiner Fall */

    else {

/* Berechnung des Inhaltes und des primitiven Anteils von P1 und P2 */

	a = piicont(r,P1);
	AD = piiquot(r,P1,a);
	b = piicont(r,P2);
	BD = piiquot(r,P2,b);
	c = igcd(a,b);

/* Berechnung der Normierungsfaktoren */

	ad = plbc(r,AD);
	bd = plbc(r,BD);
	cd = igcd(ad,bd);

/* Berechnung der Normen */

	d = pimaxnorm(r,AD);
	e = pimaxnorm(r,BD);
	f = imax(d,e);
	g = ip2prod(cd,1);
	g = iprod(g,f);

/* Berechnung der Gradvektoren */

	U = pdegvec(r,AD);
	V = pdegvec(r,BD);

/* Berechnung einer Schranke fuer die Faktor-Koeffizienten */

	dq = ip2prod(d,pifcb(U));
	eq = ip2prod(e,pifcb(V));
	fq = imax(dq,eq);
	gq = ip2prod(c,3);
	gq = iprod(gq,fq);

/* Initialisierung fuer Schleife */

	Pl = LIST_GSP;
	W = lcomp(lfirst(U)+1,lred(U));

/* Schleife */

	q = 0;
	css = 0;
	while (q < css+2) {
	    if (*Pl) p = *Pl, Pl++;
	    else {
		p -= 2;
		while (issprime(p,&q) != 1) p -= 2;
		}
	    cs = mshom(p,cd);
	    if (!cs) continue;
	    AS = pitopms(r,AD,p);
	    US = pdegvec(r,AS);
	    if (!oequal(U,US)) continue;
	    BS = pitopms(r,BD,p);
	    VS = pdegvec(r,BS);
	    if (!oequal(V,VS)) continue;
	    if ((CS = pmsgcdcf(r,p,AS,BS,&ASD,&BsD)) == -BASIS-1) continue;
	    if (ispione(r,CS)) {
		P3 = pvinsert(0,c,r);
		AQ = piiquot(r,P1,c);
		BQ = piiquot(r,P2,c);
		*pQ1 = AQ;
		*pQ2 = BQ;
		sch = 1;
		break;
		}

/* Initialisierung fuer C.R.A. */

	    WS = pdegvec(r,CS);
	    t = lscomps(W,WS);
	    if (t >= 2) {
		Q = 1;
		ASS = 0;
		BSS = 0;
		CSS = 0;
		W = lsmins(W,WS);
		WSS = W;
		gd = gq;
		do {
		    w = lfirst(WSS);
		    WSS = lred(WSS);
		    gd = iprod(gd,w+1);
		    }
		while (WSS != _0);
		}

/* unguenstige Primzahl */

	    if (t == 1  ||  t == 3  ||  t == 0  &&  icomp(Q,gd) > 0) continue;

/* C.R.A. */

	    CSD = pmsmsprod(r,p,CS,cs);
	    qss = msinv(p,mshom(p,Q));
	    CSS = picra(r,CSS,CSD,Q,p,qss);
	    ASS = picra(r,ASS,ASD,Q,p,qss);
	    BSS = picra(r,BSS,BsD,Q,p,qss);
	    Q = iprod(Q,p);

/* Test auf Vollstaendigkeit */

	    if (icomp(Q,g) <= 0) continue;
	    q = ilog2(Q);
	    css = ilog2(pisumnorm(r,CSS));
	    ass = ilog2(pimaxnorm(r,ASS));
	    bss = ilog2(pimaxnorm(r,BSS));
	    css += smax(ass,bss);
	    }

/* Ruecksetzen der Normierung */

	if (!sch) {
	    css = piicont(r,CSS);
	    P3 = piiquot(r,CSS,css);
	    csd = iquot(cd,css);
	    AQ = piiquot(r,ASS,csd);
	    BQ = piiquot(r,BSS,csd);
	    P3 = piiprod(r,P3,c);
	    aq = iquot(a,c);
	    AQ = piiprod(r,AQ,aq);
	    bq = iquot(b,c);
	    *pQ2 = piiprod(r,BQ,bq);
	    *pQ1 = AQ;
	    }
	}

/* Ausgabe */

    return(P3);
}
