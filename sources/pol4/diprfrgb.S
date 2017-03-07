/*M
.SH NAME
diprfrgb - distributive polynomial over rational functions over the rationals Groebner basis

.SH SYNOPSIS
.nf
#include<_pol4.h>

list diprfrgb(r1, r2, PL)  
single r1, r2; 
list PL;
    
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4                                    
.B PL
is a list, containing distributive polynomials in r1 variables over rational functions in r2 variables over the rational numbers.          
.PP
diprfrgb returns the minimal, monic and ordered Groebner basis of PL (method cf B. Buchberger).     

M*/
                      
/*H
	Version 1	16.11.1992	Th. Weis
   DATE diprfrgb      : 930115
H*/

#include <_pol4.h>
static list diprfrlis(single,single,list);
list diprfrgb(r1,r2,PL)
single r1,r2;
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
    pol     H,S,P,PLI,PLIP,PLJ;
    vec     EL;

    bind(PL);
    init(B,C,CPI,CPJ,CPP,D,DL,hDL,PP,PS,PPR,PPS,Q,QP);
    init(H,S,P,PLI,PLIP,PLJ);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    PS  = PL;
    PPR = _0;
    while ( PS != _0 ) {
          PLI = lfirst(PS);
          PS  = lred(PS);
          if ( PLI != 0 ) {
             PLIP = diprfrmonic(r1,r2,PLI);
             sl   = isdiprfrone(r1,r2,PLIP);
             if ( sl == 1 )  return(list1(PLIP));
             PPR = lcomp(PLIP,PPR);
          }
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
          if ( xh > 0 )  PP = diprfrlis(r1,r2,PP);
          PPR = diplpm(r1,PP);
          PP  = linv(PPR);
          D   = diplcaupl(r1,0,PP,_0,_0,1,&B);
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
       sl = dipgbc3(r1,B,PLI,PLJ,EL);
       if ( sl == 0 )  continue;
       sl = dipgbc4(r1,PLI,PLJ,EL);
       if ( sl == 0 )  continue;
/*
 * Test, ob Reduktion notwendig - Ende
 * Reduktionsschritt - Anfang
 */
       S  = diprfrsp(r1,r2,PLI,PLJ);
       if ( S == 0 )  continue;
       xh = xh+1;
       H  = diprfrnor(r1,r2,S,PP);
       if ( H == 0 )  continue;
       H  = diprfrmonic(r1,r2,H);
       sl = isdiprfrone(r1,r2,H);
       if ( sl == 1 )  return(list1(H));
/*
 * Reduktionsschritt - Ende
 */
       il = isrem(xh,GBRHO);
       if ( il == 0 ) {
          PS = list1(H);
          PP = lconc(PP,PS);
          s  = 1;
          continue;
       }
/*
 * Aktualisieren von B und PP - Anfang
 */
       D  = diplcaupl(r1,H,PP,D,B,0,&L);
    } while ( D != _0 );  /* naechstes Paar */
/*
 * SCHLEIFE - Ende
 * minimale Groebner Basis - Anfang
 */
    PP = diprfrmogb(r1,r2,PP);
/*
 * minimale Groebner Basis - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                    diprfrlis( r1, r2, PL )        (static)

        "distributive polynomial over rational functions over the rationals
         list irreducible set"
        static list diprfrlis(r1,r2,PL)  single r1,r2; list PL;
        PLL = diprfrlis(r1,r2,PL);
        Dabei muss gelten:
              - 0 <= r1 < BASIS.
              - 0 <= r2 < BASIS.
              - PL ist eine Liste von distributiven Polynomen in r1 
		Variablen ueber rationalen Funktionen in r2 Variablen 
		ueber Q.
        PLL ist das Ergebnis der Reduzierung von jedem Polynom P in
        PL modulo PL\{P}, solange bis keine weiteren Reduzierungen mehr
        moeglich sind.
c*/

static list diprfrlis(r1,r2,PL)
single r1,r2;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single l,s,irr;
  list   PLL,PLS,RL;
  pol    P;
  vec    EL1,EL2;

  bind(PL);
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
        P = diprfrmonic(r1,r2,P);
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
     EL1 = dipevl(r1,P);
     P   = diprfrnor(r1,r2,P,PLL);
     if ( P == 0 ) {
        l = l-1;
        if ( l <= 1 )  return(PLL);
     }
     else {
          EL2 = dipevl(r1,P);
          s   = dipevsign(r1,EL2);
          if ( s == 0 )  return(list1(P));
          s   = oequal(EL1,EL2);
          if ( s == 1 )  irr = irr+1;
          else {
               irr = 0;
               P   = diprfrmonic(r1,r2,P);
          }
          PLS = list1(P);
                lsred(RL,PLS);
          RL  = PLS;
     }
  } while ( irr != l );
/*
 * Reduziere, bis alle Polynome irreduzibel - Ende
 * Aus- und Rueckgabe
 */
  return(PLL);
}
