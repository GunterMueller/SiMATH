/*M
.SH NAME
dipgfsgb - distributive polynomial over Galois-field with single characteristic Groebner basis

.SH SYNOPSIS
.nf
#include<_pol3.h>

list dipgfsgb(r, p, AL, PL)  
single r, p; 
list AL, PL;

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
.B PL
is a list of distributive polynomials in r variables over GF(p^n).     
.PP
dipgfsgb returns the minimal, monic and ordered Groebner basis of PL (method cf B. Buchberger).
  
.SH SEE ALSO
gfsalgen

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipgfsgb      : 930115
H*/

#include <_pol3.h>
static list dipgfslis(single,single,list,list);
list dipgfsgb(r,p,AL,PL)
single r,p;
list   AL,PL;
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

    bind(AL,PL);
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
          PLI = lfirst(PS);
          PS  = lred(PS);
          P   = dipgfsmonic(r,p,AL,PLI);
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
       S  = dipgfssp(r,p,AL,PLI,PLJ);
       if ( S == 0 )  continue;
       xh = xh+1;
       H  = dipgfsnor(r,p,AL,S,PP);
       if ( H == 0 )  continue;
       H = dipgfsmonic(r,p,AL,H);
/*
 * Reduktionsschritt - Ende
 */
       il = isrem(xh,GBRHO);
       if ( il == 0 ) {
          PS = list1(H);
          PP = lconc(PP,PS);
          PP = dipgfslis(r,p,AL,PP);
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
    PP = dipgfsmogb(r,p,AL,PP);
/*
 * minimale Groebner Basis - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                    dipgfslis( r, p, AL, PL )        (static)

        "distributive polynomial over Galois-field with single
         characteristic list irreducible set"
        static list dipgfslis(r,p,AL,PL)  single r,p; list AL,PL;
        PLL = dipgfslis(r,p,AL,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist Primzahl.
	      - AL = (G,AL1) kann als Arithmetikliste fuer GF(p^n)
                interpretiert werden (siehe gfsalgen), wobei
                n = llength(AL1)+1.
              - PL ist eine Liste von Polynomen in r Variablen ueber
                GF(p^n) in distributiver Darstellung.
        PLL ist das Ergebnis der Reduzierung von jedem Polynom P in
        PL modulo PL\{P}, solange bis keine weiteren Reduzierungen mehr
        moeglich sind.
c*/

static list dipgfslis(r,p,AL,PL)
single r,p;
list   AL,PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single l,s,irr;
  list   PLL,PLS,RL;
  pol    P;
  vec    EL1,EL2;

  bind(AL,PL);
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
        P   = lfirst(PLL);
        PLL = lred(PLL);
        P   = dipgfsmonic(r,p,AL,P);
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
     P   = dipgfsnor(r,p,AL,P,PLL);
     if ( P == 0 ) {
        l = l-1;
        if ( l <= 1 )  return(PLL);
        else {
             EL2 = dipevl(r,P);
             s   = oequal(EL1,EL2);
             if ( s == 1 )  irr = irr+1;
             else {
                  irr = 0;
                  P   = dipgfsmonic(r,p,AL,P);
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
