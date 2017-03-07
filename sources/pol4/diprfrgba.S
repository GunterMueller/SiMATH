/*M
.SH NAME
diprfrgba - distributive polynomial over rational functions over the rationals Groebner basis augmentation

.SH SYNOPSIS
.nf
#include<_pol4.h>

list diprfrgba(r1, r2, PL, P)  
single r1, r2; 
list PL; 
pol P;
     
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4  
.B PL
is a list, containing distributive polynomials in r1 variables over rational functions in r2 variables over the rational numbers.
.TP 4
.B P
is a distributive polynomial in r1 variables over rational functions in r2 variables over the rational numbers. 
.PP
diprfrgba returns the minimal, monic and ordered Groebner basis of (PL,P) (method cf B. Buchberger).                         
             
M*/
              
/*H
	Version 1	01.10.1992	Th. Weis
   DATE diprfrgba     : 930115
H*/

#include <_pol4.h>

list diprfrgba(r1,r2,PL,P)
single r1,r2;
list   PL;
pol    P;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single  s,sl,xh,il;
  list    B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP,L;
  pol     H,S,PLI,PLJ;
  vec     EL;

   bind(PL);
   init(B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP);
   init(H,S,PLI,PLJ);
   init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PS = diprfrmonic(r1,r2,P);
  if ( PL == _0 )  return(list1(PS));
  PS = diprfrnor(r1,r2,PS,PL);
  PP = linv(lcinv(PL));
  if ( PS == 0 )  return(PP);
  PS = diprfrmonic(r1,r2,PS);
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
  D = diplcaupl(r1,PS,PP,D,B,0,&L);
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
       H  = diprfrnor(r1,r2,S,PP);
       if ( H == 0 )  continue;
       H = diprfrmonic(r1,r2,H);
/*
 * Reduktionsschritt - Ende
 * Aktualisieren von B und PP - Anfang
 */
       D = diplcaupl(r1,H,PP,D,B,0,&L);
/*
 * Aktualisieren von B und PP - Ende
 */
  }
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
