/*M
.SH NAME
dipnfgb - distributive polynomial over number field Groebner basis

.SH SYNOPSIS
.nf
#include<_pol3.h>

list dipnfgb(r, F, PL)  
single r; 
pol F; 
list PL;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.  
.TP 4
.B PL
is a list of distributive polynomials in r variables over K.
.PP
dipnfgb returns the minimal, monic and ordered Groebner basis of PL (method cf B. Buchberger).                        

M*/
                                  
/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipnfgb       : 930115
H*/

#include <_pol3.h>
static list dipnflis(single,pol,list);
list dipnfgb(r,F,PL)
single r;
pol    F;
list   PL;
{
/*
 * Fall: PL = ()  - Anfang
 */
  if ( PL == _0 )  return(PL);
/*
 * Fall: PL = ()  - Ende
 * Fall: PL != ()  - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single  s,sl,xh,il;
    list    B,C,CPI,CPJ,CPP,D,DL,hDL,PP,PS,PPR,PPS,Q,QP,L;
    pol     H,S,P,PLI,PLJ;
    vec     EL;

    bind(F,PL);
    init(B,C,CPI,CPJ,CPP,D,DL,hDL,PP,PS,PPR,PPS,Q,QP);
    init(H,S,P,PLI,PLJ);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    PS  = PL;
    PPR = _0;
    while ( PS != _0 ) {
          PLI = lfirst(PS);        PS = lred(PS);
          P   = dipnfmonic(r,F,PLI);
          if ( PLI != 0 )  PPR = lcomp(P,PPR);
    }
    PP = linv(PPR);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
    if ( GBRHO == 0 )  GBRHO = BETA1;
    xh = 0;
    s  = 1;
/*
 * Vorbesetzen - Ende
 * SCHLEIFE - Anfang
 */
    do {
/*
 * Konstruiere Paarlisten B und D - Anfang
 */
       if ( s == 1 ) {
          PPR = diplpm(r,PP);
          PP  = linv(PPR);
          PPS = PP;
          D   = diplcaupl(r,0,PP,_0,_0,1,&B);
          if ( D == _0 )  continue;
          s = 0;
       }
/*
 * Konstruiere Paarlisten B und D - Ende
 */
       DL  = lfirst(D);
       D   = lred(D);
       hDL = DL;
       EL  = lfirst(hDL);
       hDL = lred(hDL);
       CPI = lfirst(hDL);
       hDL = lred(hDL);
       CPJ = lfirst(hDL);
       QP  = lfirst(CPI);
       C   = lred(CPI);
       PLI = lfirst(QP);
       PLJ = lfirst(lred(CPJ));
/*
 * Paare von B loeschen - Anfang
 */
       CPP = lred(lred(CPJ));
             lsred(CPJ,CPP);
       if ( CPP == _0 ) {
          Q = llast(QP);
              lsfirst(C,Q);
       }
/*
 * Paare von B loeschen - Ende
 * Test, ob Reduktionsschritt notwendig, anhand der Kriterien 3 und 4 - Anfang
 */
       sl = dipgbc3(r,B,PLI,PLJ,EL);
       if ( sl == 0 )  continue;
       sl = dipgbc4(r,PLI,PLJ,EL);
       if ( sl == 0 )  continue;
/*
 * Test, ob Reduktion notwendig - Ende
 * Reduktionsschritt - Anfang
 */
       S  = dipnfsp(r,F,PLI,PLJ);
       if ( S == 0 )  continue;
       xh = xh+1;
       H  = dipnfnor(r,F,S,PP);
       if ( H == 0 )  continue;
       H = dipnfmonic(r,F,H);
/*
 * Reduktionsschritt - Ende
 */
       il = isrem(xh,GBRHO);
       if ( il == 0 ) {
          PS = list1(H);
          PP = lconc(PP,PS);
          PP = dipnflis(r,F,PP);
          s  = 1;
          continue;
       }
/*
 * Aktualisieren von B und PP - Anfang
 */
       D  = diplcaupl(r,H,PP,D,B,0,&L);
       xh = 0;
    } while ( D != _0 );  /* naechstes Paar */
/*
 * SCHLEIFE - Ende
 * minimale Groebner Basis - Anfang
 */
    PP = dipnfmogb(r,F,PP);
/*
 * minimale Groebner Basis - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                    dipnflis( r, F, PL )        (static)

        "distributive polynomial over number field list irreducible set"
        static list dipnflis(r,F,PL)  single r; pol F; list PL;
        PLL = dipnflis(r,F,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
	      - F ist ein irreduzibles Polynom in einer Variablen ueber Z
		vom Grad >= 1 in dense-Darstellung, das den Zahlkoerper k 
		erzeugt.
              - PL ist eine Liste von Polynomen in r Variablen ueber k in
                distributiver Darstellung.
        PLL ist das Ergebnis der Reduzierung von jedem Polynom P in
        PL modulo PL\{P}, solange bis keine weiteren Reduzierungen mehr
        moeglich sind.
c*/

static list dipnflis(r,F,PL)
single r;
pol    F;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single l,s,irr;
  list   PLL,PLS,RL;
  pol    P;
  vec    EL1,EL2;

  bind(F,PL);
  init(PLL,PLS,RL);
  init(P);
  init(EL1,EL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PLL = PL;
  PLS = _0;
  while ( PLL != _0 ) {
        P = lfirst(PLL);
        PLL = lred(PLL);
        P = dipnfmonic(r,F,P);
        if ( P != 0 )  PLS = lcomp(P,PLS);
  }
  RL  = PLS;
  PLL = linv(PLS);
  l   = llength(PLL);
  irr = 0;
  if ( l <= 1 )  return(PLL);
/*
 * Vorbesetzen - Ende
 * Reduziere, bis alle Polynome irreduzibel - Anfang
 */
  do {
     P   = lfirst(PLL);
     PLL = lred(PLL);
     EL1 = dipevl(r,P);
     P   = dipnfnor(r,F,P,PLL);
     if ( P == 0 ) {
        l = l-1;
        if ( l <= 1 )  return(PLL);
        else {
             EL2 = dipevl(r,P);
             s   = oequal(EL1,EL2);
             if ( s == 1 )  irr = irr+1;
             else {
                  irr = 0;
                  P   = dipnfmonic(r,F,P);
             }
             PLS = list1(P);
                   lsred(RL,PLS);
             RL  = PLS;
        }
     }
  } while ( irr != l );
/*
 * Reduziere, bis alle Polynome irreduzibel - Ende
 * Aus- und Rueckgabe
 */
  return(PLL);
}
