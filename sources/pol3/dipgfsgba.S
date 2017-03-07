/*M
.SH NAME
dipgfsgba - distributive polynomial over Galois-field with single characteristic Groebner basis augmentation

.SH SYNOPSIS
.nf
#include<_pol3.h>

list dipgfsgba(r, p, AL, PL, P)  
single r, p; 
list AL, PL; 
pol P;
     
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
is a Groebner basis of distributive polynomials in r variables over GF(p^n).
.TP 4
.B P
is a distributive polynomial in r variables over GF(p^n)
.PP
dipgfsgba returns the minimal, monic and ordered Groebner basis of (PL,P) (method cf B. Buchberger).  

.SH SEE ALSO
.nf
dipgfsgb
gfsalgen

M*/
                              
/*H
	Version 1	02.10.1992	Th. Weis
   DATE dipgfsbga     : 930115
H*/

#include <_pol3.h>

list dipgfsgba(r,p,AL,PL,P)
single r,p;
list   AL,PL;
pol    P;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single  s,sl,xh,il;
  list    B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP,L;
  pol     H,S,PLI,PLJ;
  vec     EL;

  bind(AL,PL,P);
  init(B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP);
  init(H,S,PLI,PLJ);
  init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PS = dipgfsmonic(r,p,AL,P);
  if ( PL == _0 )  return(list1(PS));
  PS = dipgfsnor(r,p,AL,PS,PL);
  PP = linv(lcinv(PL));
  if ( PS == 0 )  return(PP);
  PS = dipgfsmonic(r,p,AL,PS);
  D  = _0;
  B  = _0;
  PPR = PP;
/*
 * Vorbesetzen - Ende
 * Konstruiere Paarlisten B und D - Anfang
 */
  while ( PPR != _0 ) {
        QL  = lfirst(PPR);
        PPR = lred(PPR);
        QLS = list1(QL);
        B   = lcomp2(QLS,QLS,B);
  }
  B = linv(B);
  D = diplcaupl(r,PS,PP,D,B,0,&L);
/*
 * Konstruiere Paarlisten B und D - Ende
 * SCHLEIFE - Anfang
 */
  while ( D != _0 ) {
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
        H  = dipgfsnor(r,p,AL,S,PP);
        if ( H == 0 )  continue;
        H = dipgfsmonic(r,p,AL,H);
/*
 * Reduktionsschritt - Ende
 * Aktualisieren von B und PP - Anfang
 */
        D  = diplcaupl(r,H,PP,D,B,0,&L);
/*
 * Aktualisieren von B und PP - Ende
 */
  }
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
