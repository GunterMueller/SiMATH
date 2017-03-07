/*M
.SH NAME
dipigb - distributive polynomial over integers Groebner basis
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
list dipigb(r, PL)  
single r; 
list PL;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.         
.TP 4
.B PL
is a list of distributive polynomials in r variables over the integer numbers.
.PP
dipigb returns the minimal, normalized and sorted Groebner basis of PL.
                                                                 
.SH SEE ALSO
technique, cf. B. Buchberger
                                                                    
M*/                                                                             
      
/*H
	Version 1	21.07.1992	Th. Weis
   DATE dipigb        : 930115
H*/

#include <_pol1.h>

static list dipilis(single,list);

list dipigb(r,PL)
single r;
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
    int     CL;
    list    EL;

    bind(PL);
    init(B,C,CPI,CPJ,CPP,D,DL,hDL,PP,PS,PPR,PPS,Q,QP);
    init(H,S,P,PLI,PLJ);
    init(CL);
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
             CL  = dipicp(r,PLI,&P);
             PPR = lcomp(P,PPR);
          }
    }
    PP = linv(PPR);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
    PPR = diplpm(r,PP); 
    PP  = linv(PPR);
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
          if ( xh > 0 )  PP = dipilis(r,PP);
          PPR = diplpm(r,PP);
          PP  = linv(PPR);
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
       S  = dipisp(r,PLI,PLJ);
       if ( S == 0 )  continue;
       CL = dipicp(r,S,&S);
       xh = xh+1;
       H  = dipinor(r,S,PP,0);
       if ( H == 0 )  continue;
       CL = dipicp(r,H,&H);
       sl = isdipione(r,H);
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
       D  = diplcaupl(r,H,PP,D,B,0,&L);
       xh = 0;
    } while ( D != _0 );  /* naechstes Paar */
/*
 * SCHLEIFE - Ende
 * minimale Groebner Basis - Anfang
 */
    PP = dipimogb(r,PP);
/*
 * minimale Groebner Basis - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                    dipilis( r, PL )        (static)

        "distributive polynomial over integers list irreducible set"
        static list dipilis(r,PL)  single r; list PL;
        PLL = dipilis(r,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS  ist die Anzahl der Variablen.
              - PL ist eine Liste von Polynomen in r Variablen ueber Z
                in distributiver Darstellung.
        PLL ist das Ergebnis der Reduzierung von jedem Polynom P in
        PL modulo PL\{P}, solange bis keine weiteren Reduzierungen mehr
        moeglich sind.
c*/

static list dipilis(r,PL)
single r;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single l,s,irr;
  list   PLL,PLS,RL;
  pol    P;
  int    C;
  list    EL1,EL2;

  bind(PL);
  init(PLL,PLS,RL);
  init(P);
  init(C);
  init(EL1,EL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PLL = PL;
  PLS = _0;
  while ( PLL != _0 ) {
        P   = lfirst(PLL);
        PLL = lred(PLL);
        C   = dipicp(r,P,&P);
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
     P   = dipinor(r,P,PLL,0);
     if ( P == 0 ) {
        l = l-1;
        if ( l <= 1 )  break;
     }
     else {
          EL2 = dipevl(r,P);
          s   = dipevsign(r,EL2);
          if ( s == 0 ) {
             PLL = list1(P);
             break;
          }
          s = oequal(EL1,EL2);
          if ( s == 1 )  irr = irr+1;
          else {
               irr = 0;
               C   = dipicp(r,P,&P);
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
