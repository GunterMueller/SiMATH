/*M
.SH NAME
dippigt - distributive polynomial over polynomials over integers Groebner test

.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippigt(r1, r2, s, PL, CONDS, OPL, pCGB1)  
single r1, r2, s;
list PL, CONDS, OPL, *pCGB1;
   
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B s
is either 0 or 1, for s = 0,
.RS
.TP 4
.B PL
is a list of distributive polynomials in r1 variables over a ring of polynomials in r2 variables over the integer numbers.      
.TP 4
.B VL1
is a list, consisting of the r1 variables names used by the polynomials in PL.
.TP 4
.B VL2
is a list, consisting of the r2 variables names used by the ring of polynomials
over the integer numbers.
.PP
.RE
For s = 1,
.RS
.PP
.B PL
is a parametric Groebnerbasis (s. dippicgb or dippircgb).
.RE
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n),
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero
 (i even).
.PP
(s.dippicgb)                                                     
.TP 4
.B OPL
is a list of length 3, every element (say e1,e2,e3) has value 0 or 1.
.RS
.TP 4
.B e1
turns the factorization of the coefficient polynomials on (e1=1) or off(e1=0).
.TP 4
.B e2                                           
determines the algorithm used to normalize the polynomials.
.IP
e2 = 0: 'Top reduction' will be used, i.e. only
        the leading monomials (with regard to
        the term order) unequal to zero will be
        eliminated.
.IP
e2 = 1: the 'common' algorithm to compute Groebner
        basis will be used.
.TP 4
.B e3    
is optional.
.RE
.PP
dippigt verifies if PL is a parametric Groebenerbasis, and returns a list, containing the conditions, that PL is a parametric Groebnerbasis. *pCGB is a list, containing the conditions, that PL is not a parametric Groebnerbasis.                                             
.SH SEE ALSO
 dippicgb
 dippircgb
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)
                                                         
M*/
                  
/*H
	Version 1	08.06.1993	Th. Weis
   DATE dippigt       : 931130
H*/

#include <_pol2.h>

static cgbigt(single,single,list,list,single,single,list*,list*);
static cgbigth(single,single,list,list,list,single,single,list*,list*);
static cgbnfs(single,single,list,list,list,list,list*,list*);

list dippigt(r1,r2,s,PL,CONDS,OPL,pCGB1)
single r1,r2,s;
list   PL,CONDS,OPL;
list   *pCGB1;
{
/*
 * Fall: PL == {}  - Anfang
 */
  if ( PL == _0 )  return(_0);
/*
 * Fall: PL == {}  - Ende
 * Fall: PL != {}
 */
  {
    single fac,red;
    list   CGB,CGB0;

    bind(PL,CONDS,OPL);
    init(CGB,CGB0);
/*
 * Berechnungen vorbereiten - Anfang
 */
    fac = lfirst(OPL);
    red = lsecond(OPL);
    if ( !s ) {
       CGB = lcopy(PL);
       CGB = diplpm(r1,CGB);
       CGB = linv(CGB);
    }
    else CGB = cgbfcb(r1,r2,PL);
/*
 * Berechnungen vorbereiten - Ende
 * Groebner Test durchfuehren - Anfang
 */
    cgbigt(r1,r2,CONDS,CGB,fac,red,&CGB0,pCGB1);
/*
 * Groebner Test durchfuehren - Ende
 * Rueckgabe
 */
    return(CGB0);
  }
}



/*c
		cgbigt( r1, r2, C, P, fac, red, pC0, pC1 )	(static)

        "comprehensive Groebner basis over integers, Groebner test"
        static cgbigt(r1,r2,C,P,fac,red,pC0,pC1)  single r1,r2; list C,P;
        	single fac,red; list *pC0,*pC1;
        cgbigt(r1,r2,C,P,fac,red,pC0,pC1);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - C ist eine Bedingung;
              - P ist eine Liste von Polynomen;
              - fac ist ein Schalter fuer die Faktorisierung der Koef-
                fizienten;
              - red ist ein Schalter fuer den Reduktionstyp;
                fuer red = 0 wird cgbinorbtop, und
                fuer red = 1 wird cgbipanor benutzt.
        cgbigt verifiziert, ob P eine parametrische Groebnerbasis bzgl. C
        ist.
        *pC0 enthaelt die Bedingungen, so dass P eine Groebnerbasis ist.
        *pC1 enthaelt die Bedingungen, so dass P keine Groebnerbasis ist.
c*/

static cgbigt(r1,r2,C,P,fac,red,pC0,pC1)
single r1,r2;
list   C,P;
single fac,red;
list   *pC0,*pC1;
{
/*
 * Fall: P oder lred(P) == {}  - Anfang
 */
  *pC0 = _0;
  *pC1 = _0;
  if ( P == _0 || lred(P) == _0 )  return;
/*
 * Fall: P oder lred(P) == {}  - Ende
 * Fall: P oder lred(P) != {}
 */
  {
    single s;
    list   CC0,CC1,COND,DEL,PAIRS,PCO,PELEM,PLIST,PPL,X;

    bind(C,P);
    init(CC0,CC1,COND,DEL,PAIRS,PCO,PELEM,PLIST,PPL,X);
/*
 * Bestimmung von P - Anfang
 */
    cgbidlop(r1,r2,C,P,fac,&DEL,&PPL);
/*
 * Bestimmung von P - Ende
 * Test - Anfang
 */
    while ( PPL != _0 ) {
          PELEM = lfirst(PPL);
          PPL   = lred(PPL);
          COND  = lfirst(PELEM);
          PLIST = lsecond(PELEM);
          PCO   = cgbcdopl(r1,r2,PLIST);
          if ( PCO == _0 && lred(PLIST) != _0 ) {
             cgbmkpair(r1,r2,PLIST,&PAIRS);
             if ( PAIRS != _0 ) {
                cgbigth(r1,r2,COND,PAIRS,PLIST,fac,red,&CC0,&CC1);
                if ( CC0 != _0 ) {
                   if ( *pC0 == _0 )  *pC0 = CC0;
                   else {
                        X = llast(*pC0);
                            lsred(X,CC0);
                   }
                }
                if ( CC1 != _0 ) {
                   if ( *pC1 == _0 )  *pC1 = CC1;
                   else {
                        X = llast(*pC1);
                            lsred(X,CC1);
                   }
                }
             }
             else {
                  s = lmemb(COND,*pC0);
                  if ( s == 0 )  *pC0 = lcomp(COND,*pC0);
             }
          }
          else {
               s = lmemb(COND,*pC0);
               if ( s == 0 )  *pC0 = lcomp(COND,*pC0);
          }
    }
/*
 * Test - Ende
 * Ruecksprung
 */
    return;
  }
}



/*c
	cgbigth( r1, r2, COND, PPAIRS, P, fac, red, pC0, pC1 )	(static)

        "comprehensive Groebner basis over integers, Groebner test help"
        static cgbigth(r1,r2,COND,PPAIRS,P,fac,red,pC0,pC1)  single r1,r2;
        	list COND,PPAIRS,P; single fac,red; list *pC0,*pC1;
        cgbigth(r1,r2,COND,PPAIRS,P,fac,red,pC0,pC1);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - COND ist eine Bedingung;
              - PPAIRS ist die Polynompaarliste von P;
              - P ist eine bzgl. COND bestimmte und gefaerbte Liste von
                Polynomen;
              - fac ist ein Schalter fuer die Faktorisierung der Koef-
                fizienten;
              - red ist ein Schalter fuer den Reduktionstyp;
                fuer red = 0 wird cgbinorbtop  und
                fuer red = 1 wird cgbipanor benutzt.
        *pC0 enthaelt den Nachfolger der Bedingung COND, so dass P keine
        Groebnerbasis ist.
        *pC1 enthaelt den Nachfolger der Bedingung COND, so dass P eine
        Groebnerbasis ist.
c*/

static cgbigth(r1,r2,COND,PPAIRS,P,fac,red,pC0,pC1)
single r1,r2;
list   COND,PPAIRS,P;
single fac,red;
list   *pC0,*pC1;
{
  single s;
  list   FCO,GCO,HCO,N0,N1,PAIR,PAIRS;

  bind(COND,PPAIRS,P);
  init(FCO,GCO,HCO,N0,N1,PAIR,PAIRS);
/*
 * Vorbesetzen - Anfang
 */
  PAIRS = PPAIRS;
  *pC0  = _0;
  *pC1  = _0;
/*
 * Vorbesetzen - Ende
 * Konstruktion der S-Polynome - Anfang
 */
  while ( PAIRS != _0 ) {
        PAIR  = lfirst(PAIRS);
        PAIRS = lred(PAIRS);
        FCO   = lsecond(PAIR);
        GCO   = lthird(PAIR);
                cgbipaspol(r1,r2,COND,FCO,GCO,fac,&HCO);
        if ( HCO != _0 ) {
           if ( red == 0 )  cgbinorbtop(r1,r2,COND,HCO,P,fac,&N0,&N1);
           else  cgbipanor(r1,r2,COND,HCO,P,fac,&N0,&N1);
           if ( N1 == _0 ) {
              s = lmemb(COND,*pC0);
              if ( s == 0 )  *pC0 = lcomp(COND,*pC0);
           }
           if ( N0 == _0 ) {
              s = lmemb(COND,*pC1);
              if ( s == 0 )  *pC1 = lcomp(COND,*pC1);
           }
           if ( N0 != _0 && N1 != _0 )  cgbnfs(r1,r2,N0,N1,*pC0,*pC1,pC0,pC1);
        }
        else  *pC0 = lcomp(COND,*pC0);
  }
/*
 * Konstruktion der S-Polynome - Ende
 * Ruecksprung
 */
  return;
}



/*c
		cgbnfs( r1, r2, NN0, NN1, CC0, CC1, pC0, pC1 )	(static)

        "comprehensive Groebner basis, normalform set"
        static cgbnfs(r1,r2,NN0,NN1,CC0,CC1,pC0,pC1)  single r1,r2;
        	list NN0,NN1,CC0,CC1; list *pC0,*pC1;
        cgbnfs(r1,r2,NN0,NN1,CC0,CC1,pC0,pC1);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - NN0 ist eine Liste von Tripel der Form:
                ( GA, PCO, C ), wobei
                - GA eine Bedingung ist,
                - *PCO eine Normalform ist, die durch GA bestimmt und
                  komplett gruen gefaerbt wird,
                - C ein multiplikativer Faktor ist;
              - NN1 ist eine Liste von Tripel der Form:
                ( GA, PCO, C ), wobei
                - GA eine Bedingung ist,
                - *PCO eine Normalform ist, die durch GA bestimmt und
                  NICHT komplett gruen gefaerbt wird,
                - C ein multiplikativer Faktor ist;
              - CC0 und CC1 sind Listen von Bedingungen.
        Die Bedingungen in NN0, die nicht in CC1 sind, werden zu CC0 (pC0)
        hinzugefuegt. Die Bedingungen in NN1 werden zu CC1 (pC1) hinzuge-
        fuegt.
c*/

static cgbnfs(r1,r2,NN0,NN1,CC0,CC1,pC0,pC1)
single r1,r2;
list   NN0,NN1,CC0,CC1;
list   *pC0,*pC1;
{
  single s,t;
  list   C,COND,N0,N1,PCO;

  bind(NN0,NN1,CC0,CC1);
  init(C,COND,N0,N1,PCO);
/*
 * Vorbesetzen - Anfang
 */
  *pC0 = CC0;
  *pC1 = CC1;
  N0   = NN0;
  N1   = NN1;
/*
 * Vorbesetzen - Ende
 * Ueberpruefen und Zusammenstellen der Bedingungslisten - Anfang
 */
  while ( N1 != _0 ) {
        COND = lfirst(N1);
        N1   = lred(N1);
        PCO  = lfirst(N1);
        N1   = lred(N1);
        C    = lfirst(N1);
        N1   = lred(N1);
        s    = lmemb(COND,*pC1);
        if ( s == 0 )  *pC1 = lcomp(COND,*pC1);
  }
  while ( N0 != _0 ) {
        COND = lfirst(N0);
        N0   = lred(N0);
        PCO  = lfirst(N0);
        N0   = lred(N0);
        C    = lfirst(N0);
        N0   = lred(N0);
        s    = lmemb(COND,*pC0);
        t    = lmemb(COND,*pC1);
        if ( s == 0 && t == 0 )  *pC0 = lcomp(COND,*pC0);
  }
/*
 * Ueberpruefen und Zusammenstellen der Bedingungslisten - Ende
 * Ruecksprung
 */
  return;
}
