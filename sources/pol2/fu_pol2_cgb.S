/* DOC_SKIP */

/***********************************************************************

	Funktionen in 'pol2 zur Berechnung von
	parametrischen Groebnerbasen

	enthaelt:  1.) cgbadcon
		   2.) cgbadptcgb
		   3.) cgbainb
		   4.) cgbcc
		   5.) cgbccop
		   6.) cgbcdop
		   7.) cgbcdopl
		   8.) cgbcoldif
		   9.) cgbcolmul
		  10.) cgbcolprod
		  11.) cgbdiplm
		  12.) cgbdiplpm
		  13.) cgbdp		<-- 2. Vers. ab Vers. 3.9
		  14.) cgbelocp
                  15.) cgbfcb 		<-- neu ab Vers. 3.8
		  16.) cgbfco
		  17.) cgbfbc
		  18.) cgbfm
		  19.) cgbfpol		<-- 2. Vers. ab Vers. 3.9
		  20.) cgbfwf
		  21.) cgbglepr
		  22.) cgbgpwogm
		  23.) cgbhtt
		  24.) cgbiconsgb      	<-- over integers
		  25.) cgbidlop	       	<-- over integers
		  26.) cgbigbsnup      	<-- over integers
		  27.) cgbigbsup       	<-- over integers
		  28.) cgbigbsys       	<-- over integers
		  29.) cgbiglobred     	<-- over integers
		  30.) cgbigsred       	<-- over integers
		  31.) cgbiibcfac      	<-- over integers
		  32.) cgbiic	       	<-- over integers
		  33.) cgbimkn1	       	<-- over integers
		  34.) cgbimnco	       	<-- over integers
		  35.) cgbinorbtop     	<-- over integers
		  36.) cgbipadif       	<-- over integers
		  37.) cgbipanor       	<-- over integers
		  38.) cgbipared       	<-- over integers
		  39.) cgbipaspol      	<-- over integers
		  40.) cgbired	       	<-- over integers
		  41.) cgbirednor      	<-- over integers
		  42.) cgbivnorf       	<-- over integers
		  43.) cgbiwrclp       	<-- over integers
                                       	<-- 2.Vers. ab Vers. 3.8
		  44.) cgbiwrclpwogm   	<-- over integers
                                       	<-- 2.Vers. ab Vers. 3.8
		  45.) cgbiwrcol       	<-- over integers
		  46.) cgbiwrcond      	<-- over integers
		  47.) cgbkco
		  48.) cgbmco
		  49.) cgbminpl
		  50.) cgbmkcgb
		  51.) cgbmkn0
		  52.) cgbmknp
		  53.) cgbmkpair
		  54.) cgbmpwogm
		  55.) cgbpairscp
		  56.) cgbredfpol
		  57.) cgbremgt
		  58.) cgbrep
		  59.) cgbrts
		  60.) cgbscol
		  61.) cgbscon
		  62.) cgbtht
		  63.) cgbucd
		  64.) cgbuppol
		  65.) cgbvcap
		  66.) cgbwpu
		  67.) cgbws
		  68.) cgbwtm

***********************************************************************/



/*  1.) cgbadcon */
/*c
		    cgbadcon( r1, r2, ALIST, GAMMA, GNEU, b, pDEL, pDNEU )

	"comprehensive Groebner basis, add to condition" (rekursiv)
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbadcon(r1,r2,ALIST,GAMMA,GNEU,b,pDEL,pDNEU)  single r1,r2;
	     list ALIST,GAMMA,GNEU; single b; list *pDEL,*pDNEU;
	cgbadcon(r1,r2,ALIST,GAMMA,GNEU,b,pDEL,pDNEU)
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ALIST ist eine Liste von Koeffizienten;
	      - GAMMA ist eine Bedingung, wobei gilt:
		entweder GAMMA = {} oder GAMMA enthaelt zwei Listen, in
		denen die Koeffizienten enthalten sind, die gleich Null
		und ungleich Null sind;
	      - GNEU ist eine Bedingung (siehe GAMMA);
	      - b = 0  oder  b = 1;
	pDEL ist dann eine Fallunterscheidung, die GAMMA abdeckt und die
	Elemente von ALIST in jeder Bedingung enthaelt.
	pDNEU ist eine Huelle um GNEU und enthaelt die Elemente von ALIST
	in jeder Bedingung.
	Ist b = 1, so wurde jedes Element von ALIST ueberprueft.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbadcon      : 930531.9311__
H*/

#include <_pol2.h>

cgbadcon(r1,r2,ALIST,GAMMA,GNEU,b,pDEL,pDNEU)
single r1,r2;
list   ALIST,GAMMA,GNEU;
single b;
list   *pDEL,*pDNEU;
{
  single s;
  list	 A,COEF,D0,D0P,D1,D1P,G0,G0P,G1,G1P,J1Y,QALIST,X;
  list	 DELTA0,DELTA1;
  list	 DNEU0,DNEU1;
  list	 GAMMA0,GAMMA1;
  list	 GNEU0,GNEU1;

  bind(ALIST,GAMMA,GNEU);
  init(A,COEF,D0,D0P,D1,D1P,G0,G0P,G1,G1P,J1Y,QALIST,X);
  init(DELTA0,DELTA1);
  init(DNEU0,DNEU1);
  init(GAMMA0,GAMMA1);
  init(GNEU0,GNEU1);
/*
 * Koeffizient der Koeffizientenliste ALIST entnehmen - Anfang
 */
  QALIST = ALIST;
  s	 = 0;
  A	 = ALIST;
  COEF	 = lfirst(A);
  A	 = lred(A);
/*
 * Koeffizient der Koeffizientenliste ALIST entnehmen - Ende
 * Ueberpruefen, ob GAMMA den Koeffizienten enthaelt - Anfang
 */
  if ( GAMMA != _0 && b == 1 ) {
     GAMMA0 = lfirst(GAMMA);
     GAMMA1 = lsecond(GAMMA);
     s	    = lmemb(COEF,GAMMA0);
     if ( s == 0 )  s = lmemb(COEF,GAMMA1);
     if ( s == 1 ) {
	if ( A == _0 ) {
	   *pDEL = list1(GAMMA);
	   if ( GNEU != _0 )  *pDNEU = list1(GNEU);
	   return;
	}
	else {
	     D0 = GAMMA;
	     G0 = GNEU;
	}
     }
  }
/*
 * Ueberpruefen, ob GAMMA den Koeffizienten enthaelt - Ende
 * Initialisiere Bedingung - Anfang
 */
  if ( GAMMA == _0 && s == 0 ) {
     J1Y = list1(COEF);
     D0	 = list2(J1Y,_0);
     J1Y = list1(COEF);
     D1	 = list2(_0,J1Y);
     G0	 = D0;
     G1	 = D1;
  }
/*
 * Initialisiere Bedingung - Ende
 * Verfeinere Bedingung - Anfang
 */
  if ( GNEU == _0 )  GNEU = list2(_0,_0);
  if ( GAMMA != _0 && s == 0 ) {
     GAMMA0 = lfirst(GAMMA);
     GAMMA1 = lsecond(GAMMA);
     D0P    = lcomp(COEF,GAMMA0);
     D1P    = lcomp(COEF,GAMMA1);
     D0	    = list2(D0P,GAMMA1);
     D1	    = list2(GAMMA0,D1P);
     GNEU0  = lfirst(GNEU);
     GNEU1  = lsecond(GNEU);
     G0P    = lcomp(COEF,GNEU0);
     G1P    = lcomp(COEF,GNEU1);
     G0	    = list2(G0P,GNEU1);
     G1	    = list2(GNEU0,G1P);
  }
/*
 * Verfeinere Bedingung - Ende
 * keine weiteren Koeffizienten - Anfang
 */
  if ( A == _0 ) {
     *pDEL  = list2(D0,D1);
     *pDNEU = list2(G0,G1);
     return;
  }
/*
 * keine weiteren Koeffizienten - Ende
 * rekursiver Aufruf - Anfang
 */
	   cgbadcon(r1,r2,A,D0,G0,b,&DELTA0,&DNEU0);
  *pDEL	 = DELTA0;
  *pDNEU = DNEU0;
  if ( s == 0 ) {
	 cgbadcon(r1,r2,A,D1,G1,b,&DELTA1,&DNEU1);
     X = llast(*pDEL);
	 lsred(X,DELTA1);
     X = llast(*pDNEU);
	 lsred(X,DNEU1);
  }
/*
 * rekursiver Aufruf - Ende
 * Ruecksprung
 */
  return;
}



/*  2.) cgbadptcgb */
/*c
			cgbadptcgb( r1, r2, PLIST, P )

	"comprehensive Groebner basis, add polynomials to comprehensive
	 Groebner basis"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbadptcgb(r1,r2,PLIST,P)	single r1,r2; list PLIST,P;
	PP = cgbadptcgb(r1,r2,PLIST,P);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PLIST ist eine Liste von gefaerbten Polynomen;
	      - P ist eine Liste von Polynomen.
	Polynome aus PLIST, die nicht in P sind, werden in die Liste P
	ohne ihre Faerbung eingetragen. Das ergebnis steht in PP.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbadptcgb    : 930531
H*/

/* #include <_pol2.h> */

list cgbadptcgb(r1,r2,PLIST,P)
single r1,r2;
list   PLIST,P;
{
/*
 * Fall: PLIST = {} - Anfang
 */
  if ( PLIST == _0 )  return(P);
/*
 * Fall: PLIST = {} - Ende
 * Fall: PLIST != {}
 */
  {
    list APCO,APOL,PL,PP;

    bind(PLIST,P);
    init(APCO,APOL,PL,PP);
/*
 * Vorbesetzen - Anfang
 */
    PP = P;
    PL = PLIST;
/*
 * Vorbesetzen - Ende
 * PP zusammenbauen - Anfang
 */
    while ( PL != _0 ) {
	  APCO = lfirst(PL);
	  PL   = lred(PL);
	  APOL = lfirst(APCO);
	  if ( lmemb(APOL,PP) == 0 )  PP = lcomp(APOL,PP);
    }
/*
 * PP zusammenbauen - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*  3.) cgbainb */
/*c
			cgbainb( r1, r2, ALIST, BLIST )

	"comprehensive Groebner basis, a in b"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbainb(r1,r2,ALIST,BLIST)  single r1,r2; list ALIST,BLIST;
	s = cgbainb(r1,r2,ALIST,BLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - ALIST und BLIST sind Listen von Koeffizienten.
	s = 1, wenn alle Elemente von ALIST auch in BLIST sind, sonst gilt:
	s = 0.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
   DATE cgbainb	      : 930531
H*/

/* #include <_pol2.h> */

single cgbainb(r1,r2,ALIST,BLIST)
single r1,r2;
list   ALIST,BLIST;
{
/*
 * Fall: ALIST oder BLIST = {}	- Anfang
 */
  if ( ALIST == _0 )  return(1);
  if ( BLIST == _0 )  return(0);
/*
 * Fall: ALIST oder BLIST = {}	- Ende
 * Fall: ALIST und BLIST != {}
 */
  {
    single s;
    list   A,X;

    bind(ALIST,BLIST);
    init(A,X);
/*
 * Vorbesetzen - Anfang
 */
    X = ALIST;
/*
 * Vorbesetzen - Ende
 * Test, ob ALIST in BLIST enthalten - Anfang
 */
    do {
       A = lfirst(X);
       X = lred(X);
       s = lmemb(A,BLIST);
    } while ( X != _0 && s != 0 );
/*
 * Test - Ende
 * Rueckgabe
 */
    return(s);
  }
}



/*  4.) cgbcc */
/*c
			cgbcc( r1, r2, CONS )

	"comprehensive Groebner basis, cover condition"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbcc(r1,r2,CONS)	single r1,r2; list CONS;
	C = cgbcc(r1,r2,CONS);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - CONS ist eine Fallunterscheidung.
	C ist eine Bedingung, die von CONS abgedeckt wird.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbcc	      : 930531
H*/

/* #include <_pol2.h> */

list cgbcc(r1,r2,CONS)
single r1,r2;
list   CONS;
{
/*
 * Fall: CONS = {}  - Anfang
 */
  if ( CONS == _0 )  return(_0);
/*
 * Fall: CONS = {}  - Ende
 * Fall: CONS != {}  - Anfang
 */
  {
    list C,C0,C1,COND,COND0,COND1,CONDS;

    bind(CONS);
    init(C,C0,C1,COND,COND0,COND1,CONDS);
/*
 * Vorbesetzen - Anfang
 */
    C	  = _0;
    CONDS = CONS;
/*
 * Vorbesetzen - Ende
 * Fall: CONS enthaelt nur EINE Bedingung - Anfang
 */
    COND  = lfirst(CONDS);
    CONDS = lred(CONDS);
    if ( CONDS == _0 ) {
       C = COND;
	   return(C);
    }
/*
 * Fall: CONS enthaelt nur EINE Bedingung - Ende
 * Fall: CONS enthaelt MEHR ALS EINE Bedingung - Anfang
 */
    COND0 = lfirst(COND);
    COND1 = lsecond(COND);
    C0	  = cgbscon(r1,r2,COND0,CONDS,0);
    C1	  = cgbscon(r1,r2,COND1,CONDS,1);
    if ( C0 != _0 || C1 != _0 )	 C = list2(C0,C1);
/*
 * Fall: CONS enthaelt MEHR ALS EINE Bedingung - Ende
 * Rueckgabe
 */
    return(C);
  }
}



/*  5.) cgbccop */
/*c
			cgbccop( r1, r2, PCO )

	"comprehensive Groebner basis, check colouring of polynomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbccop(r1,r2,PCO)  single r1,r2; list PCO;
	s = cgbccop(r1,r2,PCO);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PCO ist ein gefaerbtes Polynom.
	s = 1, wenn PCO gleich leere Liste oder komplett gruen gefaerbt
	       ist;
	s = 0, sonst.
c*/
/*H
	Version 1	24.11.1992	Th. Weis
   DATE cgbccop	      : 930531
H*/

/* #include <_pol2.h> */

single cgbccop(r1,r2,PCO)
single r1,r2;
list   PCO;
{
/*
 * Fall: PCO gleich leere Liste - Anfang
 */
  if ( PCO == _0 )  return(1);
/*
 * Fall: PCO gleich leere Liste - Ende
 * Fall: PCO ungleich leere Liste
 */
  {
    list COL,POL;

    bind(PCO);
    init(COL,POL);
/*
 * Vorbesetzen - Anfang
 */
    POL	 = lfirst(PCO);
    COL	 = lsecond(PCO);
/*
 * Vorbesetzen - Ende
 * Test, ob Polynom komplett gruen - Anfang
 */
    if ( COL == _0 )  return(1);
/*
 * Test - Ende
 * Rueckgabe
 */
    return(0);
  }
}



/*  6.) cgbcdop */
/*c
			cgbcdop( r1, r2, COL )

	"comprehensive Groebner basis, check degree of polynomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbcdop(r1,r2,COL)  single r1,r2; list COL;
	s = cgbcdop(r1,r2,COL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COL enthaelt eine Liste von roten Termen und eine
		Liste von weissen Termen.
	Ist die Liste der weissen Terme leer und der Grad des hoechsten
	roten Terms ist 0, so ist
	s = 1,	und sonst
	s = 0.
c*/
/*H
	Version 1	15.12.1992	Th. Weis
   DATE cgbcdop	      : 930531
H*/

/* #include <_pol2.h> */

single cgbcdop(r1,r2,COL)
single r1,r2;
list   COL;
{
/*
 * Fall: COL = {} - Anfang
 */
  if ( COL == _0 )  return(0);
/*
 * Fall: COL = {} - Ende
 * Fall: COL != {}
 */
  {
    single s;
    list   A,CRED,CWHITE;

    bind(COL);
    init(A,CRED,CWHITE);
/*
 * Vorbesetzen - Anfang
 */
    s	   = 0;
    CRED   = lfirst(COL);
    CWHITE = lsecond(COL);
    if ( CRED == _0 || CWHITE != _0 )  return(s);
    A = lfirst(CRED);
/*
 * Vorbesetzen - Ende
 * Test & Rueckgabe
 */
    if ( dipevsign(r1,A) == 0 )	 s = 1;
    return(s);
  }
}



/*  7.) cgbcdopl */
/*c
			cgbcdopl( r1, r2, PLIST )

	"comprehensive Groebner basis, check degree of polynomial list"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbcdopl  single r1,r2; list PLIST;
	PCO = cgbcdopl(r1,r2,PLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PLIST ist eine Liste gefaerbter Polynome.
	PCO ist ein Element von PLIST, so dass der Grad bzgl. der
	Faerbung des Polynoms Null ist. PCO ist die leere Liste, falls
	kein solches Polynom existiert.
c*/
/*H
	Version 1	21.12.1992	Th. Weis
   DATE cgbcdopl      : 930531
H*/

/* #include <_pol2.h> */

list cgbcdopl(r1,r2,PLIST)
single r1,r2;
list   PLIST;
{
/*
 * Fall: PLIST = {} - Anfang
 */
  if ( PLIST == _0 )  return(_0);
/*
 * Fall: PLIST = {} - Ende
 * Fall: PLIST != {} - Anfang
 */
  {
    single s;
    list   COL,PCO,PL,POL;

    bind(PLIST);
    init(COL,PCO,PL,POL);
/*
 * Vorbesetzen - Anfang
 */
    PCO = _0;
    PL	= PLIST;
/*
 * Vorbesetzen - Ende
 * Suche nach Element mit Grad 0 - Anfang
 */
    do {
       PCO  = lfirst(PL);
       PL   = lred(PL);
       POL  = lfirst(PCO);
       COL  = lsecond(PCO);
       s    = cgbcdop(r1,r2,COL);
    } while ( PL != _0 && s != 1 );
    if ( s == 0 )  PCO = _0;
/*
 * Suche nach Element mit Grad 0 - Ende
 * Rueckgabe
 */
    return(PCO);
  }
}



/*  8.) cgbcoldif */
/*c
		cgbcoldif( r1, r2, T, ACOLS, COLR, COLW, pCRED, pCWHITE )

	"comprehensive Groebner basis, colour difference"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbcoldif(r1,r2,T,ACOLS,COLR,COLW,pCRED,pCWHITE)  single r1,r2;
		 list T,ACOLS,COLR,COLW; list *pCRED,*pCWHITE;
	cgbcoldif(r1,r2,T,ACOLS,COLR,COLW,pCRED,pCWHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - T ist ein Term;
	      - ACOLS enthaelt eine Liste von roten Termen und eine Liste
		von weissen Termen;
	      - COLR ist eine Liste von roten Termen;
	      - COLW ist eine Liste von weissen Termen.
	Ist T ein Listenelement der Liste mit den roten Termen in ACOLS,
	so wird in pCRED COLR zusammen mit T abgelegt.
	Ist T ein Listenelement der Liste mit den weissen Termen in ACOLS,
	so wird in pCWHITE COLW zusammen mit T und seinem weissen Anteil
	abgelegt.
c*/
/*H
	Version 1	23.11.1992	Th. Weis
   DATE cgbcoldif     : 930531
H*/

/* #include <_pol2.h> */

cgbcoldif(r1,r2,T,ACOLS,COLR,COLW,pCRED,pCWHITE)
single r1,r2;
list   T,ACOLS,COLR,COLW;
list   *pCRED,*pCWHITE;
{
  list	 ACRED,ACWHIT,CP;

  bind(T,ACOLS,COLR,COLW);
  init(ACRED,ACWHIT,CP);
/*
 * Vorbesetzen - Anfang
 */
  ACRED	   = lfirst(ACOLS);
  ACWHIT   = lsecond(ACOLS);
  *pCRED   = COLR;
  *pCWHITE = COLW;
/*
 * Vorbesetzen - Ende
 * T der jeweiligen Farbe zuordnen - Anfang
 */
  if ( lmemb(T,ACRED) == 1 )  *pCRED = lcomp(T,*pCRED);
  else {
       CP = cgbfwf(r1,r2,T,ACWHIT);
       if ( CP != _0 )	*pCWHITE = lcomp(CP,*pCWHITE);
  }
/*
 * T der jeweiligen Farbe zuordnen - Ende
 * Ruecksprung
 */
  return;
}



/*  9.) cgbcolmul */
/*c
			cgbcolmul( r1, r2, ONECL, TTERM, b )

	"comprehensive Groebner basis, colour multiplication"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbcolmul(r1,r2,ONECL,TTERM,b)  single r1,r2;
	     list ONECL,TTERM; single b;
	CCOL = cgbcolmul(r1,r2,ONECL,TTERM,b);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ONECL ist eine Liste von (roten) Termen, wenn b=1;
		ONECL ist eine Liste von Paaren, wobei jedes Paar einen
		weissen Term enthaelt und den weissen Teil seines Koef-
		fizienten, wenn b=2;
	      - TTERM ist ein Term;
	      - b=1 oder b=2.
	Jeder Term in ONECL wird mit TTERM multipliziert, und das Resul-
	tat wird in CCOL abgelegt.
c*/
/*H
	Version 1	17.11.1992	Th. Weis
   DATE cgbcolmul     : 930531
H*/

/* #include <_pol2.h> */

list cgbcolmul(r1,r2,ONECL,TTERM,b)
single r1,r2;
list   ONECL,TTERM;
single b;
{
  list CCOL,CELEM,QLIST,T,TELEM,X;

  bind(ONECL,TTERM);
  init(CCOL,CELEM,QLIST,T,TELEM,X);
/*
 * Vorbesetzen - Anfang
 */
  X    = ONECL;
  CCOL = _0;
/*
 * Vorbesetzen - Ende
 * Multiplikation der Terme - Anfang
 */
  while ( X != _0 ) {
	TELEM = lfirst(X);
	X     = lred(X);
	if ( b == 2 ) {
	   T	 = lfirst(TELEM);
	   QLIST = lsecond(TELEM);
	}
	else  T = TELEM;
	T = dipevsum(r1,TTERM,T);
	if ( b == 2 ) {
	   CELEM = list2(T,QLIST);
	   CCOL	 = lcomp(CELEM,CCOL);
	}
	else  CCOL = lcomp(T,CCOL);
  }
  CCOL = linv(CCOL);
/*
 * Multiplikation - Ende
 * Rueckgabe
 */
  return(CCOL);
}



/* 10.) cgbcolprod */
/*c
			cgbcolprod( r1, r2, COL1, TTERM )

	"comprehensive Groebner basis, colour product"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbcolprod(r1,r2,COL1,TTERM)  single r1,r2; list COL1,TTERM;
	COL = cgbcolprod(r1,r2,COL1,TTERM);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COL1 enthaelt eine Liste von roten Termen und eine Liste
		von weissen Termen;
	      - TTERM ist ein Term.
	Jeder Term in COL1 wird mit TTERM multipliziert. COL ist das Re-
	sultat.
c*/
/*H
	Version 1	10.11.1992	Th. Weis
   DATE cgbcolprod    : 930531
H*/

/* #include <_pol2.h> */

list cgbcolprod(r1,r2,COL1,TTERM)
single r1,r2;
list   COL1,TTERM;
{
/*
 * Fall: COL1 = {}  - Anfang
 */
  if ( COL1 == _0 )  return(_0);
/*
 * Fall: COL1 = {}  - Ende
 * Fall: COL1 != {}
 */
  {
    list COL,CRED,CWHITE;

    bind(COL1,TTERM);
    init(COL,CRED,CWHITE);
/*
 * Vorbesetzen - Anfang
 */
    CRED   = lfirst(COL1);
    CWHITE = lsecond(COL1);
/*
 * Vorbesetzen - Ende
 * Fuehre Multiplikation durch - Anfang
 */
    if ( CRED != _0 )  CRED = cgbcolmul(r1,r2,CRED,TTERM,1);
    if ( CWHITE != _0 )	 CWHITE = cgbcolmul(r1,r2,CWHITE,TTERM,2);
    if ( CRED != _0 || CWHITE != _0 )  COL = list2(CRED,CWHITE);
/*
 * Multiplikation - Ende
 * Rueckgabe
 */
    return(COL);
  }
}



/* 11.) cgbdiplm */
/*c
			cgbdiplm( r1, r2, L1, L2 )

	"comprehensive Groebner basis, distributive polynomial list merge"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbdiplm(r1,r2,L1,L2)  single r1,r2; list L1,L2;
	L = cgbdiplm(r1,r2,L1,L2);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - L1 und L2 sind Listen von gefaerbten Polynomen in distri-
		butiver Darstellung in aufsteigender Ordnung.
	L ist die Vereinigung von L1 und L2.
	!! ACHTUNG: L1 und L2 werden veraendert. !!
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbdiplm      : 930531
H*/

/* #include <_pol2.h> */

list cgbdiplm(r1,r2,L1,L2)
single r1,r2;
list   L1,L2;
{
STEP1: /* L1 oder L2 leere Liste */
       if ( L1 == _0 )	return(L2);
       if ( L2 == _0 )	return(L1);

  {
    list   L,LP,LP1,COL1;
    list   LP2,COL2;
    list   PCI,PCO,PLI;
    pol	   POL;
    vec	   EL1,EL2;

    bind(L1,L2);
    init(L,LP,LP1,COL1);
    init(LP2,COL2);
    init(PCO,PLI,PCI);
    init(POL);
    init(EL1,EL2);

    STEP2: /* Initialisieren */
	   LP1	= L1;
	   LP2	= L2;
	   PCO	= lfirst(L1);
	   POL	= lfirst(PCO);
	   COL1 = lsecond(PCO);
	   EL1	= cgbhtt(r1,r2,COL1);
	   if ( EL1 == _0 )  EL1 = dipevl(r1,POL);
	   PCI	= lfirst(L2);
	   PLI	= lfirst(PCI);
	   COL2 = lsecond(PCI);
	   EL2	= cgbhtt(r1,r2,COL2);
	   if ( EL2 == _0 )  EL2 = dipevl(r1,PLI);
	   if ( dipevcomp(r1,EL1,EL2) > 0 ) {
	      L	  = L2;
	      LP  = L2;
	      LP2 = lred(L2);
		    goto STEP4;
	   }
	   else {
		L   = L1;
		LP  = L1;
		LP1 = lred(L1);
	   }
    STEP3: /* letztes Element von L1 */
	   if ( LP1 == _0 )  goto STEP5;
	   PCO	= lfirst(LP1);
	   POL	= lfirst(PCO);
	   COL1 = lsecond(PCO);
	   EL1	= cgbhtt(r1,r2,COL1);
	   if ( EL1 == _0 )  EL1 = dipevl(r1,POL);
	   if ( dipevcomp(r1,EL1,EL2) <= 0 ) {
	      LP  = LP1;
	      LP1 = lred(LP1);
		    goto STEP3;
	   }
	   else {
		      lsred(LP,LP2);
		LP  = LP2;
		LP2 = lred(LP2);
	   }
    STEP4: /* letztes Element von L2 */
	   if ( LP2 == _0 )  goto STEP5;
	   PCI	 = lfirst(L2);
	   PLI	 = lfirst(PCI);
	   COL2	 = lsecond(PCI);
	   EL2	 = cgbhtt(r1,r2,COL2);
	   if ( EL2 == _0 )  EL2 = dipevl(r1,PLI);
	   if ( dipevcomp(r1,EL1,EL2) <= 0 ) {
		    lsred(LP,LP1);
	      LP  = LP1;
	      LP1 = lred(LP1);
		    goto STEP3;
	   }
	   else {
		LP  = LP2;
		LP2 = lred(LP2);
		      goto STEP4;
	   }
    STEP5: /* Schluss */
	   if ( LP1 == _0 )  lsred(LP,LP2);
	   else	 lsred(LP,LP1);
	   return(L);
  }
}



/* 12.) cgbdiplpm */
/*c
			cgbdiplpm( r1, r2, A )

	"comprehensive Groebner basis, distributive polynomial list
	 pair-merge sort"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbdiplpm(r1,r2,A)	 single r1,r2; list A;
	B = cgbdiplpm(r1,r2,A);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - A ist eine Liste von gefaerbten Polynomen.
	B ist die Liste A, nachdem sie durch das "merge-sort" Verfahren in
	aufsteigender Ordnung bzgl. ihrer Faerbung sortiert wurde.
c*/
/*H
	Version 1	05.11.1992	Th. Weis
   DATE cgbdiplpm     : 930531
H*/

/* #include <_pol2.h> */

list cgbdiplpm(r1,r2,A)
single r1,r2;
list   A;
{
/*
 * Fall: A = {}	 oder  A = {A1}	 - Anfang
 */
  if ( A == _0 || lred(A) == _0 )  return(A);
/*
 * Fall: A = {}	 oder  A = {A1}	 - Ende
 */
  {
    single t;
    list   AP,APP,APPP;
    list   B,BP,BPP;
    list   C,CP,CPP,CS;
    list   PCO,COL1,COL2;
    list   PCI,PLI;
    pol	   POL;
    vec	   EL1,EL2;

    bind(A);
    init(AP,APP,APPP);
    init(B,BP,BPP);
    init(C,CP,CPP,CS);
    init(PCO,COL1,COL2);
    init(PCI,PLI);
    init(POL);
    init(EL1,EL2);
/*
 * Vorbesetzen - Anfang
 */
    AP = A;
    C  = list1(0);
    CS = C;
/*
 * Vorbesetzen - Ende
 * Konstruiere Paare - Anfang
 */
    do {
       PCO  = lfirst(AP);
       APP  = lred(AP);
       POL  = lfirst(PCO);
       COL1 = lsecond(PCO);
       if ( APP == _0 )	 BP = AP;
       else {
	    PCI	  = lfirst(APP);
	    APPP  = lred(APP);
	    PLI	  = lfirst(PCI);
	    COL2  = lsecond(PCI);
	    EL1	  = cgbhtt(r1,r2,COL1);
	    if ( EL1 == _0 )  EL1 = dipevl(r1,POL);
	    EL2 = cgbhtt(r1,r2,COL2);
	    if ( EL2 == _0 )  EL2 = dipevl(r1,PLI);
	    if ( dipevcomp(r1,EL1,EL2) <= 0 ) {
	       BP = AP;
		    lsred(APP,_0);
	    }
	    else {
		 BP = APP;
		      lsred(APP,AP);
		      lsred(AP,_0);
	    }
       }
       C  = lcomp(BP,C);
       AP = APPP;
    } while ( APP != _0 && AP != _0 );
/*
 * Konstruiere Paare - Ende
 * "circle and merge" - Anfang
 */
    BP = lfirst(C);
    C  = lred(C);
	 lsfirst(CS,BP);
	 lsred(CS,C);
    B  = lfirst(C);
    CP = lred(C);
    while ( C != CP ) {
	  BP  = lfirst(CP);
	  CPP = lred(CP);
	  BPP = cgbdiplm(r1,r2,B,BP);
		lsfirst(C,BPP);
		lsred(C,CPP);
	  C   = CPP;
	  B   = lfirst(C);
	  CP  = lred(C);
    }
    B = linv(B);
/*
 * "circle and merge" - Ende
 * Rueckgabe
 */
    return(B);
  }
}



/* 13.) cgbdp */
/*c
			cgbdp( r1, r2, GA, PIN, COL, pDLIST, pCLIST )

	"comprehensive Groebner basis, destine polynomial" (rekursiv)
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbdp(r1,r2,GA,PIN,COL,pDLIST,pCLIST)  single r1,r2; list GA,PIN,COL;
	     list *pDLIST,*pCLIST;
	cgbdp(r1,r2,GA,PIN,COL,pDLIST,pCLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - GA ist eine Bedingung;
	      - PIN ist ein Polynom;
	      - COL enthaelt die Liste der roten Terme von PIN und die Liste
		der weissen Terme von PIN bzgl. der Bedingung (GA).
	pDLIST ist eine Fallunterscheidung, die GA abdeckt und PIN bestimmt.
	pCLIST ist eine Liste von Paaren, wobei jedes Paar eine Bedingung
	von pDLIST enthaelt und PIN, gefaerbt bzgl. dieser Bedingung.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE cgbdp	      : 930531.941201
H*/

/* #include <_pol2.h> */

cgbdp(r1,r2,GA,PIN,COL,pDLIST,pCLIST)
single r1,r2;
list   GA,PIN,COL;
list   *pDLIST,*pCLIST;
{
  list ALIST,CCL,CP,DCOND,DD,DL,DLNEU,NCOL,NEUCON,PCI,X;

  bind(GA,PIN,COL);
  init(ALIST,CCL,CP,DCOND,DD,DL,DLNEU,NCOL,NEUCON,PCI,X);
/*
 * Vorbesetzen - Anfang
 */
  *pDLIST = _0;
  *pCLIST = _0;
/*
 * Vorbesetzen - Ende
 * Test, ob PIN durch GA bestimmt ist - Anfang
 */
  cgbtht(r1,r2,COL,&CP);
  if ( CP == _0 ) {
     if ( GA != _0 )  *pDLIST = list1(GA);
     PCI     = list2(PIN,COL);
     *pCLIST = list2(GA,PCI);
	       return;
  }
/*
 * Test - Ende
 * Verfeinere GA - Anfang
 */
  ALIST = lsecond(CP);
	  cgbadcon(r1,r2,ALIST,GA,_0,0,&DD,&DLNEU);
/*
 * Verfeinerung - Ende
 * rekursiver Aufruf von cgbdp mit verfeinerter Bedingung
 * GA	     - Anfang
 */
  while ( DLNEU != _0 ) {
	NEUCON = lfirst(DLNEU);
	DLNEU  = lred(DLNEU);
	DCOND  = lfirst(DD);
	DD     = lred(DD);
	NCOL   = cgbscol(r1,r2,NEUCON,COL);
		 cgbdp(r1,r2,DCOND,PIN,NCOL,&DL,&CCL);
	if ( DL != _0 ) {
	   if ( *pDLIST == _0 )	 *pDLIST = DL;
	   else {
		X = llast(*pDLIST);
		    lsred(X,DL);
	   }
	}
	if ( *pCLIST == _0 )  *pCLIST = CCL;
	else {
	     X = llast(*pCLIST);
		 lsred(X,CCL);
	}
  }
/*
 * rekursiver Aufruf - Ende
 * Ruecksprung
 */
  return;
}



/* 14.) cgbelocp */
/*c
			cgbelocp( r1, r2, ALIST, BLIST )

	"comprehensive Groebner basis, equal lists of coloured polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbelocp(r1,r2,ALIST,BLIST)  single r1,r2; list ALIST,BLIST;
	s = cgbelocp(r1,r2,ALIST,BLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ALIST und BLIST sind Listen von gefaerbten Polynomen.
	s = 1, wenn ALIST gleich BLIST ist;
	s = 0, sonst.
c*/
/*H
	Version 1	25.08.1992	Th. Weis
   DATE cgbelocp      : 930531
H*/

/* #include <_pol2.h> */

list cgbelocp(r1,r2,ALIST,BLIST)
single r1,r2;
list   ALIST,BLIST;
{
/*
 * Fall: ALIST oder BLIST = {}	- Anfang
 */
  if ( ALIST == _0 || BLIST == _0 )  return(0);
/*
 * Fall: ALIST oder BLIST = {}	- Ende
 * Fall: ALIST und BLIST != {}
 */
  {
    single s;
    list   A,APCO,B,BPCO,J1Y,J2Y;

    bind(ALIST,BLIST);
    init(A,APCO,B,BPCO,J1Y,J2Y);
/*
 * Vorbesetzen - Anfang
 */
    A = ALIST;
    B = BLIST;
/*
 * Vorbesetzen - Ende
 * Vergleiche Polynomlisten - Anfang
 */
    do {
       APCO = lfirst(A);
       A    = lred(A);
       BPCO = lfirst(B);
       B    = lred(B);
       J1Y  = lfirst(APCO);
       J2Y  = lfirst(BPCO);
       s    = oequal(J1Y,J2Y);
    } while ( A != _0 && B != _0 && s != 0 );
    if ( A == _0 && B != _0 )  s = 0;
    if ( A != _0 && B == _0 )  s = 0;
/*
 * Vergleiche Polynomlisten - Ende
 * Rueckgabe
 */
    return(s);
  }
}



/* 15.) cgbfcb */
/*c
                        cgbfcb( r1, r2, CGBL )

        "comprehensive Groebner basis from coloured base"
        Quellbibliothek: srclib.pol2
        Include-Datei:   _pol2.h
        list cgbfcb(r1,r2,CGBL)  single r1,r2; list CGBL;
        CGB = cgbfcb(r1,r2,CGBL);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - CGBL ist eine Liste von gefaerbten Polynomen.
        CGB ist eine Liste von Polynomen in CGBL (ohne Farben).
c*/
/*H
	Version 1	02.06.1993	Th. Weis
   DATE cgbfcb        : 931130
H*/

/* #include <_pol2.h> */

list cgbfcb(r1,r2,CGBL)
single r1,r2;
list   CGBL;
{
/*
 * Fall: CGBL = {}  - Anfang
 */
  if ( CGBL == _0 )  return(_0);
/*
 * Fall: CGBL = {}  - Ende
 * Fall: CGBL != {}
 */
  {
    list CGB,P,PCO,PPL;

    bind(CGBL);
    init(CGB,P,PCO,PPL);
/*
 * Vorbesetzen - Anfang
 */
    CGB = _0;
    PPL = CGBL;
/*
 * Vorbesetzen - Ende
 * Basis zusammenstellen - Anfang
 */
    while ( PPL != _0 ) {
          PCO = lfirst(PPL);
          PPL = lred(PPL);
          P   = lfirst(PCO);
          CGB = lcomp(P,CGB);
    }
/*
 * Basis zusammenstellen - Ende
 * Rueckgabe
 */
    return(CGB);
  }
}



/* 16.) cgbfco */
/*c
		cgbfco( r1, r2, APP, ACOLS, COLR, COLW, pCRED, pCWHITE )

	"comprehensive Groebner basis, finish colouring"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbfco(r1,r2,APP,ACOLS,COLR,COLW,pCRED,pCWHITE)	 single r1,r2;
	      list APP,ACOLS,COLR,COLW; list *pCRED,*pCWHITE;
	cgbfco(r1,r2,APP,ACOLS,COLR,COLW,pCRED,pCWHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - APP ist ein Polynom;
	      - ACOLS enthaelt eine Liste von roten Termen und eine Liste
		von weissen Termen.
	      - COLR ist eine Liste von roten Termen;
	      - COLW ist eine Liste von weissen Termen.
	pCRED enthaelt COLR und die roten Terme von APP. pCWHITE enthaelt
	COLW und die weissen Terme von APP mit ihrem weissen Teil.
c*/
/*H
	Version 1	24.11.1992	Th. Weis
   DATE cgbfco	      : 930531
H*/

/* #include <_pol2.h> */

cgbfco(r1,r2,APP,ACOLS,COLR,COLW,pCRED,pCWHITE)
single r1,r2;
list   APP,ACOLS,COLR,COLW;
list   *pCRED,*pCWHITE;
{
  list AL,AP,EL;

  bind(APP,ACOLS,COLR,COLW);
  init(AL,AP,EL);
/*
 * Vorbesetzen - Anfang
 */
  *pCRED   = COLR;
  *pCWHITE = COLW;
  AP	   = APP;
/*
 * Vorbesetzen - Ende
 * Die Koeffizienten von APP nach Farben sortieren - Anfang
 */
  while ( AP != _0 ) {
    AP = dipmoad(r1,AP,&AL,&EL);
	 cgbcoldif(r1,r2,EL,ACOLS,*pCRED,*pCWHITE,pCRED,pCWHITE);
  }
/*
 * Die Koeffizienten von APP nach Farben sortieren - Ende
 * Ruecksprung
 */
  return;
}



/* 17.) cgbfbc */
/*c
			cgbfbc( r1, r2, RE, POL )

	"comprehensive Groebner basis, find base coefficient"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbfbc(r1,r2,RE,POL)  single r1,r2; list RE; pol POL;
	PA = cgbfbc(r1,r2,RE,POL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - RE ist ein Term;
	      - POL ist ein Polynom, wobei RE ein Teilterm von POL ist.
	PA ist der Basiskoeffizient von RE in POL.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbfbc	      : 930531
H*/

/* #include <_pol2.h> */

list cgbfbc(r1,r2,RE,POL)
single r1,r2;
list   RE;
pol    POL;
{
  list PA,PE,X;

  bind(RE,POL);
  init(PA,PE,X);
/*
 * FINDE einen Term - Anfang
 */
  X = POL;
  do {
     X = dipmoad(r1,X,&PA,&PE);
  } while ( oequal(RE,PE) != 1 );
/*
 * FINDE einen Term - Ende
 * Rueckgabe
 */
  return(PA);
}



/* 18.) cgbfm */
/*c
			cgbfm( r1, r2, RE, POL )

	"comprehensive Groebner basis, find monomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbfm(r1,r2,RE,POL)  single r1,r2; list RE; pol POL;
	RPOL = cgbfm(r1,r2,RE,POL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - RE ist ein Term;
	      - POL ist ein Polynom, wobei RE ein Teilterm von POL ist.
	RPOL ist ein Polynom, das nur das Monom, das von RE gebildet
	wird, enthaelt.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbfm	      : 930531
H*/

/* #include <_pol2.h> */

list cgbfm(r1,r2,RE,POL)
single r1,r2;
list   RE;
pol    POL;
{
  list PA,PE,RPOL,X;

  bind(RE,POL);
  init(PA,PE,RPOL,X);
/*
 * Vorbesetzen - Anfang
 */
  X    = POL;
  RPOL = _0;
/*
 * Vorbesetzen - Ende
 * FINDE Basiskoeffizient - Anfang
 */
  do {
     X = dipmoad(r1,X,&PA,&PE);
  } while ( oequal(RE,PE) != 1 );
/*
 * FINDE Basiskoeffizient - Ende
 * Bilde Polynom - Anfang
 */
  RPOL = dipfmo(r1,PA,PE);
/*
 * Bilde Polynom - Ende
 * Rueckgabe
 */
  return(RPOL);
}



/* 19.) cgbfpol */
/*c
			cgbfpol( r1, r2, PCO, P, red, pPCI, pRE )

	"comprehensive Groebner basis, find polynomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbfpol(r1,r2,PCO,P,red,pPCI,pRE)  single r1,r2; list PCO,P;
	       single red; list *pPCI,*pRE;
	cgbfpol(r1,r2,PCO,P,red,pPCI,pRE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PCO ist ein gefaerbtes Polynom;
	      - P ist eine Liste von gefaerbten Polynomen;
	      - red=0: es wird ein Polynom fuer die Topreduktion von PCO
		       modulo P gesucht;
		red=1: es wird ein Polynom fuer die Reduktion ueber allen
		       Termen von PCO modulo P gesucht;
		red also Schalter fuer Reduktionsverfahren.
	pPCI ist die leere Liste, wenn kein Polynom gefunden wurde.
	Andernfalls ist pPCI das gefundene Polynom und pRE ist der Term
	von PCO der eliminiert wurde.
c*/
/*H
	Version 1	24.11.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE cgbfpol	      : 930531.941201
H*/

/* #include <_pol2.h> */

cgbfpol(r1,r2,PCO,P,red,pPCI,pRE)
single r1,r2;
list   PCO,P;
single red;
list   *pPCI,*pRE;
{
  single s;
  list	 ALIST,COL,COL2,CP,CWHITE,HE,KEY,PIN,PLI,POL,PP,RA;

  bind(PCO,P);
  init(ALIST,COL,COL2,CP,CWHITE,HE,KEY,PIN,PLI,POL,PP,RA);
/*
 * Vorbesetzen - Anfang
 */
  POL = lfirst(PCO);
  COL = lsecond(PCO);
  s   = 0;
/*
 * Vorbesetzen - Ende
 * Von red abhaengige Polynomsuche - Anfang
 * Suche fuer Topreduktion
 */
  if ( red == 0 ) {
     *pRE = cgbhtt(r1,r2,COL);
     if ( *pRE == _0 ) {
	CWHITE = lsecond(COL);
	CP     = lfirst(CWHITE);
	*pRE   = lfirst(CP);
     }
     PP = P;
     do {
	*pPCI = lfirst(PP);
	PP    = lred(PP);
	PLI   = lfirst(*pPCI);
	COL2  = lsecond(*pPCI);
	HE    = cgbhtt(r1,r2,COL2);
	if ( HE != _0 )	 s = dipevmt(r1,*pRE,HE);
     } while ( s != 1 && PP != _0 );
     if ( s == 0 )  *pPCI = _0;
     return;
  }
/*
 * Suche fuer Reduktion
 */
  if ( red == 1 ) {
     *pPCI = _0;
     while ( POL != _0 && s == 0 ) {
	   POL = dipmoad(r1,POL,&RA,pRE);
	   PP  = P;
		 cgbkco(r1,r2,*pRE,COL,&KEY,&ALIST);
	   if ( KEY != 0 ) {
	      do {
		 PLI  = lfirst(PP);
		 PP   = lred(PP);
		 PIN   = lfirst(PLI);
		 COL2 = lsecond(PLI);
		 HE   = cgbhtt(r1,r2,COL2);
		 if ( HE != _0 )  s = dipevmt(r1,*pRE,HE);
	      } while ( s != 1 && PP != _0 );
	   }
     }
     if ( s == 1 )  *pPCI = PLI;
     return;
  }
/*
 * Suche - Ende
 * Ruecksprung
 */
  return;
}



/* 20.) cgbfwf */
/*c
			cgbfwf( r1, r2, TTERM, WHITE )

	"comprehensive Groebner basis, find white factors"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbfwf(r1,r2,TTERM,WHITE)	single r1,r2; list TTERM,WHITE;
	CP = cgbfwf(r1,r2,TTERM,WHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - TTERM ist ein Term;
	      - WHITE ist eine Liste von Paaren, die weiss gefaerbte Terme
		und ihre weiss gefaerbten Faktoren der Koeffizienten ent-
		halten.
	Ist TTERM in WHITE enthalten, so ist CP die Liste von TERM und den
	weiss gefaerbten Faktoren der Koeffizienten von TERM.
	Andernfalls ist CP die leere Liste.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbfwf	      : 930531
H*/

/* #include <_pol2.h> */

list cgbfwf(r1,r2,TTERM,WHITE)
single r1,r2;
list   TTERM,WHITE;
{
/*
 * Fall: TTERM oder WHITE = {}	- Anfang
 */
  if ( TTERM == 0 || TTERM == _0 || WHITE == _0 )  return(_0);
/*
 * Fall: TTERM oder WHITE = {}	- Ende
 * Fall:  TTERM und WHITE != {}
 */
  {
    single s;
    list   CP,CWHITE,WPACK,WTERM;

    bind(TTERM,WHITE);
    init(CP,CWHITE,WPACK,WTERM);
/*
 * Vorbesetzen - Anfang
 */
    CP	   = _0;
    CWHITE = WHITE;
/*
 * Vorbesetzen - Ende
 * SUCHE - Anfang
 */
    do {
       WPACK  = lfirst(CWHITE);
       CWHITE = lred(CWHITE);
       WTERM  = lfirst(WPACK);
       s      = oequal(TTERM,WTERM);
    } while ( s != 1 && CWHITE != _0 );
    if ( s == 1 )  CP = WPACK;
/*
 * SUCHE - Ende
 * Rueckgabe
 */
    return(CP);
  }
}



/* 21.) cgbglepr */
/*c
			cgbglepr( r1, r2, P )

	"comprehensive Groebner basis, global extraneous polynomials
	 remove"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbglepr(r1,r2,P)	single r1,r2; list P;
	PP = cgbglepr(r1,r2,P);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - P ist eine Liste gefaerbter Polynome.
	Bestimmte Polynome, die nicht dazu gehoeren, werden geloescht.
	Die resultierende Polynomliste ist PP.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbglepr      : 930531
H*/

/* #include <_pol2.h> */

list cgbglepr(r1,r2,P)
single r1,r2;
list   P;
{
/*
 * Fall: P oder lred(P) = {} - Anfang
 */
  if ( P == _0 || lred(P) == _0 )  return(P);
/*
 * Fall: P oder lred(P) = {} - Ende
 * Fall: P und lred(P) != {}
 */
  {
    single t;
    list   COL1,COL2,EI,EJ,PB,PCI,PCO,PP,PS;

    bind(P);
    init(COL1,COL2,EI,EJ,PB,PCI,PCO,PP,PS);
/*
 * Vorbesetzen - Anfang
 */
    PS = P;
    PP = _0;
/*
 * Vorbesetzen - Ende
 * Loeschen der nicht dazugehoerenden Polynome - Anfang
 */
    do {
       PCO  = lfirst(PS);
       PS   = lred(PS);
       COL1 = lsecond(PCO);
       EI   = cgbhtt(r1,r2,COL1);
       t    = 0;
       if ( EI != _0 ) {
	  PB = PS;
	  while ( PB != _0 && t == 0 ) {
		PCI  = lfirst(PB);
		PB   = lred(PB);
		COL2 = lsecond(PCI);
		EJ   = cgbhtt(r1,r2,COL2);
		if ( EJ != _0 )	 t = dipevmt(r1,EI,EJ);
	  }
	  PB = PP;
	  while ( PB != _0 && t == 0 ) {
		PCI  = lfirst(PB);
		PB   = lred(PB);
		COL2 = lsecond(PCI);
		EJ   = cgbhtt(r1,r2,COL2);
		if ( EJ != _0 )	 t = dipevmt(r1,EI,EJ);
	  }
       }
       if ( t == 0 )  PP = lcomp(PCO,PP);
    } while ( PS != _0 );
    PP = linv(PP);
/*
 * Loeschen der nicht dazugehoerenden Polynome - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/* 22.) cgbgpwogm */
/*c
			cgbgpwogm( r1, r2, PL )

	"comprehensive Groebner basis, get polynomials without green
	 monomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbgpwogm(r1,r2,PL)  single r1,r2; list PL;
	X = cgbgpwogm(r1,r2,PL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PL ist eine Liste von gefaerbten Polynomen.
	X ist die Liste der Polynome in PL ohne gruene Monome.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbgpwogm     : 930531
H*/

/* #include <_pol2.h> */

list cgbgpwogm(r1,r2,PL)
single r1,r2;
list   PL;
{
/*
 * Fall: PL = {}  - Anfang
 */
  if ( PL == _0 )  return(_0);
/*
 * Fall: PL = {}  - Ende
 * Fall: PL != {}  - Anfang
 */
  {
    list PCO,PLIST,PPOL,X;

    bind(PL);
    init(PCO,PLIST,PPOL,X);
/*
 * Vorbesetzen - Anfang
 */
    X	  = _0;
    PLIST = PL;
/*
 * Vorbesetzen - Ende
 * Aussortieren - Anfang
 */
    while ( PLIST != _0 ) {
	  PCO	= lfirst(PLIST);
	  PLIST = lred(PLIST);
	  PPOL	= cgbmpwogm(r1,r2,PCO);
	  if ( PPOL != 0 )  X = lcomp(PPOL,X);
    }
    if ( X != _0 )  X = linv(X);
/*
 * Aussortieren - Ende
 * Rueckgabe
 */
    return(X);
  }
}



/* 23.) cgbhtt */
/*c
			cgbhtt( r1, r2, COL )

	"comprehensive Groebner basis, headterm test"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbhtt(r1,r2,COL)	single r1,r2; list COL;
	HT = cgbhtt(r1,r2,COL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COL enthaelt eine Liste von weissen Termen und eine
		Liste von roten Termen.
	HT ist der groesste rote Term, wenn er groesser ist als der
	groesste weisse Term, andernfalls ist HT leer.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbhtt	      : 930531
H*/

/* #include <_pol2.h> */

list cgbhtt(r1,r2,COL)
single r1,r2;
list   COL;
{
/*
 * Fall: COL = {}  - Anfang
 */
  if ( COL == _0 )  return(_0);
/*
 * Fall: COL = {}  - Ende
 * Fall: COL != {}  - Anfang
 */
  {
    list CE,CP,CRED,CWHITE,HT;

    bind(COL);
    init(CE,CP,CRED,CWHITE,HT);
/*
 * Vorbesetzen - Anfang
 */
    HT	   = _0;
    CRED   = lfirst(COL);
    CWHITE = lsecond(COL);
/*
 * Vorbesetzen - Ende
 * Fall: Liste der roten Terme oder Liste der
 *	 weissen Terme ist leer		       - Anfang
 */
    if ( CRED == _0 )  return(HT);
    if ( CWHITE == _0 ) {
       HT = lfirst(CRED);
	    return(HT);
    }
/*
 * Fall: Liste der roten Terme ODER Liste der
 *	 weissen Terme ist leer		       - Ende
 * Fall: Liste der roten Terme UND Liste der
 *	 weissen Terme ist NICHT leer	      - Anfang
 */
    if ( CRED != _0 ) {
       HT     = lfirst(CRED);
       CRED   = lred(CRED);
       CP     = lfirst(CWHITE);
       CWHITE = lred(CWHITE);
       if ( CP != _0 ) {
	  CE = lfirst(CP);
	  if ( CE != _0 ) {
	     if ( dipevcomp(r1,HT,CE) <= 0 )  HT = _0;
	  }
       }
    }
/*
 * Fall: Liste der roten Terme UND Liste der
 *	 weissen Terme ist NICHT leer	      - Ende
 * Rueckgabe
 */
    return(HT);
  }
}



/* 24.) cgbiconsgb */
/*c
	cgbiconsgb( r1, r2, VL1, VL2, BB, GSYS, fac, red, out, pGBSYS, pf )

	"comprehensive Groebner basis over integers, construct Groebner
	 system"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbiconsgb(r1,r2,VL1,VL2,BB,GSYS,fac,red,out,pGBSYS,pf)
		 single r1,r2; list VL1,VL2,BB,GSYS; single fac,red,out;
		 list *pGBSYS; FILE *pf;
	cgbiconsgb(r1,r2,VL1,VL2,BB,GSYS,fac,red,out,pGBSYS,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - BB ist eine Liste der Form:
		( COND1, P1, PAIRS1, ..., CONDn, Pn, PAIRSn ),
		wobei CONDi eine Bedingung ist,
		Pi ist eine durch CONDi betimmte Polynomliste
		und PAIRSi ist die Polynompaarliste der Pi fuer
		i = 1,...,n;
	      - GSYS ist das aktuelle Groebner-System;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten;
	      - red ist ein Schalter fuer den Reduktionstyp;
		fuer red = 0 wird cgbinorbtop  und
		fuer red = 1 wird cgbipanor benutzt;
	      - out ist ein Ausgabeschalter.
	In pGBSYS wird das Ergebnis abgelegt.
	Wird die Ausgabe von Zwischenergebnissen gewuenscht, so werden die
	Ergebnisse auf die Datei *pf geschrieben.
c*/
/*H
	Version 1	15.12.1992	Th. Weis
   DATE cgbiconsgb    : 930531
H*/

/* #include <_pol2.h> */

cgbiconsgb(r1,r2,VL1,VL2,BB,GSYS,fac,red,out,pGBSYS,pf)
single r1,r2;
list   VL1,VL2,BB,GSYS;
single fac,red,out;
list   *pGBSYS;
FILE   *pf;
{
  list COND,F,G,GS1,H,HCO,HCOL,N0,N1,P,PAIR,PAIRS,PLIST,PRSL,X;

  bind(VL1,VL2,BB,GSYS);
  init(COND,F,G,GS1,H,HCO,HCOL,N0,N1,P,PAIR,PAIRS,PLIST,PRSL,X);
/*
 * Vorbesetzen - Anfang
 */
  PLIST	  = BB;
  *pGBSYS = GSYS;
/*
 * Vorbesetzen - Ende
 * Berechnung von S-Polynomen und Normalformen - Anfang
 */
  while ( PLIST != _0 ) {
	COND  = lfirst(PLIST);
	PLIST = lred(PLIST);
	P     = lfirst(PLIST);
	PLIST = lred(PLIST);
	PAIRS = lfirst(PLIST);
	PLIST = lred(PLIST);
	while ( PAIRS != _0 ) {
	      PAIR  = lfirst(PAIRS);
	      PAIRS = lred(PAIRS);
	      PRSL  = _0;
	      GS1   = _0;
	      F	    = lsecond(PAIR);
	      G	    = lthird(PAIR);
		      cgbipaspol(r1,r2,COND,F,G,fac,&HCO);
	      if ( HCO == _0 ) {
		 if ( PAIRS == _0 )  *pGBSYS = cgbigbsup(r1,r2,VL1,VL2,COND,P,*pGBSYS,out,pf);
	      }
	      else {
		   H	= lfirst(HCO);
		   HCOL = lsecond(HCO);
		   if ( cgbcdop(r1,r2,HCOL) == 1 ) {
		      P	      = list1(HCO);
		      PAIRS   = _0;
		      *pGBSYS = cgbigbsup(r1,r2,VL1,VL2,COND,P,*pGBSYS,out,pf);
		   }
		   else {
			if ( red == 0 )	 cgbinorbtop(r1,r2,COND,HCO,P,fac,&N0,&N1);
			else  cgbipanor(r1,r2,COND,HCO,P,fac,&N0,&N1);
			cgbivnorf(r1,r2,VL1,VL2,COND,P,N0,N1,PAIRS,out,&P,&PAIRS,&PRSL,&GS1,pf);
		   }
	      }
	      if ( PRSL != _0 ) {
		 if ( PLIST == _0 )  PLIST = PRSL;
		 else {
		      X = llast(PLIST);
			  lsred(X,PRSL);
		 }
	      }
	      if ( GS1 != _0 ) {
		 if ( *pGBSYS == _0 )  *pGBSYS = GS1;
		 else {
		      X = llast(*pGBSYS);
			  lsred(X,GS1);
		 }
	      }
	}
  }
/*
 * Berechnung von S-Polynomen und Normalformen - Ende
 * Ruecksprung
 */
  return;
}



/* 25.) cgbidlop */
/*c
			cgbidlop( r1, r2, CONDS, P, fac, pDLIST, pPPL )

	"comprehensive Groebner basis over integers, destine list of
	 polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbidlop(r1,r2,CONDS,P,fac,pDLIST,pPPL)	 single r1,r2; list COND,P;
	       single fac; list *pDLIST,*pPPL;
	cgbidlop(r1,r2,CONDS,P,fac,pDLIST,pPPL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - CONDS ist eine Fallunterscheidung;
	      - P ist eine Liste von Polynomen;
	      - fac ist eine Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pDLIST ist eine Fallunterscheidung, die CONDS abdeckt und P be-
	stimmt. pPPL ist eine Liste von Paaren, wobei jedes Paar eine
	Bedingung von pDLIST enthaelt und P bzgl. dieser Bedingung ge-
	faerbt.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
   DATE cgbidlop      : 930531
H*/

/* #include <_pol2.h> */

cgbidlop(r1,r2,CONDS,P,fac,pDLIST,pPPL)
single r1,r2;
list   CONDS,P;
single fac;
list   *pDLIST,*pPPL;
{
/*
 * Fall: P = {}	 - Anfang
 */
  *pDLIST = CONDS;
  *pPPL	  = _0;
  if ( P == _0 )  return;
/*
 * Fall: P = {}	 - Ende
 * Fall: P != {}
 */
  {
    list CCL,CLIST,COL,D,DL,GA,PIN,PP,X;

    bind(CONDS,P);
    init(CCL,CLIST,COL,D,DL,GA,PIN,PP,X);
/*
 * Vorbesetzen - Anfang
 */
    PP	  = P;
    CLIST = _0;
/*
 * Vorbesetzen - Ende
 * Konstruiere pDLIST - Anfang
 */
    while ( PP != _0 ) {
	  PIN	  = lfirst(PP);
	  PP	  = lred(PP);
	  D	  = *pDLIST;
	  *pDLIST = _0;
	  if ( D == _0 ) {
	     COL     = cgbiic(r1,r2,_0,PIN,fac);
		       cgbdp(r1,r2,_0,PIN,COL,&DL,&CCL);
	     *pDLIST = DL;
	     if ( CLIST == _0 )	 CLIST = CCL;
	     else {
		  X = llast(CLIST);
		      lsred(X,CCL);
	     }
	  }
	  else {
	       while ( D != _0 ) {
		     GA	 = lfirst(D);
		     D	 = lred(D);
		     COL = cgbiic(r1,r2,GA,PIN,fac);
			   cgbdp(r1,r2,GA,PIN,COL,&DL,&CCL);
		     if ( DL != _0 ) {
			if ( *pDLIST == _0 )  *pDLIST = DL;
			else {
			     X = llast(*pDLIST);
				 lsred(X,DL);
			}
		     }
		     if ( CLIST == _0 )	 CLIST = CCL;
		     else {
			  X = llast(CLIST);
			      lsred(X,CCL);
		     }
	       }
	  }
    }
/*
 * Konstruktion - Ende
 * Konstruiere pPPL - Anfang
 */
    *pPPL = cgbvcap(r1,r2,*pDLIST,CLIST);
/*
 * Konstruktion - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 26.) cgbigbsnup */
/*c
		cgbigbsnup( r1, r2, VL1, VL2, NN0, P, out, pGSYS, pf )

	"comprehensive Groebner basis over integers, grobner system n0
	 update"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbigbsnup(r1,r2,VL1,VL2,NN0,P,out,pGSYS,pf)  single r1,r2;
		 list VL1,VL2,NN0,P; single out; list *pGSYS;
		 FILE pf;
	cgbigbsnup(r1,r2,VL1,VL2,NN0,P,out,pGSYS,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - NN0 ist eine Liste von Tripel der Form:
		( GA, PCO, C ), wobei
		- GA eine Bedingung ist,
		- PCO eine Normalform ist, die durch GA bestimmt und
		  komplett gruen gefaerbt wird,
		- C ein multiplikativer Faktor ist;
	      - P ist eine Liste von gefaerbten Polynomen;
	      - out ist ein Ausgabeschalter.
	Fuer jede Bedingung GA in NN0 wird das Paar ( GA, P ) zu pGSYS
	hinzugefuegt.
	Wird die Ausgabe von Zwischenergebnissen gewuenscht, so werden
	die Ergebnisse in die Datei *pf geschrieben.
c*/
/*H
	Version 1	21.12.1992	Th. Weis
   DATE cgbigbsnup    : 930531
H*/

/* #include <_pol2.h> */

cgbigbsnup(r1,r2,VL1,VL2,NN0,P,out,pGSYS,pf)
single r1,r2;
list   VL1,VL2,NN0,P;
single out;
list   *pGSYS;
FILE   *pf;
{
  list C,N0,NPCOND,PCO;

  bind(VL1,VL2,NN0,P);
  init(C,N0,NPCOND,PCO);
/*
 * Vorbesetzen - Anfang
 */
  N0	 = NN0;
  *pGSYS = _0;
/*
 * Vorbesetzen - Ende
 * pGSYS auf den neuesten Stand bringen - Anfang
 */
  while ( N0 != _0 ) {
	NPCOND	= lfirst(N0);
	N0	= lred(N0);
	PCO	= lfirst(N0);
	N0	= lred(N0);
	C	= lfirst(N0);
	N0	= lred(N0);
	*pGSYS	= cgbigbsup(r1,r2,VL1,VL2,NPCOND,P,*pGSYS,out,pf);
  }
/*
 * pGSYS auf den neuesten Stand bringen - Ende
 * Ruecksprung
 */
  return;
}



/* 27.) cgbigbsup */
/*c
		cgbigbsup( r1, r2, VL1, VL2, COND, P, GBSYS, out, pf )

	"comprehensive Groebner basis over integers, Groebner system
	 update"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbigbsup(r1,r2,VL1,VL2,COND,P,GBSYS,out,pf)  single r1,r2;
	     list VL1,VL2,COND,P,GBSYS; single out; FILE *pf;
	GSYS = cgbigbsup(r1,r2,VL1,VL2,COND,P,GBSYS,out,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - COND ist eine Bedingung;
	      - P ist eine bzgl. des Vorgaengers von COND bestimmte
		und gefaerbte Polynomliste;
	      - GBSYS ist das aktuelle Groebner System;
	      - out ist ein Ausgabeschalter.
	Die Faerbung eines jeden Polynoms der Liste P wird bzgl. COND
	auf den neuesten Stand gebracht. Nicht dazu gehoerende Polynome
	werden aus der Liste genommen. Die Bedingung und die resul-
	tierende Polynomliste werden zu GBSYS eingehaengt. In GSYS steht       
	das Resultat.
	Wird die Ausgabe von Zwischenergebnissen gewuenscht, so werden die
	Ergebnisse auf die Datei *pf geschrieben.     
c*/
/*H
	Version 1	22.12.1992	Th. Weis
   DATE cgbigbsup     : 930531
H*/

/* #include <_pol2.h> */

list cgbigbsup(r1,r2,VL1,VL2,COND,P,GBSYS,out,pf)
single r1,r2;
list   VL1,VL2,COND,P,GBSYS;
single out;
FILE   *pf;
{
  list ELEM,GSYS,PP;

  bind(VL1,VL2,COND,P,GBSYS);
  init(ELEM,GSYS,PP);
/*
 * Liste auf neuesten Stand bringen &
 * fremde Polynome eliminieren	      - Anfang
 */
  GSYS = GBSYS;
  PP   = cgbrep(r1,r2,P);
  PP   = cgbuppol(r1,r2,COND,PP);
  ELEM = list2(COND,PP);
  GSYS = lcomp(ELEM,GSYS);
/*
 * Liste auf neuesten Stand bringen &
 * fremde Polynome eliminieren	      - Ende
 * schalterbedingte Ausgabe - Anfang
 */
  if ( out == 1 ) {
     fprintf(pf,"\nnew Groebner basis:");
     cgbiwrcond(r1,r2,VL1,VL2,COND,pf);
     fprintf(pf,"base:");
     cgbiwrclp(r1,r2,VL1,VL2,PP,0,pf);
  }
/*
 * schalterbedingte Ausgabe - Ende
 * Rueckgabe
 */
  return(GSYS);
}



/* 28.) cgbigbsys */
/*c
		cgbigbsys( r1, r2, VL1, VL2, P, CNDS, fac, red, out, pf )

	"comprehensive Groebner basis over integers, Groebner system"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,pf)  single r1,r2;
	     list VL1,VL2,P,CNDS; single fac,red,out; FILE *pf;
	GSYS = cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,pf);

	P ist eine Liste von distributiven Polynomen in r1  (0<=r1<BASIS)
	Variablen ueber	 einem	Polynomring  ueber Z in r2  (0<=r2<BASIS)
	Variablen, wobei die Liste VL1 die r1 Variablennamen der Polynome
	repraesentiert, und die Liste VL2 die r2 Variablennamen des Poly-
	nomrings ueber Z repraesentiert (VL2 ist also die Liste der Vari-
	ablennamen des Grundrings).

	CNDS ist  eine	Fallunterscheidung, d.h. entweder die leere Liste
	("{}")	oder  eine Liste,  die aus einer geraden Anzahl von Teil-
	listen besteht, wobei die Teillisten mit ungerader Laufnummer die
	Koeffizientenpolynome enthalten, die  gleich  Null  sind, und die
	mit gerader Laufnummer	die  Koeffizientenpolynome,  die ungleich
	Null sind.
	Sei z.B. VL2 = a,b,c,d.
	Dann kann die Fallunterscheidung wie folgt aussehen:
	     {{a^2-d# c+d#}{a#}{}{a^4-b*a^3+c*d}},
		           d.h. a^2-d==0, c+d==0, a!=0, a^4-b*a^3+c*d!=0;
	     oder
	     {{a^2-d# c+d#}{a#}}, d.h. a^2-d==0, c+d==0, a!=0;
	     oder
	     {{}{b^2-d^3+c# a# c#}}, d.h. b^2-d^3+c!=0, a!=0, c!=0;
	     oder
	     {{b# c# a^5-d^4+d^3+d#}{}},
				       d.h. b==0, c==0, a^5-d^4+d^3+d==0.

	Mit dem Schalter  fac  wird die Faktorisierung der Koeffizienten-
	polynome ein (1) bzw. aus (0) geschaltet.
	Der Schalter red stellt den Reduktionsalgorithmus ein,	bzgl. dem
	die Polynome auf  Normalform  gebracht werden. Es stehen zwei Re-
	duktionsalgorithmen zur Verfuegung, einmal die Topreduktion, d.h.
	es  werden  nur	 die  fuehrenden  Monome (bzgl. der Termordnung),
	deren Koeffizienten ungleich Null sind, eliminiert.  Topreduktion
	wird  mit (0) eingestellt.  Der andere Reduktionsalgorithmus ent-
	spricht	 der  Reduktion	 bei  der  ueblichen  Groebnerbasen- bzw.
	Standardbasenberechnung.  Die allgemein	 uebliche  Reduktion wird
	mit (1) eingestellt.
	(cf. V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
	     oder
	     E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen im
	     Computer Algebra System ALDES/SAC2 1991 (Passau)		)
	Der Schalter  out  erlaubt die	Ausgabe	 von  Zwischenergebnissen
	waehrend des Programmlaufs. Wird die Ausgabe  von  Zwischenergeb-
	nissen	gewuenscht (Schalter = 1),  muss  zuvor	 eine  Datei  zum
	Schreiben geoeffnet werden, entweder durch
		GSYS = cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,stdout);
	was bewirkt, dass die Ausgabe auf dem Bildschirm erfolgt,
	oder durch
		pf   = fopen("ZWISCHWERTE","w");
		GSYS = cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,pf);
	     oder
		pf   = fopen("ZWISCHWERTE","a");
		GSYS = cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,pf);
	was bewirkt, dass die Zwischenergebnisse in  die  Datei	 mit  dem
	Namen "ZWISCHWERTE" geschrieben werden.	 Wird  keine  Ausgabe der
	Zwischenwerte gewuenscht, so hat der Schalter den Wert 0.

	Berechnet wird ein Groebnersystem GSYS, d.h.  anhand  der Fallun-
	terscheidung, die  waehrend  des  Programmlaufs weiter verfeinert
	wird, wird fuer jedes Koeffizientenlistenpaar (siehe oben: CONDS)
	eine Groebnerbasis berechnet, wodurch eine Art Baum entsteht, der
	in jedem Zweig ein Koeffizientenlistenpaar und eine dazugehoerige
	Groebnerbasis  enthaelt.  War  die  Fallunterscheidung	die leere
	Liste,	so wird waehrend der Rechnung eine Fallunterscheidung er-
	stellt und verfeinert.
c*/
/*H
	Version 1	07.12.1992	Th. Weis
   DATE cgbigbsys     : 930531
H*/

/* #include <_pol2.h> */

list cgbigbsys(r1,r2,VL1,VL2,P,CNDS,fac,red,out,pf)
single r1,r2;
list   VL1,VL2,P,CNDS;
single fac,red,out;
FILE   *pf;
{
/*
 * Fall: P = {} - Anfang
 */
  if ( P == _0 )  return(_0);
/*
 * Fall: P = {} - Ende
 * Fall: P != {}
 */
  {
    list BB,COND,CONDS,GSYS,J1Y,PAIRS,PCO,PELEM,PL,PP;

    bind(VL1,VL2,CNDS,P);
    init(BB,COND,CONDS,GSYS,J1Y,PAIRS,PCO,PELEM,PL,PP);
/*
 * Vorbsetzen - Anfang
 */
    GSYS = _0;
/*
 * Vorbesetzen - Ende
 * Bestimme P bzgl. CNDS - Anfang
 */
    cgbidlop(r1,r2,CNDS,P,fac,&CONDS,&PL);
/*
 * Bestimme P bzgl. CNDS - Ende
 * Ueberpruefe den Polynomgrad und konstruiere Paare - Anfang
 */
    BB = _0;
    while ( PL != _0 ) {
	  PELEM	 = lfirst(PL);
	  PL	 = lred(PL);
	  COND	 = lfirst(PELEM);
	  PP	 = lsecond(PELEM);
	  PCO	 = cgbcdopl(r1,r2,PP);
	  if ( PCO != _0 ) {
	     J1Y  = list1(PCO);
	     GSYS = cgbigbsup(r1,r2,VL1,VL2,COND,J1Y,GSYS,out,pf);
	  }
	  else {
	       cgbmkpair(r1,r2,PP,&PAIRS);
	       if ( PAIRS != _0 )  BB = lcomp3(COND,PP,PAIRS,BB);
	       else  GSYS = cgbigbsup(r1,r2,VL1,VL2,COND,PP,GSYS,out,pf);
	  }
    }
/*
 * Ueberpruefe den Polynomgrad und konstruiere Paare - Ende
 * Konstruiere Groebner-System - Anfang
 */
    cgbiconsgb(r1,r2,VL1,VL2,BB,GSYS,fac,red,out,&GSYS,pf);
/*
 * Konstruiere Groebner-System - Ende
 * Rueckgabe
 */
    return(GSYS);
  }
}



/* 29.) cgbiglobred */
/*c
			cgbiglobred( r1, r2, COND, P, fac )

	"comprehensive Groebner basis over integers, global reduction"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbiglobred(r1,r2,COND,P,fac)  single r1,r2; list COND,P;
	     single fac;
	CGB = cgbiglobred(r1,r2,COND,P,fac);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - P ist eine Polynomliste;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	CGB ist gefaerbte Polynomliste nach der Reduktion.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbiglobred   : 930531
H*/

/* #include <_pol2.h> */

list cgbiglobred(r1,r2,COND,P,fac)
single r1,r2;
list   COND,P;
single fac;
{
/*
 * Fall: P = {} - Anfang
 */
  if ( P == _0 )  return(_0);
/*
 * Fall: P = {} - Ende
 * Fall: P != {}
 */
  {
    list CGB,COL,J1Y,NCO,PCO,PLIST,POL,PP,QP;

    bind(COND,P);
    init(CGB,COL,J1Y,NCO,PCO,PLIST,POL,PP,QP);
/*
 * Vorbesetzen - Anfang
 */
    CGB	  = _0;
    PP	  = P;
    PLIST = _0;
/*
 * Vorbesetzen - Ende
 * Faerbung bzgl. COND - Anfang
 */
    while ( PP != _0 ) {
	  POL	= lfirst(PP);
	  PP	= lred(PP);
	  COL	= cgbiic(r1,r2,COND,POL,fac);
	  PCO	= list2(POL,COL);
	  PLIST = lcomp(PCO,PLIST);
    }
    PLIST = linv(PLIST);
/*
 * Faerbung bzgl. COND - Ende
 * Ueberpruefe den Grad und loesche Monome - Anfang
 */
    PCO = cgbcdopl(r1,r2,PLIST);
    if ( PCO != _0 ) {
       CGB = list1(PCO);
	     return(CGB);
    }
    PLIST = cgbremgt(r1,r2,COND,PLIST);
/*
 * Ueberpruefe den Grad und loesche Monome - Ende
 * Loesche nicht zugehoerige Polynome - Anfang
 */
    PLIST = cgbglepr(r1,r2,PLIST);
    if ( PLIST == _0 || lred(PLIST) == _0 ) {
       CGB = PLIST;
	     return(CGB);
    }
    QP = PLIST;
/*
 * Loesche nicht zugehoerige Polynome - Ende
 * Globale Reduktion - Anfang
 */
    while ( PLIST != _0 ) {
	  PCO	= lfirst(PLIST);
	  PLIST = lred(PLIST);
		  cgbirednor(r1,r2,COND,PCO,QP,fac,&NCO);
		  cgbirednor(r1,r2,COND,NCO,CGB,fac,&NCO);
	  if ( NCO != _0 )  J1Y = lfirst(NCO);
	  if ( NCO != _0 && cgbwtm(r1,r2,J1Y,CGB) == 0 )  CGB = lcomp(NCO,CGB);
    }
/*
 * Globale Reduktion - Ende
 * Vereinigung bilden - Anfang
 */
    CGB = cgbdiplpm(r1,r2,CGB);
/*
 * Vereinigung bilden - Ende
 * Rueckgabe
 */
    return(CGB);
  }
}



/* 30.) cgbigsred */
/*c
			cgbigsred( r1, r2, GS, fac )

	"comprehensive Groebner basis over integers, Groebner system
	 reduction"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbigsred(r1,r2,GS,fac)  single r1,r2; list GS; single fac;
	RS = cgbigsred(r1,r2,GS,fac);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - GS ist ein Groebner System;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	RS ist das reduzierte Groebner System.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbigsred     : 930531
H*/

/* #include <_pol2.h> */

list cgbigsred(r1,r2,GS,fac)
single r1,r2;
list   GS;
single fac;
{
/*
 * Fall: GS = {} - Anfang
 */
  if ( GS == _0 )  return(_0);
/*
 * Fall: GS = {} - Ende
 * Fall: GS != {}
 */
  {
    list PELEM,PPL,RELEM,RS;

    bind(GS);
    init(PELEM,PPL,RELEM,RS);
/*
 * Vorbesetzen - Anfang
 */
    RS = _0;
    PPL = GS;
/*
 * Vorbesetzen - Ende
 * System Reduktion - Anfang
 */
    while ( PPL != _0 ) {
	  PELEM = lfirst(PPL);
	  PPL	= lred(PPL);
	  RELEM = cgbired(r1,r2,PELEM,fac);
	  RS	= lcomp(RELEM,RS);
    }
/*
 * System Reduktion - Ende
 * Rueckgabe
 */
    return(RS);
  }
}



/* 31.) cgbiibcfac */
/*c
			cgbiibcfac( r1, r2, BC, fac )

	"comprehensive Groebner basis over integers, integral polynomial
	 base coefficient factorization"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbiibcfac(r1,r2,BC,fac)  single r1,r2; pol BC; single fac;
	FL = cgbiibcfact(r1,r2,BC,fac);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - BC ist ein Koeffizientenpolynom eines Polynoms in
		distributiver Darstellung;
	      - fac = 0	 oder fac = 1.
	Ist fac = 1, so ist FL die ganze Liste der Primfaktoren von BC;
	ist fac = 0, so enthaelt FL nur BC.
c*/
/*H
	Version 1	05.11.1992	Th. Weis
   DATE cgbiibcfac    : 930531
H*/

/* #include <_pol2.h> */

list cgbiibcfac(r1,r2,BC,fac)
single r1,r2;
pol    BC;
single fac;
{
/*
 * Fall: BC = {}  - Anfang
 */
  if ( BC == _0 )  return(_0);
/*
 * Fall: BC = {}  - Ende
 */
  {
    single s;
    list   FL,L;
    pol	   A,FCT;

    bind(BC);
    init(FL,L);
    init(A,FCT);
/*
 * Vorbesetzen - Anfang
 */
    L = _0;
    s = pisign(r2,BC);
    if ( s == (-1) )  A = pineg(r2,BC);
    else  A = BC;
/*
 * Vorbesetzen - Ende
 * Fall: fac == 0  - Anfang
 */
    if ( fac == 0 ) {
       FL = list1(A);
	    return(FL);
    }
/*
 * Fall: fac == 0  - Ende
 * Fall: fac == 1  - Anfang
 */
    L  = pifact(r2,A);
    L  = lred(L);
    if ( L == _0 ) {
       FL = list1(A);
	    return(FL);
    }
    FL = _0;
    while ( L != _0 ) {
	  FCT = lfirst(L);
	  L   = lred2(L);
	  FL  = lcomp(FCT,FL);
    }
/*
 * Fall: fac == 1  - Ende
 * Rueckgabe
 */
    return(FL);
  }
}



/* 32.) cgbiic */
/*c
			cgbiic( r1, r2, COND, PIN, fac )

	"comprehensive Groebner basis over integers, initialize colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbiic(r1,r2,COND,PIN,fac)	single r1,r2; list COND,PIN;
	     single fac;
	COL = cgbiic(r1,r2,COND,PIN,fac);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - PIN ist ein Polynom;
	      - fac ist ein Schalter fuer die Faktorisierung der
		Koeffizienten.
	COL ist die Liste der roten und weissen Terme von PIN bzgl. der
	Bedingung.
c*/
/*H
	Version 1	05.11.1992	Th. Weis
   DATE cgbiic	      : 930531
H*/

/* #include <_pol2.h> */

list cgbiic(r1,r2,COND,PIN,fac)
single r1,r2;
list   COND,PIN;
single fac;
{
/*
 * Fall: PIN = {}  - Anfang
 */
  if ( PIN == _0 )  return(_0);
/*
 * Fall: PIN = {}  - Ende
 * Fall: PIN != {}
 */
  {
    single c;
    list   A,ALIST,COL,CRED,CWHITE,PA,PACK,PE,POL,WFACTS;
    list   COND0,COND1;
    obj	   pC;

    bind(COND,PIN);
    init(A,ALIST,COL,CRED,CWHITE,PA,PACK,PE,POL,WFACTS);
    init(COND0,COND1);
    init(pC);
/*
 * Vorbesetzen - Anfang
 */
    COL	   = _0;
    POL	   = PIN;
    CRED   = _0;
    CWHITE = _0;
/*
 * Vorbesetzen - Ende
 * Erstelle Liste der roten und weissen Koeffizienten - Anfang
 */
    do {
       POL = dipmoad(r1,POL,&PA,&PE);
       if ( ispconst(r2,PA,&pC) == 1 )	CRED = lcomp(PE,CRED);
       else {
	    ALIST  = cgbiibcfac(r1,r2,PA,fac);
	    c	   = 0;
	    WFACTS = _0;
	    do {
	       A     = lfirst(ALIST);
	       ALIST = lred(ALIST);
	       if ( ispconst(r2,A,&pC) == 0 ) {
		  if ( COND == _0 )  WFACTS = lcomp(A,WFACTS);
		  else {
		       COND0 = lfirst(COND);
		       COND1 = lsecond(COND);
		       if ( lmemb(A,COND0) == 1 )  c = 1;
		       else  if ( lmemb(A,COND1) == 0 )	 WFACTS = lcomp(A,WFACTS);
		  }
	       }
	    } while ( c != 1 && ALIST != _0 );
	    if ( c == 0 ) {
	       if ( WFACTS == _0 )  CRED = lcomp(PE,CRED);
	       else {
		    PACK   = list2(PE,WFACTS);
		    CWHITE = lcomp(PACK,CWHITE);
	       }
	    }
       }
    } while ( POL != _0 );
    if ( CRED != _0 || CWHITE != _0 ) {
       if ( CRED != _0 )  CRED = linv(CRED);
       if ( CWHITE != _0 )  CWHITE = linv(CWHITE);
       COL = list2(CRED,CWHITE);
    }
/*
 * Erstelle Liste der roten und weissen Koeffizienten - Ende
 * Rueckabe
 */
    return(COL);
  }
}



/* 33.) cgbimkn1 */
/*c
	cgbimkn1( r1, r2, VL1, VL2, NN1, P, PAIRS, out, pPPLIST, pGSYS, pf)

	"comprehensive Groebner basis over integers, make n1"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbimkn1(r1,r2,VL1,VL2,NN1,P,PAIRS,out,pPPLIST,pGSYS,pf)
	       single r1,r2; list VL1,VL2,NN1,P,PAIRS; single out;
	       list *pPPLIST,*pGSYS; FILE *pf;
	cgbimkn1(r1,r2,VL1,VL2,NN1,P,PAIRS,out,pPPLIST,pGSYS,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - NN1 ist eine Liste von Tripel der Form:
		( GA, PCO, C ), wobei
		- GA eine Bedingung ist,
		- PCO eine Normalform ist, die durch GA bestimmt und
		  NICHT komplett gruen gefaerbt wird,
		- C ein multiplikativer Faktor ist;
	      - P ist eine Liste von gefaerbten Polynomen;
	      - PAIRS ist die Polynompaarliste von P;
	      - out ist ein Ausgabeschalter.
	pPPLIST ist eine Liste der Form:
	( COND1, P1, PAIRS1, ..., CONDn, Pn, PAIRSn ), konstruiert
	aus den Informationen der Liste NN1.
	pGSYS ist eine Liste von Paaren, wobei jedes Paar eine Bedingung
	und eine durch diese Bedingung bestimmte Groebner Basis enthaelt.
	Wird die Ausgabe von Zwischenergebnissen gewuenscht, so werden
	die Ergebnisse in die Datei *pf geschrieben.
c*/
/*H
	Version 1	21.12.1992	Th. Weis
   DATE cgbimkn1      : 930531
H*/

/* #include <_pol2.h> */

cgbimkn1(r1,r2,VL1,VL2,NN1,P,PAIRS,out,pPPLIST,pGSYS,pf)
single r1,r2;
list   VL1,VL2,NN1,P,PAIRS;
single out;
list   *pPPLIST,*pGSYS;
FILE   *pf;
{
  list C,COL,J1Y,N1,NPCOND,PAIRS1,PCO,POL,PP;

  bind(VL1,VL2,NN1,P,PAIRS);
  init(C,COL,J1Y,N1,NPCOND,PAIRS1,PCO,POL,PP);
/*
 * Vorbesetzen - Anfang
 */
  N1	   = NN1;
  *pPPLIST = _0;
  *pGSYS   = _0;
/*
 * Vorbesetzen - Ende
 * Ueberpruefe Grad der Normalformen,
 * bringe Groebner System und Paarliste
 * auf den neuesten Stand		- Anfang
 */
  while ( N1 != _0 ) {
	NPCOND = lfirst(N1);
	N1     = lred(N1);
	PCO    = lfirst(N1);
	N1     = lred(N1);
	C      = lfirst(N1);
	N1     = lred(N1);
	POL    = lfirst(PCO);
	COL    = lsecond(PCO);
	if ( cgbcdop(r1,r2,COL) == 1 ) {
	   J1Y	 = list1(PCO);
	   *pGSYS = cgbigbsup(r1,r2,VL1,VL2,NPCOND,J1Y,*pGSYS,out,pf);
	}
	else {
	     PAIRS1   = cgbmknp(r1,r2,P,PCO,PAIRS);
	     PP	      = cgbminpl(r1,r2,P,PCO);
	     *pPPLIST = lcomp3(NPCOND,PP,PAIRS1,*pPPLIST);
/*
 * Schalter bedingte Ausgabe der Zwischenergebnisse - Anfang
 */
	     if ( out == 1 ) {
		fprintf(pf,"\nnew");
		cgbiwrcond(r1,r2,VL1,VL2,NPCOND,pf);
		cgbiwrclp(r1,r2,VL1,VL2,PP,0,pf);
	     }
/*
 * Schalter bedingte Ausgabe der Zwischenergebnisse - Ende
 */

	}
  }
/*
 * Ueberpruefe Grad der Normalformen,
 * bringe Groebner System und Paarliste
 * auf den neuesten Stand		- Ende
 * Rueckspung
 */
  return;
}



/* 34.) cgbimnco */
/*c
	cgbimnco( r1, r2, COND, CA, CE, COLR, COLW, fac, pCRED, pCWHITE )

	"comprehensive Groebner basis over integers, make new colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbimnco(r1,r2,COND,CA,CE,COLR,COLW,fac,pCRED,pCWHITE)
	       single r1,r2; list COND,CA,CE,COLR,COLW; single fac;
	       list *pCRED,*pCWHITE;
	cgbimnco(r1,r2,COND,CA,CE,COLR,COLW,fac,pCRED,pCWHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - CA ist ein Koeffizient;
	      - CE ist ein Term;
	      - COLR ist eine Liste von roten Termen;
	      - COLW ist eine Liste von weissen Termen;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	Wird CA durch COND rot gefaerbt, so wird in pCRED COLR zusammen
	mit CE abgelegt.
	Wird CA durch COND weiss gefaerbt, so wird in pCWHITE COLW zusammen
	mit dem Paar, das von CE und den weissen Faktoren von CA gebildet
	wird, abgelegt.
c*/
/*H
	Version 1	23.11.1992	Th. Weis
   DATE cgbimnco      : 930531
H*/

/* #include <_pol2.h> */

cgbimnco(r1,r2,COND,CA,CE,COLR,COLW,fac,pCRED,pCWHITE)
single r1,r2;
list   COND,CA,CE,COLR,COLW;
single fac;
list   *pCRED,*pCWHITE;
{
  single s,c;
  list	 B,A,COND0,COND1,PACK,QALIST,WFACTS;
  int	 pC;

  bind(COND,CA,CE,COLR,COLW);
  init(B,A,COND0,COND1,PACK,QALIST,WFACTS);
  init(pC);
/*
 * Vorbesetzen - Anfang
 */
  *pCRED   = COLR;
  *pCWHITE = COLW;
/*
 * Vorbesetzen - Ende
 * Fall: CA ist ein konstantes Polynom - Anfang
 */
  if ( ispconst(r2,CA,&pC) == 1 ) {
     *pCRED = lcomp(CE,*pCRED);
	      return;
  }
/*
 * Fall: CA ist ein konstantes Polynom - Ende
 * CA faktorisieren - Anfang
 */
  s = pisign(r2,CA);
  if ( s == -1 )  B = pineg(r2,CA);
  else	B = CA;
  if ( fac == 0 )  QALIST = list1(B);
  else	QALIST = cgbiibcfac(r1,r2,B,fac);
/*
 * CA faktorisieren - Ende
 * Faktoren von CA ueberpruefen - Anfang
 */
  WFACTS = _0;
  c	 = 0;
  if ( COND != _0 ) {
     COND0 = lfirst(COND);
     COND1 = lsecond(COND);
  }
  else {
       COND0 = _0;
       COND1 = _0;
  }
  while ( QALIST != _0 && c == 0 ) {
	A      = lfirst(QALIST);
	QALIST = lred(QALIST);
	if ( ispconst(r2,A,&pC) == 0 ) {
	   if ( lmemb(A,COND0) == 1 )  c = 1;
	   else	 if ( lmemb(A,COND1) == 0 )  WFACTS = lcomp(A,WFACTS);
	}
  }
  if ( c == 0 ) {
     if ( WFACTS == _0 )  *pCRED = lcomp(CE,*pCRED);
     else {
	  PACK	   = list2(CE,WFACTS);
	  *pCWHITE = lcomp(PACK,*pCWHITE);
     }
  }
/*
 * Faktoren von CA ueberpruefen - Ende
 * Ruecksprung
 */
  return;
}



/* 35.) cgbinorbtop */
/*c
			cgbinorbtop( r1, r2, GA, FCO, P, fac, pN0, pN1 )

	"comprehensive Groebner basis over integers, normalform by
	 topreduction"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbinorbtop(r1,r2,GA,FCO,P,fac,pN0,pN1)	 single r1,r2; list GA,FCO,P;
		  single fac; list *pN0,*pN1;
	cgbinorbtop(r1,r2,GA,FCO,P,fac,pN0,pN1);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - GA ist eine Bedingung;
	      - FCO ist ein bzgl. GA gefaerbtes Polynom;
	      - P ist eine Liste bzgl. GA gefaerbter Polynome;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pN0 ist eine Liste von Tripel der Form ( COND,PCO,C ), wobei:
	      - COND eine Bedingung ist;
	      - PCO eine Normalform von FCO ist, bei der die Koeffizienten
		alle gruen bzgl. COND sind;
	      - C ist multiplikativer Faktor.
	pN1 ist eine Liste von Tripel der Form ( COND,PCO,C ), wobei:
	      - COND eine Bedingung ist;
	      - PCO eine Normalform von FCO ist, bei der die Koeffizienten
		NICHT alle gruen bzgl. COND sind;
	      - C ist multiplikativer Faktor.
c*/
/*H
	Version 1	24.11.1992	Th. Weis
   DATE cgbinorbtop   : 930531
H*/

/* #include <_pol2.h> */

cgbinorbtop(r1,r2,GA,FCO,P,fac,pN0,pN1)
single r1,r2;
list   GA,FCO,P;
single fac;
list   *pN0,*pN1;
{
/*
 * Fall: FCO gleich leere Liste - Anfang
 */
  *pN0 = _0;
  *pN1 = _0;
  if ( FCO == _0 )  return;
/*
 * Fall: FCO gleich leere Liste - Ende
 * Fall: FCO ungleich leere Liste
 */
  {
    single s;
    list   AL,C,CCL,COL,COND,D,DCOND,DL,F,FCOLS,N,NL,PCI,PCO,POL,QC,RE;

    bind(GA,FCO,P);
    init(AL,C,CCL,COL,COND,D,DCOND,DL,F,FCOLS,N,NL,PCI,PCO,POL,QC,RE);
/*
 * Vorbesetzen - Anfang
 */
    COND  = GA;
    C	  = pvinsert(0,1,r2);
    F	  = lfirst(FCO);
    FCOLS = lsecond(FCO);
/*
 * Vorbesetzen - Ende
 * FCO ist komplett gruen oder
 * P ist die leere Liste       - Anfang
 */
    if ( FCOLS == _0 ) {
       *pN0 = list3(COND,FCO,C);
	      return;
    }
    if ( P == _0 ) {
       *pN1 = list3(COND,FCO,C);
	      return;
    }
    NL = list2(COND,FCO);
    N  = list2(C,NL);
/*
 * FCO ist komplett gruen oder
 * P ist die leere Liste       - Ende
 * Reduktion - Anfang
 */
    while ( N != _0 ) {
	  C  = lfirst(N);
	  N  = lred(N);
	  NL = lfirst(N);
	  N  = lred(N);
	  while ( NL != _0 ) {
		COND = lfirst(NL);
		NL   = lred(NL);
		PCO  = lfirst(NL);
		NL   = lred(NL);
		do {
		   s = cgbccop(r1,r2,PCO);
		   if ( s == 1 )  *pN0 = lcomp3(COND,PCO,C,*pN0);
		   else {
			cgbfpol(r1,r2,PCO,P,0,&PCI,&RE);
			if ( PCI != _0 ) {
			       cgbipared(r1,r2,COND,PCO,PCI,RE,fac,&PCO,&QC);
			   C = piprod(r2,C,QC);
			}
			else {
			     POL = lfirst(PCO);
			     COL = lsecond(PCO);
			     RE	 = cgbhtt(r1,r2,COL);
			     if ( RE != _0 ) {
				*pN1 = lcomp3(COND,PCO,C,*pN1);
				s    = 1;
			     }
			     else {
				      cgbdp(r1,r2,COND,POL,COL,&DL,&CCL);
				  N = lcomp2(C,CCL,N);
				  s = 1;
			     }
			}
		   }
		} while ( s != 1 );
	  }
    }
/*
 * Reduktion - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 36.) cgbipadif */
/*c
	cgbipadif( r1, r2, COND, A, ACOLS, B, BCOLS, fac, pC, pCCOLS )

	"comprehensive Groebner basis over integers, parametric difference"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbipadif(r1,r2,COND,A,ACOLS,B,BCOLS,fac,pC,pCCOLS)  single r1,r2;
		list COND,A,ACOLS,B,BCOLS; single fac; list *pC,*pCCOLS;
	cgbipadif(r1,r2,COND,A,ACOLS,B,BCOLS,fac,pC,pCCOLS);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - A ist Polynom;
	      - ACOLS ist die Faerbung von A bzgl. COND;
	      - B ist ein Polynom;
	      - BCOLS ist die Faerbung von B bzgl. COND;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pC = A - B . pCCOLS ist die Faerbung von pC bzgl. COND.
c*/
/*H
	Version 1	10.11.1992	Th. Weis
   DATE cgbipadif     : 930531
H*/

/* #include <_pol2.h> */

cgbipadif(r1,r2,COND,A,ACOLS,B,BCOLS,fac,pC,pCCOLS)
single r1,r2;
list   COND,A,ACOLS,B,BCOLS;
single fac;
list   *pC,*pCCOLS;
{
/*
 * Fall: A oder B = 0  - Anfang
 */
  if ( A == 0 ) {
     *pC     = B;
     *pCCOLS = BCOLS;
	       return;
  }
  if ( B == 0 ) {
     *pC     = A;
     *pCCOLS = ACOLS;
	       return;
  }
/*
 * Fall: A oder B = 0  - Ende
 * Fall: A und B != 0
 */
  {
    single s;
    list   AKEY,AL,ALIST,AP,APP;
    list   BKEY,BL,BLIST,BP;
    list   CL,CP,CPP,EL,FL,R,W;

    bind(COND,A,ACOLS,B,BCOLS);
    init(AKEY,AL,ALIST,AP,APP);
    init(BKEY,BL,BLIST,BP);
    init(CL,CP,CPP,EL,FL,R,W);
/*
 * Vorbesetzen - Anfang
 */
    AP = A;
    BP = B;
    CP = _0;
    R  = _0;
    W  = _0;
/*
 * Vorbesetzen - Ende
 * Fuehre Subtraktion durch - Anfang
 */
    do {
       EL = dipevl(r1,AP);
       FL = dipevl(r1,BP);
       s  = dipevcomp(r1,EL,FL);
       if ( s == 1 ) {
	  AP = dipmoad(r1,AP,&AL,&EL);
	       cgbcoldif(r1,r2,EL,ACOLS,R,W,&R,&W);
	  CP = lcomp2(EL,AL,CP);
       }
       else {
	    if ( s == (-1) ) {
	       BP = dipmoad(r1,BP,&BL,&FL);
		    cgbcoldif(r1,r2,FL,BCOLS,R,W,&R,&W);
	       CL = pineg(r2,BL);
	       CP = lcomp2(FL,CL,CP);
	    }
	    else {
		 AP = dipmoad(r1,AP,&AL,&EL);
		 BP = dipmoad(r1,BP,&BL,&FL);
		 CL = pidif(r2,AL,BL);
		 if ( pisign(r2,CL) != 0 ) {
		    CP = lcomp2(EL,CL,CP);
			 cgbkco(r1,r2,EL,ACOLS,&AKEY,&ALIST);
			 cgbkco(r1,r2,FL,BCOLS,&BKEY,&BLIST);
		    if ( AKEY != 0 && BKEY == 0 )  cgbmco(r1,r2,ALIST,EL,R,W,&R,&W);
		    if ( AKEY == 0 && BKEY != 0 )  cgbmco(r1,r2,BLIST,EL,R,W,&R,&W);
		    if ( AKEY != 0 && BKEY != 0 )  cgbimnco(r1,r2,COND,CL,EL,R,W,fac,&R,&W);
		 }
	    }
       }
    } while ( AP != _0 && BP != _0 );
    APP = AP;
    if ( AP != _0 )  cgbfco(r1,r2,AP,ACOLS,R,W,&R,&W);
    if ( BP != _0 )  cgbfco(r1,r2,BP,BCOLS,R,W,&R,&W);
    if ( AP == _0 )  if ( BP != _0 )  APP = dippineg(r1,r2,BP);
    if ( CP == _0 )  *pC = APP;
    else {
	 CPP = CP;
	 *pC = linv(CP);
	       lsred(CPP,APP);
    }
    if ( *pC == _0 ) {
       *pC     = 0;
       *pCCOLS = _0;
    }
    else {
	 if ( R != _0 || W != _0 ) {
	    if ( R != _0 )  R = linv(R);
	    if ( W != _0 )  W = linv(W);
	    *pCCOLS = list2(R,W);
	 }
	 else  *pCCOLS = _0;
    }
/*
 * Subtraktion - Ende
 * Ruecksprung
 */
    return;
  } 
}



/* 37.) cgbipanor */
/*c
			cgbipanor( r1, r2, GA, FCO, P, fac, pN0, pN1 )

	"comprehensive Groebner basis over integers, parametric normalform"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbipanor(r1,r2,GA,FCO,P,fac,pN0,pN1)  single r1,r2; list GA,FCO,P;
		single fac; list *pN0,*pN1;
	cgbipanor(r1,r2,GA,FCO,P,fac,pN0,pN1);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - GA ist eine Bedingung;
	      - FCO ist ein bzgl. GA gefaerbtes Polynom;
	      - P ist eine Liste bzgl. GA gefaerbter Polynome;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pN0 ist eine Liste von Tripel der Form ( COND,PCO,C ), wobei:
	      - COND eine Bedingung ist;
	      - PCO eine Normalform von FCO ist, bei der die Koeffizienten
		alle gruen bzgl. COND sind;
	      - C ist multiplikativer Faktor.
	pN1 ist eine Liste von Tripel der Form ( COND,PCO,C ), wobei:
	      - COND eine Bedingung ist;
	      - PCO eine Normalform von FCO ist, bei der die Koeffizienten
		NICHT alle gruen bzgl. COND sind;
	      - C ist multiplikativer Faktor.
c*/
/*H
	Version 1	24.11.1992	Th. Weis
   DATE cgbipanor     : 930531
H*/

/* #include <_pol2.h> */

cgbipanor(r1,r2,GA,FCO,P,fac,pN0,pN1)
single r1,r2;
list   GA,FCO,P;
single fac;
list   *pN0,*pN1;
{
/*
 * Fall: FCO gleich leere Liste - Anfang
 */
  *pN0 = _0;
  *pN1 = _0;
  if ( FCO == _0 )  return;
/*
 * Fall: FCO gleich leere Liste - Ende
 * Fall: FCO ungleich leere Liste
 */
  {
    single s;
    list   AL,C,CCL,COL,COND,D,DCOND,DL,F,FCOLS,PCI,PCO,POL,QC,RE;

    bind(GA,FCO,P);
    init(AL,C,CCL,COL,COND,D,DCOND,DL,F,FCOLS,PCI,PCO,POL,QC,RE);
/*
 * Vorbesetzen - Anfang
 */
    COND  = GA;
    C	  = pvinsert(0,1,r2);
    F	  = lfirst(FCO);
    FCOLS = lsecond(FCO);
/*
 * Vorbesetzen - Ende
 * FCO ist komplett gruen oder
 * P ist die leere Liste       - Anfang
 */
    if ( FCOLS == _0 ) {
       *pN0 = list3(COND,FCO,C);
	      return;
    }
    if ( P == _0 ) {
       *pN1 = list3(COND,FCO,C);
	      return;
    }
    PCO = FCO;
/*
 * FCO ist komplett gruen oder
 * P ist die leere Liste       - Ende
 * Reduktion - Anfang
 */
    do {
       s = cgbccop(r1,r2,PCO);
       if ( s == 1 )  *pN0 = list3(COND,PCO,C);
       else {
	    cgbfpol(r1,r2,PCO,P,1,&PCI,&RE);
	    if ( PCI != _0 ) {
		   cgbipared(r1,r2,COND,PCO,PCI,RE,fac,&PCO,&QC);
	       C = piprod(r2,C,QC);
	    }
	    else  s = 1;
       }
    } while ( s != 1 );
    if ( *pN0 != _0 )  return;
/*
 * Reduktion - Ende
 * Finde fuehrendes Monom bzgl. COND - Anfang
 */
    POL = lfirst(PCO);
    COL = lsecond(PCO);
    RE	= cgbhtt(r1,r2,COL);
    if ( RE != _0 ) {
       *pN1 = list3(COND,PCO,C);
	      return;
    }
/*
 * Finde fuehrendes Monom bzgl. COND - Ende
 * Bestimme Polynom - Anfang
 */
    cgbdp(r1,r2,COND,POL,COL,&DL,&CCL);
    while ( CCL != _0 ) {
	  DCOND = lfirst(CCL);
	  CCL	= lred(CCL);
	  PCO	= lfirst(CCL);
	  CCL	= lred(CCL);
	  COL	= lsecond(PCO);
	  if ( COL == _0 )  *pN0 = lcomp3(DCOND,PCO,C,*pN0);
	  else	*pN1 = lcomp3(DCOND,PCO,C,*pN1);
    }
/*
 * Bestimme Polynom - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 38.) cgbipared */
/*c	      
		cgbipared( r1, r2, COND, PCO, PCI, RE, fac, pRCO, pHA )

	"comprehensive Groebner basis over integers, parametric reduction"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbipared(r1,r2,COND,PCO,PCI,RE,fac,pRCO,pHA)  single r1,r2;
		list COND; pol PCO,PCI; list RE; single fac;
		list *pRCO,*pHA;
	cgbipared(r1,r2,COND,PCO,PCI,RE,fac,pRCO,pHA);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - PCO und PCI sind gefaerbte Polynome; PCI wird durch COND
		bestimmt;
	      - RE ist ein Term in PCO, rot oder weiss gefaerbt durch die
		Bedingung COND; RE ist ein Vielfaches des (bzgl. COND)
		fuehrenden Terms von PCI;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pRCO ist das Resultat einer Einschrittreduktion von PCO (durch PCI)
	um den Term RE zu eliminieren. pHA ist der Faktor, mit dem PCO
	multipliziert werden muss, damit RE verschwindet.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
   DATE cgbipared     : 930531
H*/

/* #include <_pol2.h> */

cgbipared(r1,r2,COND,PCO,PCI,RE,fac,pRCO,pHA)
single r1,r2;
list   COND;
pol    PCO,PCI;
list   RE;
single fac;
list   *pRCO,*pHA;
{
  single s,t;
  list	 AL,ALIST,AP,APP,C,EL,HE,KEY,Q,RA,RAL,RAP,RCOLS,RPOL;
  list	 FCOL,FL,FPOL,GCOL,GPOL;

  bind(COND,PCO,PCI,RE);
  init(AL,ALIST,AP,APP,C,EL,HE,KEY,Q,RA,RAL,RAP,RCOLS,RPOL);
  init(FCOL,FL,FPOL,GCOL,GPOL);
/*
 * Vorbesetzen - Anfang
 * Bekomme Polynome und Farben
 * Erneuere die Faerbung von PCI
 */
  FPOL = lfirst(PCO);
  FCOL = lsecond(PCO);
  GPOL = lfirst(PCI);
  GCOL = lsecond(PCI);
  if ( COND != _0 )  GCOL = cgbscol(r1,r2,COND,GCOL);
/* 
 * Bekomme fuehrenden Term bzgl. COND 
 */
  HE   = cgbhtt(r1,r2,GCOL);
/*
 * Bekomme Faerbung von RE
 */
	  cgbkco(r1,r2,RE,FCOL,&KEY,&ALIST);
  *pRCO = _0;
  Q	= _0;
/*
 * Bereite PCO und PCI fuer Reduktion vor
 */
  RA	= cgbfbc(r1,r2,RE,FPOL);
  *pHA	= cgbfbc(r1,r2,HE,GPOL);
  RAL	= lfirst(RA);
  RAP	= lred(RA);
  FL	= lfirst(RAP);
  EL	= dipevdif(r1,RE,HE);
  t	= dipevsign(r1,EL);
/*
 * Vorbesetzen - Ende
 * Wenn RA rot gefaerbt ist, reduziere mit dem ggT von RA und pHA;
 * Wenn RA weiss gefaerbt ist, reduziere mit dem Produkt von RA und pHA.
 *	 - Anfang
 */
  if ( ALIST != _0 ) {
     AP	  = dipfmo(r1,RA,EL);
     APP  = dippiprod(r1,r2,GPOL,AP);
     FPOL = dippipiprod(r1,r2,FPOL,*pHA);
     GCOL = cgbws(r1,r2,GCOL,EL,ALIST);
  }
  else {
       C    = pigcdcf(r2,RA,*pHA,&RA,pHA);
       AP   = dipfmo(r1,RA,EL);
       APP  = dippiprod(r1,r2,GPOL,AP);
       FPOL = dippipiprod(r1,r2,FPOL,*pHA);
       if ( t != 0 )  GCOL = cgbcolprod(r1,r2,GCOL,EL);
  }
  cgbipadif(r1,r2,COND,FPOL,FCOL,APP,GCOL,fac,&RPOL,&RCOLS);
  if ( RPOL != 0 ) {
     AL = diplbc(r1,RPOL);
     if ( pisign(r2,AL) == (-1) )  RPOL = dippineg(r1,r2,RPOL);
     if ( RCOLS != _0 )	 *pRCO = list2(RPOL,RCOLS);
  }
/*
 * Reduktion - Ende
 * Ruecksprung
 */
  return;
}



/* 39.) cgbipaspol */
/*c
			cgbipaspol( r1, r2, COND, HA, HB, fac, pHCO )

	"comprehensive Groebner basis over integers, parametric
	 s-polynomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbipaspol(r1,r2,COND,HA,HB,fac,pHCO)  single r1,r2;
		 list COND,HA,HB; single fac; list *pHCO;
	cgbipaspol(r1,r2,COND,HA,HB,fac,pHCO);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - HA und HB sind gefaerbte Polynome;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pHCO ist das bereits gefaerbte S-Polynom von HA und HB.
	(S-Polynom:
	 Seien f das (bzgl. einer Ordnung) fuehrende Monom von HA
	 und g das fuehrende Monom von HB. Bilde nun das kgV(f,g).
	 Dann ergibt sich das S-Polynom zu:
	      pHCO = kgV(f,g)/f*HA - kgV(f,g)/g*HB .
	 Siehe auch:
	 Parametrische Groebnerbasen im Computer Algebra System
	 ALDES/SAC-2; Diplomarbeit von E. Schoenfeld (Mai 1991) )
c*/
/*H
	Version 1	24.11.1992	Th. Weis
   DATE cgbipaspol    : 930531
H*/

/* #include <_pol2.h> */

cgbipaspol(r1,r2,COND,HA,HB,fac,pHCO)
single r1,r2;
list   COND,HA,HB;
single fac;
list   *pHCO;
{
/*
 * Fall: HA oder HB gleich leere Liste - Anfang
 */
  *pHCO = _0;
  if ( HA == _0 || HB == _0 )  return;
/*
 * Fall: HA oder HB gleich leere Liste - Ende
 * Fall: HA und HB ungleich leere Liste
 */
  {
    single c;
    list   A,ACOL,AL,APP;
    list   B,BCOL,BL,BPP;
    list   CL,DL,DL1,EL,EL1,GL,H,HCOLS,RAL,RAP,SL;

    bind(COND,HA,HB);
    init(A,ACOL,AL,APP);
    init(B,BCOL,BL,BPP);
    init(CL,DL,DL1,EL,EL1,GL,H,HCOLS,RAL,RAP,SL);
/*
 * Vorbesetzen - Anfang
 */
    A	 = lfirst(HA);
    ACOL = lsecond(HA);
    B	 = lfirst(HB);
    BCOL = lsecond(HB);
    EL	 = cgbhtt(r1,r2,ACOL);
    DL	 = cgbhtt(r1,r2,BCOL);
/*
 * Vorbesetzen - Ende
 * Berechnung des S-Polynoms - Anfang
 */
    GL = dipevlcm(r1,EL,DL);
    SL = dipevsum(r1,EL,DL);
    c  = oequal(GL,SL);
    if ( c == 1 )  return;
    ACOL = cgbscol(r1,r2,COND,ACOL);
    AL	 = cgbfbc(r1,r2,EL,A);
    RAL	 = lfirst(AL);
    RAP	 = lred(AL);
    BCOL = cgbscol(r1,r2,COND,BCOL);
    BL	 = cgbfbc(r1,r2,DL,B);
    CL	 = pigcdcf(r2,AL,BL,&AL,&BL);
    EL1	 = dipevdif(r1,GL,EL);
    DL1	 = dipevdif(r1,GL,DL);
    APP	 = dipfmo(r1,BL,EL1);
    BPP	 = dipfmo(r1,AL,DL1);
    if ( dipevsign(r1,EL1) != 0 )  ACOL = cgbcolprod(r1,r2,ACOL,EL1);
    APP = dippiprod(r1,r2,A,APP);
    if ( dipevsign(r1,DL1) != 0 )  BCOL = cgbcolprod(r1,r2,BCOL,DL1);
    BPP = dippiprod(r1,r2,B,BPP);
	  cgbipadif(r1,r2,COND,APP,ACOL,BPP,BCOL,fac,&H,&HCOLS);
    if ( H != 0 ) {
       AL = diplbc(r1,H);
       if ( pisign(r2,AL) == (-1) )  H = dippineg(r1,r2,H);
       if ( HCOLS != _0 )  *pHCO = list2(H,HCOLS);
    }
/*
 * Berechnung des S-Polynoms - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 40.) cgbired */
/*c
			cgbired( r1, r2, PELEM, fac )

	"comprehensive Groebner basis over integers reduct"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbired(r1,r2,PELEM,fac)  single r1,r2; list PELEM; single fac;
	R = cgbired(r1,r2,PELEM,fac);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PELEM ist ein Paar, das eine Bedingung und eine bzgl. der
		Bedingung bestimmte und gefaerbte Polynomliste;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	Die Polynomliste wird reduziert. Das Ergebnis der Reduktion zusammen
	mit der Bedingung steht in R.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbired	      : 930531
H*/

/* #include <_pol2.h> */

list cgbired(r1,r2,PELEM,fac)
single r1,r2;
list   PELEM;
single fac;
{
  list COND,J1Y,NCO,PCO,PLIST,QP,R,RLIST;

  bind(PELEM);
  init(COND,J1Y,NCO,PCO,PLIST,QP,R,RLIST);
/*
 * Polynomliste bereit stellen - Anfang
 */
  R	= _0;
  COND	= lfirst(PELEM);
  PLIST = lsecond(PELEM);
  if ( PLIST == _0 ) {
     R = list2(COND,PLIST);
	 return(R);
  }
/*
 * Polynomliste bereit stellen - Ende
 * Grad ueberpruefen und "ueberfluessige" Polynome loeschen - Anfang
 */
  PCO = cgbcdopl(r1,r2,PLIST);
  if ( PCO != _0 ) {
     J1Y = list1(PCO);
     R	 = list2(COND,J1Y);
	   return(R);
  }
  else	PLIST = cgbrep(r1,r2,PLIST);
  if ( PLIST == _0 || lred(PLIST) == _0 ) {
     R = list2(COND,PLIST);
	 return(R);
  }
  QP	= PLIST;
  RLIST = _0;
/*
 * Grad ueberpruefen und "ueberfluessige" Polynome loeschen - Ende
 * Reduktion - Anfang
 */
  while ( PLIST != _0 ) {
	PCO   = lfirst(PLIST);
	PLIST = lred(PLIST);
		cgbirednor(r1,r2,COND,PCO,QP,fac,&NCO);
	if ( NCO != _0 )  RLIST = lcomp(NCO,RLIST);
  }
/*
 * Reduktion - Ende
 * Rueckgabe
 */
  RLIST = linv(RLIST);
  R	= list2(COND,RLIST);
  return(R);
}



/* 41.) cgbirednor */
/*c
			cgbirednor( r1, r2, COND, FCO, P, fac, pNCO )

	"comprehensive Groebner basis over integers, reduction normalform"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbirednor(r1,r2,COND,FCO,P,fac,pNCO)  single r1,r2;
		 list COND,FCO,P; single fac; list *pNCO;
	cgbirednor(r1,r2,COND,FCO,P,fac,pNCO);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - FCO ist ein gefaerbtes Polynom;
	      - P ist eine Liste durch COND bestimmter und gefaerbter
		Polynome;
	      - fac ist ein Schalter fuer die Faktorisierung der Koef-
		fizienten.
	pNCO ist die bzgl. COND und P erzeugte Normalform.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbirednor    : 930531
H*/

/* #include <_pol2.h> */

cgbirednor(r1,r2,COND,FCO,P,fac,pNCO)
single r1,r2;
list   COND,FCO,P;
single fac;
list   *pNCO;
{
  single s;
  list	 PCI,QC,RE;

  bind(COND,FCO,P);
  init(PCI,QC,RE);
/*
 * Vorbesetzen - Anfang
 */
  *pNCO = FCO;
  s	= 0;
/*
 * Vorbesetzen - Ende
 * Reduzieren - Anfang
 */
  do {
     cgbredfpol(r1,r2,*pNCO,P,&PCI,&RE);
     if ( PCI == _0 )  s = 1;
     else  cgbipared(r1,r2,COND,*pNCO,PCI,RE,fac,pNCO,&QC);
  } while ( s != 1 );
/*
 * Reduzieren - Ende
 * Ruecksprung
 */
  return;
}



/* 42.) cgbivnorf */
/*c

 cgbivnorf(r1,r2,VL1,VL2,COND,PP,N0,N1,PPAIRS,out,pP,pPAIRS,pPAIRSL,pGSYS,pf)

  "comprehensive Groebner basis over integers, verify normalforms"
   Quellbibliothek: srclib.pol2
   Include-Datei:   _pol2.h
   cgbivnorf(r1,r2,VL1,VL2,COND,PP,N0,N1,PPAIRS,out,
	    pP,pPAIRS,pPAIRSL,pGSYS,pf)
	   single r1,r2; list VL1,VL2,PP,N0,N1,PPAIRS;	single out;
	   list *pP,*pPAIRS,*pPAIRSL,*pGSYS; FILE *pf;
 cgbivnorf(r1,r2,VL1,VL2,COND,PP,N0,N1,PPAIRS,out,pP,pPAIRS,pPAIRSL,pGSYS,pf);
   Dabei muss gelten:
	 - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
	 - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
	 - VL1 ist die Liste der Variablennamen;
	 - VL2 ist die Liste der Parameternamen;
	 - COND ist eine Bedingung;
	 - PP ist eine durch COND bestimmte Polynomliste;
	 - N0 ist eine Liste von Tripel der Form:
	   ( GA, PCO, C ), wobei
	   - GA eine Bedingung ist,
	   - PCO eine Normalform ist, die durch GA bestimmt und
	     komplett gruen gefaerbt wird,
	   - C ein multiplikativer Faktor ist;
	 - N1 ist eine Liste von Tripel der Form:
	   ( GA, PCO, C ), wobei
	   - GA eine Bedingung ist,
	   - PCO eine Normalform ist, die durch GA bestimmt und
	     NICHT komplett gruen gefaerbt wird,
	   - C ein multiplikativer Faktor ist;
	 - PPAIRSist die Polynompaarliste von PP
	 - out ist ein Ausgabeschalter.
	Sind die Normalformen ueberprueft, dann ist:
	- pP die auf den neusten Stand gebrachte Liste PP,
	- pPAIRS die auf den neusten Stand gebrachte Liste PPAIRS.
	pPAIRSL ist eine Liste der Form:
	( COND1, P1, PAIRS1, ..., CONDn, Pn, PAIRSn ), konstruiert
	aus den Informationen der Listen N0 und N1.
	pGSYS ist eine Liste von Paaren, wobei jedes Paar eine Bedingung
	und eine durch diese Bedingung bestimmte Groebner Basis enthaelt.
	Wird die Ausgabe von Zwischenergebnissen gewuenscht, so werden
	die Ergebnisse auf die Datei *pf geschrieben.
c*/
/*H
	Version 1	15.12.1992	Th. Weis
   DATE cgbivnorf     : 930531
H*/

/* #include <_pol2.h> */

cgbivnorf(r1,r2,VL1,VL2,COND,PP,N0,N1,PPAIRS,out,pP,pPAIRS,pPAIRSL,pGSYS,pf)
single r1,r2;
list   VL1,VL2,PP,N0,N1,PPAIRS;
single out;
list   *pP,*pPAIRS,*pPAIRSL,*pGSYS;
FILE   *pf;
{
  single c,s;
  list	 C,COL,GSYS0,GSYS1,N1P,NCO,NPCOND,POL,PRS0,PRS1,X;

  bind(VL1,VL2,PP,N0,N1,PPAIRS);
  init(C,COL,GSYS0,GSYS1,N1P,NCO,NPCOND,POL,PRS0,PRS1,X);
/*
 * Vorbesetzen - Anfang
 */
  c	   = 0;
  s	   = 0;
  PRS0	   = _0;
  PRS1	   = _0;
  GSYS0	   = _0;
  GSYS1	   = _0;
  *pPAIRSL = _0;
  *pGSYS   = _0;
  *pP	   = PP;
  *pPAIRS  = PPAIRS;
/*
 * Vorbesetzen - Ende
 * Schalter s setzen - Anfang
 */
  if ( N0 == _0 && N1 == _0 && *pPAIRS == _0 )	s = 1;
/*
 * Schalter s setzen - Ende
 * Ueberpruefe N0 - Anfang
 */
  if ( N0 != _0 ) {
     if ( *pPAIRS == _0 ) {
	if ( N1 != _0 )	 cgbigbsnup(r1,r2,VL1,VL2,N0,*pP,out,&GSYS0,pf);
	else  s = 1;
     }
     else {
	  if ( N1 == _0 )  c = 1;
	  else	cgbmkn0(r1,r2,N0,*pP,*pPAIRS,&PRS0);
     }
  }
/*
 * Ueberpruefe N0 - Ende
 * Ueberpruefe N1 - Anfang
 */
  if ( N1 != _0 ) {
     NPCOND = lfirst(N1);
     N1P    = lred(N1);
     NCO    = lfirst(N1P);
     N1P    = lred(N1P);
     C	    = lfirst(N1P);
     N1P    = lred(N1P);
     if ( N1P == _0 && N0 == _0 ) {
	POL  = lfirst(NCO);
	COL  = lsecond(NCO);
	s    = cgbcdop(r1,r2,COL);
	if ( s == 0 ) {
	   *pPAIRS = cgbmknp(r1,r2,*pP,NCO,*pPAIRS);
	   *pP	   = cgbminpl(r1,r2,*pP,NCO);
	   c	   = 1;
	}
	else  *pP = list1(NCO);
     }
     else  cgbimkn1(r1,r2,VL1,VL2,N1,*pP,*pPAIRS,out,&PRS1,&GSYS1,pf);
  }
/*
 * Ueberpruefe N1 - Ende
 * PAIRSL auf den neuesten Stand bringen - Anfang
 */
  *pPAIRSL = PRS0;
  if ( PRS1 != _0 ) {
     if ( *pPAIRSL == _0 )  *pPAIRSL = PRS1;
     else {
	  X = llast(*pPAIRSL);
	      lsred(X,PRS1);
     }
  }
/*
 * PAIRSL auf den neuesten Stand bringen - Ende
 * GSYS auf den neuesten Stand bringen - Anfang
 */
  *pGSYS = GSYS0;
  if ( GSYS1 != _0 ) {
     if ( *pGSYS == _0 )  *pGSYS = GSYS1;
     else {
	  X = llast(*pGSYS);
	      lsred(X,GSYS1);
     }
  }
  if ( c == 0 )	 *pPAIRS = _0;
  if ( s == 1 )	 *pGSYS	 = cgbigbsup(r1,r2,VL1,VL2,COND,*pP,*pGSYS,out,pf);
/*
 * GSYS auf den neuesten Stand bringen - Ende
 * Ruecksprung
 */
  return;
}



/* 43.) cgbiwrclp */
/*c
			cgbiwrclp( r1, r2, VL1, VL2, PL, b, pf )

	"comprehensive Groebner basis over integers, write coloured
	 polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbiwrclp(r1,r2,VL1,VL2,PL,b)  single r1,r2;
	       list VL1,VL2,PL; single b;
	a = cgbiwrclp(r1,r2,VL1,VL2,PL,b);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - PL ist eine Liste von gefaerbten Polynomen;
	      - b = 0: Polynome werden ausgegeben;
		b = 1: Polynome und die roten und weissen Monome
		      werden ausgegeben.
	Die Ausgabe wird in die Datei *pf geschrieben.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/
/*H
	Version 1	02.12.1992	Th. Weis
        Version 2	28.06.1993	ueberfluessige while-Schleife
					entfernt.  TW
   DATE cgbiwrclp     : 930531.931130
H*/

/* #include <_pol2.h> */

single cgbiwrclp(r1,r2,VL1,VL2,PL,b,pf)
single r1,r2;
list   VL1,VL2,PL;
single b;
FILE   *pf;
{
  single err=0;
  list	 COLS,PLIST,POL,P,X,VL;

  bind(VL1,VL2,PL);
  init(COLS,PLIST,POL,P,X,VL);
/*
 * Ausgabe - Anfang
 */
  if ( PL == _0 )  return(fprintf(pf,"\n{}\n"));
  PLIST = PL;
  VL	= lcconc(VL2,VL1);
  if ( fprintf(pf,"\n{\n") != 0 )  return(ERROR);
  while ( PLIST != _0 ) {
	X     = lfirst(PLIST);
	PLIST = lred(PLIST);
	if ( X == _0 ) {
	   if ( fprintf(pf,"\nPCO = {}") != 0 ) { err = ERROR; break; }
	}
	else {
	     POL   = lfirst(X);
	     COLS  = lsecond(X);
             P     = diptop(r1,POL);
 	     if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
	     if ( fputpi(r1+r2,P,VL,pf) != 0 ) { err = ERROR; break; }
	     if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
	     if ( b == 1 ) {
		if ( cgbiwrcol(r1,r2,VL1,VL2,COLS,POL,pf) != 0 ) { err = ERROR; break; }
	     }
	}
  }
  if ( !err )  err = fprintf(pf,"}\n");
  return(err);
}



/* 44.) cgbiwrclpwogm */
/*c
		cgbiwrclpwogm( r1, r2, VL1, VL2, COND, PL, pf )

	"comprehensive Groebner basis over integers, write coloured
	 polynomials without green monomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbiwrclpwogm(r1,r2,VL1,VL2,COND,PL,pf)  single r1,r2;
	     list VL1,VL2,COND,PL; FILE *pf;
	X = cgbiwrclpwogm(r1,r2,VL1,VL2,COND,PL,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - COND ist eine Bedingung;
	      - PL ist eine Liste von Polynomen, die bzgl. COND
		gefaerbt sind.
	Die Bedingungen und die Polynom ohne die Monome, deren Koef-
	fizienten gleich 0 sind, werden in die Datei *pf geschrieben.
	X ist
	    eine Liste  falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/
/*H
	Version 1	12.12.1992	Th. Weis
        Version 2	28.06.1993	while-Scleife durch Funktion
					ersetzt; 
                                        Funktionstyp single -> list.  TW
   DATE cgbiwrclpwogm : 930531.931130
H*/
	
/* #include <_pol2.h> */

list cgbiwrclpwogm(r1,r2,VL1,VL2,COND,PL,pf)
single r1,r2;
list   VL1,VL2,COND,PL;
FILE   *pf;
{
  list	 COND0,COND1,X;

  bind(VL1,VL2,COND,PL);
  init(COND0,COND1,X);
/*
 * Ausgabe - Anfang
 */
  X  = cgbgpwogm(r1,r2,PL);
  if ( X == _0 )  return(X);
  if ( COND != _0 ) {
     COND0 = lfirst(COND);
     COND1 = lsecond(COND);
     if ( COND0 != _0 ) {
	if ( fprintf(pf,"base without vanishing terms:") != 0 )	 return(ERROR);
	if ( X == _0 ) {
	   if ( fprintf(pf,"\n{}\n") != 0 )  return(ERROR);
	}
	else {
             if ( fputdippil(r1,r2,X,VL1,VL2,pf) != 0 )  return(ERROR);
	}
     }
  }
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
  return(X);
}


/* 45.) cgbiwrcol */
/*c
			cgbiwrcol( r1, r2, VL1, VL2, COL, POL, pf )

	"comprehensive Groebner basis over integers, write colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbiwrcol(r1,r2,VL1,VL2,COL,POL,pf)  single r1,r2;
	       list VL1,VL2,COL,POL; FILE *pf;
	a = cgbiwrcol(r1,r2,VL1,VL2,COL,POL,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - COL enthaelt die roten und weissen Terme von POL;
	      - POL ist ein Polynom.
	Die roten und weissen Monome werden in die Datei *pf geschrieben.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/
/*H
	Version 1	02.12.1992	Th. Weis
   DATE cgbiwrcol     : 930531
H*/

/* #include <_pol2.h> */

single cgbiwrcol(r1,r2,VL1,VL2,COL,POL,pf)
single r1,r2;
list   VL1,VL2,COL,POL;
FILE   *pf;
{
  single err=0;
  list	 COLR,COLW,PACK,QA,QALIST,T,TERM,VL;

  bind(VL1,VL2,COL,POL);
  init(COLR,COLW,PACK,QA,QALIST,T,TERM,VL);
/*
 * Ausgabe - Anfang
 */
  if ( COL == _0 )  return(err);
  COLR = lfirst(COL);
  COLW = lsecond(COL);
  VL   = lcconc(VL2,VL1);  
  if ( COLR != _0 ) {
     if ( fprintf(pf," terms != 0:\n { ") != 0 )  return(ERROR);
     while ( COLR != _0 ) {
	   T	= lfirst(COLR);
	   COLR = lred(COLR);
	   TERM = cgbfm(r1,r2,T,POL);
	   TERM = diptop(r1,TERM);
	   if ( fputpi(r1+r2,TERM,VL,pf) != 0 ) { err = ERROR; break; }
	   if ( COLR != _0 ) {
	      if ( fprintf(pf,", ") != 0 ) { err = ERROR; break; }
	   }
     }
     if ( !err && fprintf(pf," }") != 0 ) return(ERROR);
  }
  if ( COLW == _0 ) return(fprintf(pf,"\n\n"));
  if ( !err && fprintf(pf,"\n terms == v != 0:\n {\n  ") != 0 )	 return(ERROR);
  while ( COLW != _0 ) {
	PACK   = lfirst(COLW);
	COLW   = lred(COLW);
	T      = lfirst(PACK);
	QALIST = lsecond(PACK);
	TERM   = cgbfm(r1,r2,T,POL);
	TERM   = diptop(r1,TERM);
	if ( fputpi(r1+r2,TERM,VL,pf) != 0 ) { err = ERROR; break; }
	if ( fprintf(pf," { ") != 0 ) { err = ERROR; break; }
	while ( QALIST != _0 ) {
	      QA     = lfirst(QALIST);
	      QALIST = lred(QALIST);
	      if ( fputpi(r2,QA,VL2,pf) != 0 ) { err = ERROR; break; }
	      if ( QALIST != _0 ) {
		 if ( fprintf(pf,", ") != 0 ) { err = ERROR; break; }
	      }
	}
	if ( COLW != _0 ) {
	   if ( !err && fprintf(pf," },\n  ") != 0 ) { err = ERROR; break; }
	}
  }
  if ( !err )  err = fprintf(pf," }\n }\n\n");
/*
 * Ausgabe - Ende
 * Ruecksprung
 */
  return(err);
}



/* 46.) cgbiwrcond */
/*c
			cgbiwrcond( r1, r2, VL1, VL2, COND, pf )

	"comprehensive Groebner basis over integers, write condition"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbiwrcond(r1,r2,VL1,VL2,COND,pf)  single r1,r2;
	       list VL1,VL2,COND; FILE *pf;
	a = cgbiwrcond(r1,r2,VL1,VL2,COND,pf);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - VL1 ist die Liste der Variablennamen;
	      - VL2 ist die Liste der Parameternamen;
	      - COND ist eine Bedingung.
	cgbiwrcond schreibt die Bedingung in die Datei *pf.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/
/*H
	Version 1	02.12.1992	Th. Weis
   DATE cgbiwrcond    : 930531
H*/

/* #include <_pol2.h> */

single cgbiwrcond(r1,r2,VL1,VL2,COND,pf)
single r1,r2;
list   VL1,VL2,COND;
FILE   *pf;
{
  single err=0;
  list	 C_88_A,COND0,COND1;

  bind(VL1,VL2,COND);
  init(C_88_A,COND0,COND1);
/*
 * Ausgabe - Anfang
 */
  if ( fprintf(pf,"\ncondition:") != 0 )  return(ERROR);
  if (COND == _0)  return(fprintf(pf,"\n{}\n"));
  COND0 = lfirst(COND);
  COND1 = lsecond(COND);
  if ( fprintf(pf,"\n{\n{ ") != 0 )  return(ERROR);
  while (COND0 != _0) {
	C_88_A = lfirst(COND0);
	COND0  = lred(COND0);
	if ( fputpi(r2,C_88_A,VL2,pf) != 0 ) { err = ERROR; break; }
	if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
  }
  if( !err && fprintf(pf,"} == 0\n{ ") != 0 )  return(ERROR);
  while (COND1 != _0) {
	C_88_A = lfirst(COND1);
	COND1  = lred(COND1);
	if ( fputpi(r2,C_88_A,VL2,pf) != 0) { err = ERROR; break; }
	if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
  }
  if ( !err )  err = fprintf(pf,"} != 0\n}\n");
/*
 * Ausgabe - Ende
 * Ruecksprung
 */
  return(err);
}



/* 47.) cgbkco */
/*c
			cgbkco( r1, r2, EL, ACOLS, pKEY, pALIST )

	"comprehensive Groebner basis, key colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbkco(r1,r2,EL,ACOLS,pKEY,pALIST)  single r1,r2; list EL,ACOLS;
	      list *pKEY,*pALIST;
	cgbkco(r1,r2,EL,ACOLS,pKEY,pALIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - EL ist ein Term;
	      - ACOLS enthaelt eine Liste von roten Termen und eine Liste
		von weissen Termen.
	Ist EL ein Listenelement der Liste mit den roten Termen in ACOLS,
	so wird pKEY gleich 1 gesetzt und pALIST ist die leere Liste.
	Ist EL ein Listenelement der Liste mit den weissen Termen in ACOLS,
	so wird pKEY gleich 2 gesetzt und pALIST ist der weisse Anteil von
	EL.
	Ist EL kein Listenelement der Listen in ACOLS (d.h. EL ist gruen),
	so wird pKEY gleich 0 gesetzt und pALIST ist die leere Liste.
c*/
/*H
	Version 1	23.11.1992	Th. Weis
   DATE cgbkco	      : 930531
H*/

/* #include <_pol2.h> */

cgbkco(r1,r2,EL,ACOLS,pKEY,pALIST)
single r1,r2;
list   EL,ACOLS;
list   *pKEY,*pALIST;
{
  list	 ACRED,ACWHIT,CP;

  bind(EL,ACOLS);
  init(ACRED,ACWHIT,CP);
/*
 * Vorbesetzen - Anfang
 */
  *pALIST = _0;
  *pKEY	  = 0;
  ACRED	  = lfirst(ACOLS);
  ACWHIT  = lsecond(ACOLS);
/*
 * Vorbesetzen - Ende
 * Farbschluessel einstellen - Anfang
 */
  if ( lmemb(EL,ACRED) == 1 )  *pKEY = 1;
  else {
       CP = cgbfwf(r1,r2,EL,ACWHIT);
       if ( CP != _0 ) {
	  *pKEY	  = 2;
	  *pALIST = lsecond(CP);
       }
  }
/*
 * Farbschluessel einstellen - Ende
 * Ruecksprung
 */
  return;
}



/* 48.) cgbmco */
/*c
		cgbmco( r1, r2, ALIST, EL, COLR, COLW, pCRED, pCWHITE )
	"comprehensive Groebner basis, make colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbmco(r1,r2,ALIST,EL,COLR,COLW,pCRED,pCWHITE)	single r1,r2;
	      list ALIST,EL,COLR,COLW; list *pCRED,*pCWHITE;
	cgbmco(r1,r2,ALIST,EL,COLR,COLW,pCRED,pCWHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ALIST ist eine Liste von Koeffizienten;
	      - EL ist ein Term;
	      - COLR ist eine Liste von roten Termen;
	      - COLW ist eine Liste von weissen Termen.
	Ist ALIST die leere Liste, so wird in pCRED COLR zusammen mit EL
	abgelegt.
	Ist ALIST nicht leer, so wird in pCWHITE COLW zusammen mit dem
	Paar, das von EL und ALIST gebildet wird, abgelegt.
c*/
/*H
	Version 1	23.11.1992	Th. Weis
   DATE cgbmco	      : 930531
H*/

/* #include <_pol2.h> */

cgbmco(r1,r2,ALIST,EL,COLR,COLW,pCRED,pCWHITE)
single r1,r2;
list   ALIST,EL,COLR,COLW;
list   *pCRED,*pCWHITE;
{
  list CP;

  bind(ALIST,EL,COLR,COLW);
  init(CP);
/*
 * Vorbesetzen - Anfang
 */
  *pCRED   = COLR;
  *pCWHITE = COLW;
/*
 * Vorbesetzen - Ende
 * ALIST ueberpruefen - Anfang
 */
  if ( ALIST == _0 )  *pCRED = lcomp(EL,*pCRED);
  else {
       CP	= list2(EL,ALIST);
       *pCWHITE = lcomp(CP,*pCWHITE);
  }
/*
 * ALIST ueberpruefen - Ende
 * Ruecksprung
 */
  return;
}



/* 49.) cgbminpl */
/*c
			cgbminpl( r1, r2, PP, PCO )

	"comprehensive Groebner basis, minimize polynomial list"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbminpl(r1,r2,PP,PCO)	single r1,r2; list PP,PCO;
	P = cgbminpl(r1,r2,PP,PCO);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PP ist eine Liste von gefaerbten Polynomen;
	      - PCO ist ein gefaerbtes Polynom.
	P ist eine Liste von PCO und den Polynomen in PP, die
	bzgl. der Faerbung ein fuehrendes Monom besitzen, das
	nicht vom fuehrenden Monom von PCO geteilt wird.
c*/
/*H
	Version 1	21.12.1992	Th. Weis
   DATE cgbminpl      : 930531
H*/

/* #include <_pol2.h> */

list cgbminpl(r1,r2,PP,PCO)
single r1,r2;
list   PP,PCO;
{
  list COL,COL2,EI,EJ,P,PCI,PS;

  bind(PP,PCO);
  init(COL,COL2,EI,EJ,P,PCI,PS);
/*
 * Vorbesetzen - Anfang
 */
  P   = _0;
  PS  = PP;
/*
 * Vorbesetzen - Ende
 * Bestimme fuehrendes Monom von PCO - Anfang
 */
  COL = lsecond(PCO);
  EI  = cgbhtt(r1,r2,COL);
/*
 * Bestimme fuehrendes Monom von PCO - Ende
 * Vergleiche mit fuehrenden Monomen in PP - Anfang
 */
  while ( PS != _0 ) {
	PCI  = lfirst(PS);
	PS   = lred(PS);
	COL2 = lsecond(PCI);
	EJ   = cgbhtt(r1,r2,COL2);
	if ( dipevmt(r1,EJ,EI) == 0 )  P = lcomp(PCI,P);
  }
/*
 * Vergleiche mit fuehrenden Monomen in PP - Ende
 * Erstelle P - Anfang
 */
  P = lcomp(PCO,P);
  P = linv(P);
/*
 * Erstelle P - Ende
 * Rueckgabe
 */
  return(P);
}



/* 50.) cgbmkcgb */
/*c
			cgbmkcgb( r1, r2, PL, pX, pI )

	"comprehensive Groebner basis, make comprehensive Groebner basis"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbmkcgb(r1,r2,PL,pX,pI)  single r1,r2; list PL; list *pX;
		int *pI; 
	cgbmkcgb(r1,r2,PL,pX,pI);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PL ist ein Groebner System.
	pX ist die parametrische Groebner Basis von PL. pI ist die Anzahl
	der Bedinigungen in PL.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbmkcgb      : 930531
H*/

/* #include <_pol2.h> */

cgbmkcgb(r1,r2,PL,pX,pI)
single r1,r2;
list   PL;
list   *pX;
int    *pI;
{
/*
 * Fall: PL = {} - Anfang
 */
  *pX = _0;
  *pI = 0;
  if ( PL == _0 )  return;
/*
 * Fall: PL = {} - Ende
 * Fall: PL != {}
 */
  {
    list J1Y,PCO,PELEM,PLIST,PPL;

    bind(PL);
    init(J1Y,PCO,PELEM,PLIST,PPL);
/*
 * Vorbesetzen - Anfang
 */
    PPL	  = PL;
    PELEM = lfirst(PPL);
    PPL	  = lred(PPL);
    PLIST = lsecond(PELEM);
/*
 * Vorbesetzen - Ende
 * Erste Groebner Basis zur Bearbeitung bereitstellen - Anfang
 */
    while ( PLIST != _0 ) {
	  PCO	= lfirst(PLIST);
	  PLIST = lred(PLIST);
	  J1Y	= lfirst(PCO);
	  *pX	= lcomp(J1Y,*pX);
    }
    *pI = 1;
/*
 * Erste Groebner Basis zur Bearbeitung bereitstellen - Ende
 * Andere Basen zur Bearbeitung bereitstellen - Anfang
 */
    while ( PPL != _0 ) {
	  PELEM = lfirst(PPL);
	  PPL	= lred(PPL);
	  PLIST = lsecond(PELEM);
	  *pX	= cgbadptcgb(r1,r2,PLIST,*pX);
	  *pI	= *pI+1;
    }
/*
 * Andere Basen zur Bearbeitung bereitstellen - Ende
 * Vereinigung bilden - Anfang
 */
    if ( *pX != _0 ) {
       *pX = diplpm(r1,*pX);
       *pX = linv(*pX);
    }
/*
 * Vereinigung bilden - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 51.) cgbmkn0 */
/*c
		cgbmkn0( r1, r2, NN0, P, PAIRS, pPPLIST )

	"comprehensive Groebner basis, make n0"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbmkn0(r1,r2,NN0,P,PAIRS,pPPLIST)  single r1,r2;
	       list NN0,P,PAIRS; list *pPPLIST;
	cgbmkn0(r1,r2,NN0,P,PAIRS,pPPLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - NN0 ist eine Liste von Tripel der Form:
		( GA, PCO, C ), wobei
		- GA eine Bedingung ist,
		- PCO eine Normalform ist, die durch GA bestimmt und
		  komplett gruen gefaerbt wird,
		- C ein multiplikativer Faktor ist;
	      - P ist eine Liste von gefaerbten Polynomen;
	      - PAIRS ist die Polynompaarliste von P.
	pPPLIST ist eine Liste der Form:
	( COND1, P1, PAIRS1, ..., CONDn, Pn, PAIRSn ), konstruiert
	aus den Informationen der Liste NN0.
c*/
/*H
	Version 1	21.12.1992	Th. Weis
   DATE cgbmkn0	      : 930531
H*/

/* #include <_pol2.h> */

cgbmkn0(r1,r2,NN0,P,PAIRS,pPPLIST)
single r1,r2;
list   NN0,P,PAIRS;
list   *pPPLIST;
{
  list C,N0,NPCOND,PCO;

  bind(NN0,P,PAIRS);
  init(C,N0,NPCOND,PCO);
/*
 * Vorbesetzen - Anfang
 */
  *pPPLIST = _0;
  N0	   = NN0;
/*
 * Vorbesetzen - Ende
 * *pPPLIST zusammenstellen - Anfang
 */
  while ( N0 != _0 ) {
	NPCOND	 = lfirst(N0);
	N0	 = lred(N0);
	PCO	 = lfirst(N0);
	N0	 = lred(N0);
	C	 = lfirst(N0);
	N0	 = lred(N0);
	*pPPLIST = lcomp3(NPCOND,P,PAIRS,*pPPLIST);
  }
/*
 * *pPPLIST zusammenstellen - Ende
 * Ruecksprung
 */
  return;
}



/* 52.) cgbmknp */
/*c
		       cgbmknp( r1, r2, P, POL, PRS )

	"comprehensive Groebner basis, make new pairs"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbmknp(r1,r2,P,POL,PRS)  single r1,r2; list P,POL,PRS;
	PPAIRS = cgbmknp(r1,r2,P,POL,PRS);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - P ist eine Liste von gefaerbten Polynomen;
	      - POL ist ein gefaerbtes Polynom;
	      - PRS ist die Polynompaarliste von P.
	Die neuen Paare zwischen POL und P werden erzeugt und zu PRS
	hinzugefuegt. In PPAIRS steht das Resultat.
c*/
/*H
	Version 1	22.12.1992	Th. Weis
   DATE cgbmknp	      : 930531
H*/

/* #include <_pol2.h> */

list cgbmknp(r1,r2,P,POL,PRS)
single r1,r2;
list   P,POL,PRS;
{
  list COL1,COL2,DL,EL,ELI,ELJ,PAIRS,PLI,PP,PPAIRS;

  bind(P,POL,PRS);
  init(COL1,COL2,DL,EL,ELI,ELJ,PAIRS,PLI,PP,PPAIRS);
/*
 * Vorbesetzen - Anfang
 */
  PP	 = P;
  PPAIRS = _0;
  PAIRS	 = PRS;
/*
 * Vorbesetzen - Ende
 * Paarliste auf neuesten Stand bringen - Anfang
 */
  COL1	 = lsecond(POL);
  ELI	 = cgbhtt(r1,r2,COL1);
  while ( PP != _0 ) {
	PLI  = lfirst(PP);
	PP   = lred(PP);
	COL2 = lsecond(PLI);
	ELJ  = cgbhtt(r1,r2,COL2);
	if ( ELJ != _0 ) {
	   EL	  = dipevlcm(r1,ELI,ELJ);
	   DL	  = list3(EL,POL,PLI);
	   PPAIRS = lcomp(DL,PPAIRS);
	}
  }
/*
 * Paarliste auf neuesten Stand bringen - Ende
 * Kopieren und Vereinigen - Anfang
 */
  PPAIRS = dipevplso(r1,PPAIRS);
  if ( PAIRS != _0 ) {
     PAIRS  = cgbpairscp(r1,r2,PAIRS);
     PPAIRS = dipevplm(r1,PAIRS,PPAIRS);
  }
/*
 * Kopieren und Vereinigen - Ende
 * Rueckgabe
 */
  return(PPAIRS);
}



/* 53.) cgbmkpair */
/*c
			cgbmkpair( r1, r2, PP, pPAIRS )

	"comprehensive Groebner basis, make pairs"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbmkpair(r1,r2,PP,pPAIRS)  single r1,r2; list PP;
		 list *pPAIRS;
	cgbmkpair(r1,r2,PP,pPAIRS);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PP ist eine Liste von gefaerbten Polynomen.
	pPAIRS ist eine Polynompaarliste, die nur aus solchen Polynomen
	besteht, deren fuehrende Monome bzgl. der Faerbung definiert
	sind. pPAIRS ist aufsteigend geordnet.
c*/
/*H
	Version 1	22.12.1992	Th. Weis
   DATE cgbmkpair     : 930531
H*/

/* #include <_pol2.h> */

cgbmkpair(r1,r2,PP,pPAIRS)
single r1,r2;
list   PP;
list   *pPAIRS;
{
/*
 * Fall: PP = {} oder PP = {PCO} - Anfang
 */
  *pPAIRS = _0;
  if ( PP == _0 || lred(PP) == _0 )  return;
/*
 * Fall: PP = {} oder PP = {PCO} - Ende
 * Fall: PP != {} und |PP| >= 2
 */
  {
    list COL1,COL2,DL,EL,ELI,ELJ,PIN,PJ,PSS,Q,QP;

    bind(PP);
    init(COL1,COL2,DL,EL,ELI,ELJ,PIN,PJ,PSS,Q,QP);
/*
 * Konstruiere Paare - Anfang
 */
    PSS = PP;
    do {
       PIN   = lfirst(PSS);
       QP   = lred(PSS);
       COL1 = lsecond(PIN);
       ELI  = cgbhtt(r1,r2,COL1);
       if ( ELI != _0 ) {
	  while ( QP != _0 ) {
		PJ   = lfirst(QP);
		QP   = lred(QP);
		COL2 = lsecond(PJ);
		ELJ  = cgbhtt(r1,r2,COL2);
		if ( ELJ != _0 ) {
		   EL	   = dipevlcm(r1,ELI,ELJ);
		   DL	   = list3(EL,PIN,PJ);
		   *pPAIRS = lcomp(DL,*pPAIRS);
		   Q	   = lcomp(PJ,Q);
		}
	  }
       }
       PSS = lred(PSS);
    } while ( PSS != _0 );
/*
 * Konstruiere Paare - Ende
 * Sortieren - Anfang
 */
    if ( *pPAIRS != _0 )  *pPAIRS = dipevplso(r1,*pPAIRS);
/*
 * Sortieren - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 54.) cgbmpwogm */
/*c
			cgbmpwogm( r1, r2, PCO )

	"comprehensive Groebner basis, make polynomial without green
	 monomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	pol cgbmpwogm(r1,r2,PCO)  single r1,r2; pol PCO;
	PPOL = cgbmpwogm(r1,r2,PCO);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PCO ist ein gefaerbtes Polynom in r1 Variablen.
	PPOL ist PCO ohne gruen gefaerbte Monome. Ist PCO komplett gruen
	gefaerbt, so ist P = 0.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbmpwogm     : 930531
H*/

/* #include <_pol2.h> */

pol cgbmpwogm(r1,r2,PCO)
single r1,r2;
list   PCO;
{
  single s;
  list	 CRED,CWHITE,PCOL,POL,PPOL,RA,RE;

  bind(PCO);
  init(CRED,CWHITE,PCOL,POL,PPOL,RA,RE);
/*
 * Fall: alle Terme sind gruen gefaerbt - Anfang
 */
  POL  = lfirst(PCO);
  PCOL = lsecond(PCO);
  if ( PCOL == _0 ) {
     PPOL = 0;
	    return(PPOL);
  }
/*
 * Fall: alle Terme sind gruen gefaerbt - Ende
 * Fall: NICHT alle Terme sind gruen; konstruiere PPOL - Anfang
 */
  PPOL	 = _0;
  CRED	 = lfirst(PCOL);
  CWHITE = lsecond(PCOL);
  while ( POL != _0 ) {
	POL = dipmoad(r1,POL,&RA,&RE);
	s   = lmemb(RE,CRED);
	if ( s == 0 )  s = cgbwtm(r1,r2,RE,CWHITE);
	if ( s == 1 )  PPOL = lcomp2(RE,RA,PPOL);
  }
  if ( PPOL == _0 )  PPOL = 0;
  else	PPOL = linv(PPOL);
/*
 * Fall: NICHT alle Terme sind gruen; konstruiere PPOL - Ende
 * Rueckgabe
 */
  return(PPOL);
}



/* 55.) cgbpairscp */
/*c
			cgbpairscp( r1, r2, PAIRS )

	"comprehensive Groebner basis, pairs copy"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbpairscp(r1,r2,PAIRS)  single r1,r2; list PAIRS;
	PPAIRS = cgbpairscp(r1,r2,PAIRS);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PAIRS ist eine Polynompaarliste.
	PPAIRS ist eine Kopie der Liste PAIRS.
c*/
/*H
	Version 1	22.12.1992	Th. Weis
   DATE cgbpairscp    : 930531
H*/

/* #include <_pol2.h> */

list cgbpairscp(r1,r2,PAIRS)
single r1,r2;
list   PAIRS;
{
/*
 * Fall: PAIRS = {} - Anfang
 */
  if ( PAIRS == _0 )  return(_0);
/*
 * Fall: PAIRS = {} - Ende
 * Fall: PAIRS != {}
 */
  {
    list PAIR,PPAIRS,PRS;

    bind(PAIRS);
    init(PAIR,PPAIRS,PRS);
/*
 * Vorbesetzen - Anfang
 */
    PPAIRS = _0;
    PRS	   = PAIRS;
/*
 * Vorbesetzen - Ende
 * Kopieren - Anfang
 */
    while ( PRS != _0 ) {
	  PAIR	 = lfirst(PRS);
	  PRS	 = lred(PRS);
	  PPAIRS = lcomp(PAIR,PPAIRS);
    }
    PPAIRS = linv(PPAIRS);
/*
 * Kopieren - Ende
 * Rueckgabe
 */
    return(PPAIRS);
  }
}



/* 56.) cgbredfpol */
/*c
			cgbredfpol( r1, r2, PCO, P, pPLI, pRE )

	"comprehensive Groebner basis, reduction find polynomial"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbredfpol(r1,r2,PCO,P,pPLI,pRE)  single r1,r2; list PCO,P;
		  list *pPLI,*pRE;
	cgbredfpol(r1,r2,PCO,P,pPLI,pRE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - PCO ist ein gefaerbtes Polynom;
	      - P ist ein bestimmtes und gefaerbtes Polynom.
	Es wird ein Polynom in P gesucht bzgl. dem PCO reduziert
	werden kann.
	pPLI ist leer, wenn kein Polynom gefunden wurde. Andernfalls
	ist pPLI die Liste der gefundenen Polynome und pRE ist der
	Term von PCO, der geloescht wurde.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbredfpol    : 930531
H*/

/* #include <_pol2.h> */

cgbredfpol(r1,r2,PCO,P,pPLI,pRE)
single r1,r2;
list   PCO,P;
list   *pPLI,*pRE;
{
/*
 * Fall: PCO oder P = {} - Anfang
 */
  *pPLI = _0;
  *pRE	= _0;
  if ( PCO == _0 || P == _0 )  return;
/*
 * Fall: PCO oder P = {} - Ende
 * Fall: PCO und P != {}
 */
  {
    single s,t;
    list   ALIST,COL,COL2,HE,HT,KEY,PCI,PIN,POL,PP,RA;

    bind(PCO,P);
    init(ALIST,COL,COL2,HE,HT,KEY,PCI,PIN,POL,PP,RA);
/*
 * Bestimme fuehrendes Monom von PCO - Anfang
 */
    s	= 0;
    POL = lfirst(PCO);
    COL = lsecond(PCO);
    HT	= cgbhtt(r1,r2,COL);
/*
 * Bestimme fuehrendes Monom von PCO - Ende
 * Finde Polynome zur Reduktion - Anfang
 */
    while ( POL != _0 && s == 0 ) {
	  POL = dipmoad(r1,POL,&RA,pRE);
	  PP  = P;
	  t   = oequal(HT,*pRE);
		cgbkco(r1,r2,*pRE,COL,&KEY,&ALIST);
	  if ( KEY != 0 && t == 0 ) {
	     do {
		PCI  = lfirst(PP);
		PP   = lred(PP);
		PIN   = lfirst(PCI);
		COL2 = lsecond(PCI);
		HE   = cgbhtt(r1,r2,COL2);
		if ( HE != _0 )	 s = dipevmt(r1,*pRE,HE);
	     } while ( s != 1 && PP != _0 );
	  }
    }
    if ( s == 1 )  *pPLI = PCI;
/*
 * Finde Polynome zur Reduktion - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 57.) cgbremgt */
/*c
		       cgbremgt( r1, r2, COND, PP )

	"comprehensive Groebner basis, remove green terms"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbremgt(r1,r2,COND,PP)  single r1,r2; list COND,PP;
	P = cgbremgt(r1,r2,COND,PP);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - PP ist eine bzgl. COND und gefaerbte Polynomliste.
	Wenn COND Koeffizienten enthaelt, die Null sind, werden alle
	gruenen Monome der Polynome in PP geloescht. P ist die Er-
	gebnisliste.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbremgt      : 930531
H*/

/* #include <_pol2.h> */

list cgbremgt(r1,r2,COND,PP)
single r1,r2;
list   COND,PP;
{
/*
 * Fall: PP = {} - Anfang
 */
  if ( COND == _0 )  return(PP);
/*
 * Fall: PP = {} - Ende
 * Fall: PP != {}
 */
  {
    list COL,COND0,COND1,P,PCO,PPCO,PPOL,X;

    bind(COND,PP);
    init(COL,COND0,COND1,P,PCO,PPCO,PPOL,X);
/*
 * Ueberpruefe Bedingung - Anfang
 */
    P	  = PP;
    COND0 = lfirst(COND);
    COND1 = lsecond(COND);
    if ( COND0 == _0 )	return(P);
    X = PP;
    P = _0;
/*
 * Ueberpruefe Bedingung - Ende
 * Loesche gruene Monome - Anfang
 */
    while ( X != _0 ) {
	  PCO  = lfirst(X);
	  X    = lred(X);
	  COL  = lsecond(PCO);
	  PPOL = cgbmpwogm(r1,r2,PCO);
	  if ( COL != _0 ) {
	     PPCO = list2(PPOL,COL);
	     P	  = lcomp(PPCO,P);
	  }
    }
    P = linv(P);
/*
 * Loesche gruene Monome - Ende
 * Rueckgabe
 */
    return(P);
  }
}



/* 58.) cgbrep */
/*c
			cgbrep( r1, r2, P )

	"comprehensive Groebner basis, remove extraneous polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbrep(r1,r2,P)  single r1,r2; list P;
	PP = cgbrep(r1,r2,P);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - P ist eine Liste gefaerbter Polynome.
	Bzgl. ihrer Faerbung fremde Polynome werden in P geloescht. Das
	Ergebnis steht in PP.
c*/
/*H
	Version 1	28.12.1992	Th. Weis
   DATE cgbrep	      : 930531
H*/

/* #include <_pol2.h> */

list cgbrep(r1,r2,P)
single r1,r2;
list   P;
{
/*
 * Fall: P = {} - Anfang
 */
  if ( P == _0 || lred(P) == _0 )  return(P);
/*
 * Fall: P = {} - Ende
 * Fall: P != {}
 */
  {
    single t;
    list   COL1,COL2,EI,EJ,PB,PCI,PCO,PP,PS,QP;

    bind(P);
    init(COL1,COL2,EI,EJ,PB,PCI,PCO,PP,PS,QP);
/*
 * Vorbesetzen - Anfang
 */
    PP = P;
    PS = PP;
    QP = _0;
/*
 * Vorbesetzen - Ende
 * Fremde Polynome loeschen - Anfang
 */
    do {
       PCO  = lfirst(PS);
       PS   = lred(PS);
       COL1 = lsecond(PCO);
       EI   = cgbhtt(r1,r2,COL1);
       if ( EI != _0 ) {
	  PB = PS;
	  t  = 0;
	  while ( PB != _0 && t == 0 ) {
		PCI  = lfirst(PB);
		PB   = lred(PB);
		COL2 = lsecond(PCI);
		EJ   = cgbhtt(r1,r2,COL2);
		if ( EJ != _0 )	 t = dipevmt(r1,EI,EJ);
	  }
	  PB = QP;
	  while ( PB != _0 && t == 0 ) {
		PCI  = lfirst(PB);
		PB   = lred(PB);
		COL2 = lsecond(PCI);
		EJ   = cgbhtt(r1,r2,COL2);
		t    = dipevmt(r1,EI,EJ);
	  }
	  if ( t == 0 )	 QP = lcomp(PCO,QP);
       }
    } while ( PS != _0 );
    PP = linv(QP);
/*
 * Fremde Polynome loeschen - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/* 59.) cgbrts */
/*c
			cgbrts( r1, r2, RALT, RNEU )

	"comprehensive Groebner basis, red terms sort"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbrts(r1,r2,RALT,RNEU)  single r1,r2; list RALT,RNEU;
	CRED0 = cgbrts(r1,r2,RALT,RNEU);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - RALT  und  RNEU	 sind Listen von Termen in aufsteigender
		Ordnung.
	CRED0 enthaelt die Terme von RALT und RNEU in aufsteigender
	Ordnung.
c*/
/*H
	Version 1	05.11.1992	Th. Weis
   DATE cgbrts	      : 930531
H*/

/* #include <_pol2.h> */

list cgbrts(r1,r2,RALT,RNEU)
single r1,r2;
list   RALT,RNEU;
{
  single s;
  list	 CCR,CRED,CRED0,CRED1,CREDP,T,T1;

  bind(RALT,RNEU);
  init(CCR,CRED,CRED0,CRED1,CREDP,T,T1);
/*
 * Vorbesetzen - Anfang
 */
  CRED	= RALT;
  CRED1 = RNEU;
  CRED0 = _0;
/*
 * Vorbesetzen - Ende
 * SORTIEREN - Anfang
 */
  do {
     T1	   = lfirst(CRED1);
     CRED1 = lred(CRED1);
     do {
	T     = lfirst(CRED);
	CREDP = lred(CRED);
	s     = dipevcomp(r1,T1,T);
	if ( s == 1 )  CRED0 = lcomp(T1,CRED0);
	else {
	     CRED0 = lcomp(T,CRED0);
	     CRED  = CREDP;
	}
     } while ( s != 1 && CRED != _0 );
     if ( s <= 0 )  CRED0 = lcomp(T1,CRED0);
  } while ( CRED1 != _0 && CRED != _0 );
/*
 * SORTIEREN - Ende
 * Schluss
 */
  if ( CRED == _0 && CRED1 == _0 ) {
     CRED0 = linv(CRED0);
	     return(CRED0);
  }
  if ( CRED != _0 )  CCR = CRED;
  else	CCR = CRED1;
  while ( CCR != _0 ) {
	T     = lfirst(CCR);
	CCR   = lred(CCR);
	CRED0 = lcomp(T,CRED0);
  }	   
  CRED0 = linv(CRED0);
/*
 * Rueckgabe
 */
  return(CRED0);
}



/* 60.) cgbscol */
/*c
			cgbscol( r1, r2, COND, COL )

	"comprehensive Groebner basis, set colour"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbscol(r1,r2,COND,COL)  single r1,r2; list COND,COL;
	COLS = cgbscol(r1,r2,COND,COL);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - COL ist eine Liste von roten und weissen Termen bzgl. einer
		anderen Bedingung (als COND), so dass COND ein Nachfolger
		dieser (anderen) Bedingung ist.
	COLS ist eine Liste von roten und weissen Termen bzgl. COND.
	(COL wird bzgl. COND auf den neuesten Stand gebracht.)
c*/
/*H
	Version 1	05.11.1992	Th. Weis
   DATE cgbscol	      : 930531
H*/

/* #include <_pol2.h> */

list cgbscol(r1,r2,COND,COL)
single r1,r2;
list   COND,COL;
{
/*
 * Fall: COND = {}  oder  COL = {}  - Anfang
 */
  if ( COND == _0 || COL == _0 )  return(COL);
/*
 * Fall: COND = {}  oder  COL = {}  - Ende
 * Fall: COND != {}  und  COL != {}  - Anfang
 */
  {
    single c,t;
    list   A,ALIST,COLS,CP,CRED,CRED1,CWHIT1,CWHITE,PACK,T,WFACTS;
    list   COND0,COND1;
    obj	   pC;

    bind(COND,COL);
    init(A,ALIST,COLS,CP,CRED,CRED1,CWHIT1,CWHITE,PACK,T,WFACTS);
    init(COND0,COND1);
    init(pC);
/*
 * Vorbesetzen - Ende
 */
    CRED   = lfirst(COL);
    CWHITE = lsecond(COL);
    if ( CWHITE == _0 )	 return(COL);
    CRED1  = _0;
    CWHIT1 = _0;
    t	   = 0;
    COND0  = lfirst(COND);
    COND1  = lsecond(COND);
/*
 * Vorbesetzen - Ende
 * COL auf den neuesten Stand bringen - Anfang
 */
    while ( CWHITE != _0 ) {
	  CP	 = lfirst(CWHITE);
	  CWHITE = lred(CWHITE);
	  T	 = lfirst(CP);
	  ALIST	 = lsecond(CP);
	  WFACTS = _0;
	  c	 = 0;
	  do {
	     A	   = lfirst(ALIST);
	     ALIST = lred(ALIST);
	     if ( ispconst(r2,A,&pC) == 0 ) {
		if ( lmemb(A,COND0) == 1 )  c = 1;
		else  if ( lmemb(A,COND1) == 0 )  WFACTS = lcomp(A,WFACTS);
	     }
	  } while ( c != 1 && ALIST != _0 );
	  if ( c == 1 )	 t = 1;
	  if ( c == 0 ) {
	     if ( WFACTS == _0 )  CRED1 = lcomp(T,CRED1);
	     else {
		  PACK	 = list2(T,WFACTS);
		  CWHIT1 = lcomp(PACK,CWHIT1);
	     }
	  }
    }
/*
 * Keine Aenderung der Faerbung
 */
    if ( t == 0 && CRED1 == _0 )  return(COL);
    if ( CWHIT1 != _0 )	 CWHIT1 = linv(CWHIT1);
    if ( CRED1 != _0 )	CRED1 = linv(CRED1);
/*
 * Ordnung der roten Terme erneuern
 */
    if ( CRED1 != _0 ) {
       if ( CRED == _0 )  CRED = CRED1;
       else  CRED = cgbrts(r1,r2,CRED,CRED1);
    }	   
    if ( CRED == _0 && CWHIT1 == _0 )  COLS = _0;
    else  COLS = list2(CRED,CWHIT1);
/*
 * COL auf den neuesten Stand bringen - Ende
 * Rueckgabe
 */
    return(COLS);
  }
}



/* 61.) cgbscon */
/*c
			cgbscon( r1, r2, CONDA, CONS, b )

	"comprehensive Groebner basis, search condition"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbscon(r1,r2,CONDA,CONS,b)  single r1,r2; list CONDA,CONS;
	     single b;
	CC = cgbscon(r1,r2,CONDA,CONS,b);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - CONDA ist eine Liste von Koeffizienten;
	      - CONS ist eine Liste von Bedingungen;
	      - b = 0  oder  b = 1.
	Ist b = 0, dann enthaelt CC alle Koeffizienten, die in CONDA und
	in der Nulliste einer jeden Bedingung in CONS sind.
	Ist b = 1, dann enthaelt CC alle Koeffizienten, die in CONDA und
	in der Nichtnulliste einer jeden Bedingung in CONS sind.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbscon	      : 930531
H*/

/* #include <_pol2.h> */

list cgbscon(r1,r2,CONDA,CONS,b)
single r1,r2;
list   CONDA,CONS;
single b;
{
  single s;
  list	 A,CC,COND,COND0,COND1,CONDS,X;

  bind(CONDA,CONS);
  init(A,CC,COND,COND0,COND1,CONDS,X);
/*
 * Vorbesetzen - Anfang
 */
  X  = CONDA;
  CC = _0;
/*
 * Vorbesetzen - Ende
 * SUCHE - Anfang
 */
  while ( X != _0 ) {
	A     = lfirst(X);
	X     = lred(X);
	CONDS = CONS;
	do {
	   COND	 = lfirst(CONDS);
	   CONDS = lred(CONDS);
	   COND0 = lfirst(COND);
	   COND1 = lsecond(COND);
	   if ( b == 0 )  s = lmemb(A,COND0);
	   else	 s = lmemb(A,COND1);
	} while ( s != 0 && CONDS != _0 );
	if ( s == 1 )  CC = lcomp(A,CC);
  }
/*
 * SUCHE - Ende
 * Rueckgabe
 */
  return(CC);
}



/* 62.) cgbtht */
/*c
		       cgbtht( r1, r2, COL, pCP )

	"comprehensive Groebner basis, test highest term"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	cgbtht(r1,r2,COL,pCP)  single r1,r2; list COL; list *pCP;
	cgbtht(r1,r2,COL,pCP);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - COL enthaelt eine Liste von roten Termen und eine Liste
		von weissen Termen.
	pCP enthaelt den hoechsten weissen Term, wenn dieser groesser
	als der hoechste rote Term ist, sonst ist pCP die leere Liste.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
   DATE cgbtht	      : 930531
H*/

/* #include <_pol2.h> */

cgbtht(r1,r2,COL,pCP)
single r1,r2;
list   COL;
list   *pCP;
{
/*
 * Fall: COL = {}  - Anfang
 */
  *pCP = _0;
  if ( COL == _0 )  return;
/*
 * Fall: COL = {}  - Ende
 * Fall: COL != {}
 */
  {
    list CE,CRED,CWHITE,RE;

    bind(COL);
    init(CE,CRED,CWHITE,RE);
/*
 * Vorbesetzen - Anfang
 */
    CRED   = lfirst(COL);
    CWHITE = lsecond(COL);
/*
 * Vorbesetzen - Ende
 * Fall: keine roten oder keine weissen Terme - Anfang
 */
    if ( CWHITE == _0 )	 return;
    if ( CRED == _0 ) {
       *pCP = lfirst(CWHITE);
	      return;
    }
/*
 * Fall: keine roten oder keine weissen Terme - Ende
 * VERGLEICHEN - Anfang
 */
    *pCP = lfirst(CWHITE);
    CE	 = lfirst(*pCP);
    RE	 = lfirst(CRED);
    if ( dipevcomp(r1,CE,RE) <= 0 )  *pCP = _0;
/*
 * VERGLEICHEN - Ende
 * Ruecksprung
 */
    return;
  }
}



/* 63.) cgbucd */
/*c
			cgbucd( r1, r2, ALIST, DALT, b )

	"comprehensive Groebner basis, update case distinction"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbucd(r1,r2,ALIST,DALT,b)	 single r1,r2; list ALIST,DALT;
	     single b;
	DNEU = cgbucd(r1,r2,ALIST,DALT,b);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ALIST ist eine Liste von Koeffizienten ( A1, ..., An ),
		wobei die Ai Polynome sind;
	      - DALT ist eine Fallunterscheidung;
	      - b = 0  oder  b = 1.
	Ist b = 0, so ist DNEU eine Fallunterscheidung, die DALT und
	( A1 = 0, ..., An = 0 ) enthaelt.
	Ist b = 1, so ist DNEU eine Fallunterscheidung, die DALT und
	( A1 != 0, ..., An != 0 ) enthaelt.
	cgbadcon berechnet eine vollstaendige Fallunterscheidung, die
	DALT und ( A1, ..., An ) enthaelt. Dann werden Bedingungen
	zusammengesetzt.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbucd	      : 930531
H*/

/* #include <_pol2.h> */

list cgbucd(r1,r2,ALIST,DALT,b)
single r1,r2;
list   ALIST,DALT;
single b;
{
/*
 * Fall: ALIST = {}  - Anfang
 */
  if ( ALIST == _0 )  return(DALT);
/*
 * Fall: ALIST = {}  - Ende
 * Fall: ALIST != {}
 */
  {
    single s;
    list   A,CNEU,CON,COND0,COND1,D,DNEU,HELP,X,XCOND;

    bind(ALIST,DALT);
    init(A,CNEU,CON,COND0,COND1,D,DNEU,HELP,X,XCOND);
/*
 * Fall: DALT = {}  - Anfang
 */
    DNEU = _0;
    if ( DALT == _0 ) {
       cgbadcon(r1,r2,ALIST,_0,_0,1,&X,&CNEU);
       while ( X != _0 ) {
	     XCOND = lfirst(X);
	     X	   = lred(X);
	     COND0 = lfirst(XCOND);
	     COND1 = lsecond(XCOND);
	     if ( COND0 != _0 && b == 0 )  DNEU = lcomp(XCOND,DNEU);
	     else {
		  if ( COND0 == _0 && b == 1 )	DNEU = lcomp(XCOND,DNEU);
	     }
       }
       return(DNEU);
    }
/*
 * Fall: DALT = {}  - Ende
 * Fall: DALT != {}  - Anfang
 */
    D = DALT;
    while ( D != _0 ) {
	  CON = lfirst(D);
	  D   = lred(D);
		cgbadcon(r1,r2,ALIST,CON,_0,1,&X,&CNEU);
	  while ( X != _0 ) {
		XCOND = lfirst(X);
		X     = lred(X);
		HELP  = ALIST;
		COND0 = lfirst(XCOND);
		COND1 = lsecond(XCOND);
		do {
		   A	= lfirst(HELP);
		   HELP = lred(HELP);
		   s	= lmemb(A,COND0);
		} while ( s != 1 && HELP != _0 );
		if ( s == 1 && b == 0 )	 DNEU = lcomp(XCOND,DNEU);
		if ( s == 0 && b == 1 )	 DNEU = lcomp(XCOND,DNEU);
	  }
    }
/*
 * Fall: DALT != {}  - Ende
 * Fehlermeldung, wenn DNEU = {}  - Anfang
 */
    if ( DNEU == _0 ) {
       fprintf(stderr,"\n\n !! Fehler in cgbucd: DNEU = {} !!\n\n");
       return(DNEU);
    }
/*
 * Fehlermeldung, wenn DNEU = {}  - Ende
 * Rueckgabe
 */
    return(DNEU);
  }
}



/* 64.) cgbuppol */
/*c
			cgbuppol( r1, r2, COND, P )

	"comprehensive Groebner basis, update polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbuppol(r1,r2,COND,P)  single r1,r2; list COND,P;
	PP = cgbuppol(r1,r2,COND,P);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COND ist eine Bedingung;
	      - P ist eine bzgl. des Vorgaengers von COND bestimmte
		und gefaerbte Polynomliste.
	Die Faerbung eines jeden Polynoms der Liste wird bzgl. COND
	auf den neuesten Stand gebracht. In PP steht das Resultat.
c*/
/*H
	Version 1	22.12.1992	Th. Weis
   DATE cgbuppol      : 930531
H*/

/* #include <_pol2.h> */

list cgbuppol(r1,r2,COND,P)
single r1,r2;
list   COND,P;
{
/*
 * Fall: P = {} - Anfang
 */
  if ( P == _0 )  return(_0);
/*
 * Fall: P = {} - Ende
 * Fall: P != {}
 */
  {
    list COL,PCO,PELEM,POL,PP,PPP;

    bind(COND,P);
    init(COL,PCO,PELEM,POL,PP,PPP);
/*
 * Vorbesetzen - Anfang
 */
    PP	= _0;
    PPP = P;
/*
 * Vorbesetzen - Ende
 * P auf den neuesten Stand bringen - Anfang
 */
    while ( PPP != _0 ) {
	  PCO	= lfirst(PPP);
	  PPP	= lred(PPP);
	  POL	= lfirst(PCO);
	  COL	= lsecond(PCO);
	  COL	= cgbscol(r1,r2,COND,COL);
	  PELEM = list2(POL,COL);
	  PP	= lcomp(PELEM,PP);
    }
    PP = linv(PP);
/*
 * P auf den neuesten Stand bringen - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/* 65.) cgbvcap */
/*c
			cgbvcap( r1, r2, D, CLIST )

	"comprehensive Groebner basis, verify conditions and polynomials"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbvcap(r1,r2,D,CLIST)  single r1,r2; list D,CLIST;
	PPL = cgbvcap(r1,r2,D,CLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS ist die Anzahl der Parameter;
	      - D ist eine Fallunterscheidung mit den bedingungen:
		C1, ...., Cn;
	      - CLIST ist eine Liste von Paaren, wobei jedes Paar eine
		Bedingung und ein gefaerbtes Polynom enthaelt. Die
		Struktur von CLIST ist:
		( (C11,P1), ..., (Cn1,P1), (C12,P2), ..., (Cn2,P2),
		  (C1m,Pm), ..., (Cnm,Pm) ).
		P1, ..., Pm sind bzgl. Cij gefaerbte Polynome. Ci ist ein
		Nachfolger von Cij und Cim = Ci fuer i=1,...,n, j=1,...,m.
	Die Struktur von PPL ist:
	( (C1,(P11,...,P1m)), ..., (C2,(P21,...,P2m)), ...,
	  (Cn,(Pn1,...,Pnm)) ),
	wobei (Pi1, ..., Pim) eine Permutation von (P1, ..., Pm) ist, so
	dass die Polynome in aufsteigender Ordnung bzgl. der Bedingung Pi
	fuer i=1,...,n sind.
c*/
/*H
	Version 1	09.11.1992	Th. Weis
   DATE cgbvcap	      : 930531
H*/

/* #include <_pol2.h> */

list cgbvcap(r1,r2,D,CLIST)
single r1,r2;
list   D,CLIST;
{
/*
 * Fall: CLIST = {}  - Anfang
 */
  if ( CLIST == _0 )  return(_0);
/*
 * Fall: CLIST = {}  - Ende
 * Fall: CLIST != {}
 */
  {
    single s;
    list   CCOND,CCOND0,CCOND1,CLIST1;
    list   D1,DCOND,DCOND0,DCOND1;
    list   PCO,PELEM,PLIST,PPL;

    bind(D,CLIST);
    init(CCOND,CCOND0,CCOND1,CLIST1);
    init(D1,DCOND,DCOND0,DCOND1);
    init(PCO,PELEM,PLIST,PPL);
/*
 * Vorbesetzen - Anfang
 */
    PPL = _0;
/*
 * Vorbesetzen - Ende
 * Fall: D = {}	 - Anfang
 */
    if ( D == _0 ) {
       CLIST1 = CLIST;
       PLIST  = _0;
       while ( CLIST1 != _0 ) {
	     CCOND  = lfirst(CLIST1);
	     CLIST1 = lred(CLIST1);
	     PCO    = lfirst(CLIST1);
	     CLIST1 = lred(CLIST1);
	     PLIST  = lcomp(PCO,PLIST);
       }
       PLIST = cgbdiplpm(r1,r2,PLIST);
       PELEM = list2(_0,PLIST);
       PPL   = lcomp(PELEM,PPL);
	       return(PPL);
    }
/*
 * Fall: D = {}	 - Ende
 * Fall: D != {}  - Anfang
 */
    D1 = D;
    while ( D1 != _0 ) {
	  DCOND	 = lfirst(D1);
	  D1	 = lred(D1);
	  DCOND0 = lfirst(DCOND);
	  DCOND1 = lsecond(DCOND);
	  PLIST	 = _0;
	  CLIST1 = CLIST;
	  while ( CLIST1 != _0 ) {
		CCOND  = lfirst(CLIST1);
		CLIST1 = lred(CLIST1);
		PCO    = lfirst(CLIST1);
		CLIST1 = lred(CLIST1);
		if ( CCOND == _0 )  PLIST = lcomp(PCO,PLIST);
		else {
		     CCOND0 = lfirst(CCOND);
		     CCOND1 = lsecond(CCOND);
		     if ( cgbainb(r1,r2,CCOND0,DCOND0) == 1 ) {
			if ( cgbainb(r1,r2,CCOND1,DCOND1) == 1 )  PLIST = lcomp(PCO,PLIST);
		     }
	       }
	  }
	  PLIST = cgbdiplpm(r1,r2,PLIST);
	  PELEM = list2(DCOND,PLIST);
	  PPL	= lcomp(PELEM,PPL);
    }
/*
 * Fall D != {}	 - Ende
 * Rueckgabe
 */
    return(PPL);
  }
}



/* 66.) cgbwpu */
/*c
			cgbwpu( r1, r2, ALIST, BLIST )

	"comprehensive Groebner basis, white part update"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbwpu(r1,r2,ALIST,BLIST)	single r1,r2; list ALIST,BLIST;
	CLIST = cgbwpu(r1,r2,ALIST,BLIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - ALIST und BLIST sind Listen von Koeffizienten.
	CLIST ist die Liste der Koeffizienten in ALIST und in BLIST.
c*/
/*H
	Version 1	23.11.1992	Th. Weis
   DATE cgbwpu	      : 930531
H*/

/* #include <_pol2.h> */

list cgbwpu(r1,r2,ALIST,BLIST)
single r1,r2;
list   ALIST,BLIST;
{
/*
 * Fall: ALIST gleich BLIST - Anfang
 */
  if ( ALIST == BLIST )	 return(BLIST);
/*
 * Fall: ALIST gleich BLIST - Ende
 * Fall: ALIST ungleich BLIST
 */
  {
    list   A,AL,CLIST;

    bind(ALIST,BLIST);
    init(A,AL,CLIST);
/*
 * Vorbesetzen - Anfang
 */
    CLIST = BLIST;
    AL	  = ALIST;
/*
 * Vorbesetzen - Ende
 * Liste erneuern - Anfang
 */
    while ( AL != _0 ) {
	  A  = lfirst(AL);
	  AL = lred(AL);
	  if ( lmemb(A,BLIST) == 0 )  CLIST = lcomp(A,CLIST);
    }
/*
 * Liste erneuern - Ende
 * Rueckgabe
 */
    return(CLIST);
  }
}



/* 67.) cgbws */
/*c
			cgbws( r1, r2, COL, TTERM, ALIST )

	"comprehensive Groebner basis, white sort"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	list cgbws(r1,r2,COL,TTERM,ALIST)  single r1,r2;
	     list COL,TTERM,ALIST;
	COLS = cgbws(r1,r2,COL,TTERM,ALIST);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - COL ist eine Liste, die eine Liste von roten Termen und
		eine Liste von weissen Termen enthaelt;
		COL = ( (R1,...,Rn),
			( (W1,(WP11,...,WP1s)),...,(Wm,(WPm1,...,WPms)) ) )
	      - TTERM ist ein Term;
	      - ALIST ist eine Liste von Koeffizienten;
		ALIST = ( A1, ..., At ).
	Jeder Term aus COL wird mit TTERM multipliziert. Die Ergebnisterme
	werden weiss gefaerbt unter Hinzunahme von ALIST zu ihrem weissen
	Teil. Die Liste der roten Terme ist leer. Die Liste der weissen
	Terme Z sieht wie folgt aus:
	Z = ( (R1*TTERM,(A1,...,At)), ..., (Rn*TTERM,(A1,...,At)),
	      (W1*TTERM,(A1,...,At,WP11,...,WP1s)), ...,
	      (Wm*TTERM,(A1,...,At,WPm1,...,WPms)) ).
	CWHITE0 enthaelt die selben Terme wie Z in aufsteigender Ordnung.
	COLS ist ein Paar, das eine leere Liste von roten Termen enthaelt
	und die Liste CWHITE0.
c*/
/*H
	Version 1	17.11.1992	Th. Weis
   DATE cgbws	      : 930531
H*/

/* #include <_pol2.h> */

list cgbws(r1,r2,COL,TTERM,ALIST)
single r1,r2;
list   COL,TTERM,ALIST;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single s;
  list	 AL,BL,BLIST;
  list	 COLS,CP,CPR,CPW,CRED,CWHIT0,CWHITE,CWHITP;

  bind(COL,TTERM,ALIST);
  init(AL,BL,BLIST);
  init(COLS,CP,CPR,CPW,CRED,CWHIT0,CWHITE,CWHITP);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen (rote und weisse Terme bereitstellen) - Anfang
 */
  CRED	 = lfirst(COL);
  CWHITE = lsecond(COL);
  CWHIT0 = _0;
/*
 * Vorbesetzen - Ende
 * Terme verknuepfen - Anfang
 */
  if ( CWHITE != _0 ) {
     do {
	AL   = lfirst(CRED);
	CRED = lred(CRED);
	do {
	   CP	  = lfirst(CWHITE);
	   CWHITP = lred(CWHITE);
	   BL	  = lfirst(CP);
	   BLIST  = lsecond(CP);
	   s	  = dipevcomp(r1,AL,BL);
	   if ( s == 1 ) {
	      AL     = dipevsum(r1,TTERM,AL);
	      CPR    = list2(AL,ALIST);
	      CWHIT0 = lcomp(CPR,CWHIT0);
	   }
	   else {
		BL     = dipevsum(r1,TTERM,BL);
		BLIST  = cgbwpu(r1,r2,ALIST,BLIST);
		CPW    = list2(BL,BLIST);
		CWHIT0 = lcomp(CP,CWHIT0);
		CWHITE = CWHITP;
	   }
	} while ( s != 1 && CWHITE != _0 );
	if ( s <= 0 ) {
	   AL	  = dipevsum(r1,TTERM,AL);
	   CPR	  = list2(AL,ALIST);
	   CWHIT0 = lcomp(CPR,CWHIT0);
	}
     } while ( CRED != _0 && CWHITE != _0 );
  }
/*
 * Terme verknuepfen - Ende
 * Keine Terme mehr da - Anfang
 */
  if ( CWHITE == _0 && CRED == _0 ) {
     CWHIT0 = linv(CWHIT0);
     COLS   = list2(_0,CWHIT0);
	      return(COLS);
  }
/*
 * Keine Terme mehr da - Ende
 * Noch rote Terme da - Anfang
 */
  while ( CRED != _0 ) {
	AL     = lfirst(CRED);
	CRED   = lred(CRED);
	AL     = dipevsum(r1,TTERM,AL);
	CPR    = list2(AL,ALIST);
	CWHIT0 = lcomp(CPR,CWHIT0);
  }
/*
 * Noch rote Terme da - Ende
 * Noch weisse Terme da - Anfang
 */
  while ( CWHITE != _0 ) {
	CP     = lfirst(CWHITE);
	CWHITE = lred(CWHITE);
	BL     = lfirst(CP);
	BLIST  = lsecond(CP);
	BL     = dipevsum(r1,TTERM,BL);
	BLIST  = cgbwpu(r1,r2,ALIST,BLIST);
	CP     = list2(BL,BLIST);
	CWHIT0 = lcomp(CP,CWHIT0);
  }
/*
 * Noch weisse Terme da - Ende
 * Rueckgabe
 */
  CWHIT0 = linv(CWHIT0);
  COLS	 = list2(_0,CWHIT0);
  return(COLS);
}



/* 68.) cgbwtm */
/*c
			cgbwtm( r1, r2, TTERM, WHITE )

	"comprehensive Groebner basis, white term member"
	Quellbibliothek: srclib.pol2
	Include-Datei:	 _pol2.h
	single cgbwtm(r1,r2,TTERM,WHITE)  single r1,r2; vec TTERM;
	       list WHITE;
	s = cgbwtm(r1,r2,TTERM,WHITE);
	Dabei muss gelten:
	      - 0 <= r1 < BASIS	 ist die Anzahl der Variablen;
	      - 0 <= r2 < BASIS	 ist die Anzahl der Parameter;
	      - TTERM ist ein Term;
	      - WHITE ist eine Liste von Paaren, die weiss gefaerbte Terme
		und ihre Liste der weiss gefaerbten Faktoren der
		Koeffizienten enthalten.
	s = 1, falls TTERM in WHITE enthalten ist,
	s = 0, sonst.
c*/
/*H
	Version 1	02.11.1992	Th. Weis
   DATE cgbwtm	      : 930531
H*/

/* #include <_pol2.h> */

single cgbwtm(r1,r2,TTERM,WHITE)
single r1,r2;
list   TTERM,WHITE;
{
/*
 * Fall: TTERM oder WHITE = {}	- Anfang
 */
  if ( TTERM == 0 || TTERM == _0 || WHITE == _0 )  return(0);
/*
 * Fall: TTERM oder WHITE = {}	- Ende
 * Fall: TTERM und WHITE != {}	- Anfang
 */
  {
    single s;
    list   CWHITE,WPACK,WTERM;

    bind(TTERM,WHITE);
    init(CWHITE,WPACK,WTERM);
/*
 * Vorbesetzen - Anfang
 */
    CWHITE = WHITE;
/*
 * Vorbesetzen - Ende
 * Vergleichen - Anfang
 */
    do {
       WPACK  = lfirst(CWHITE);
       CWHITE = lred(CWHITE);
       WTERM  = lfirst(WPACK);
       s      = oequal(TTERM,WTERM);
    } while ( s != 1 && CWHITE != _0 );
/*
 * Vergleichen - Ende
 * Rueckgabe
 */
    return(s);
  }
}
