/*M
.SH NAME
dipmspgba - distributive polynomial over modular single primes Groebner basis augmentation

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dipmspgba(r, p, PL, P)  
single r, p; 
list PL; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B PL                                                                           
is a Groebner basis of distributive polynomials in r variables over Z/pZ.       
.TP 4                                                                           
.B P                                                                            
is a distributive polynomial in r variables over Z/pZ.                          
.PP                                                                             
dipmspgba returns the minimal, normalized and sorted Groebner basis of (PL,P).  
                                                                              
.SH SEE ALSO
 dipmspgb
 dipmspgbr
.PP                                                                             
technique, cf. B. Buchberger      

M*/

/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipmspgba     : 930115
H*/

#include <_pol1.h>

list dipmspgba(r,p,PL,P)
single r,p;
list   PL;
pol    P;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single  s,sl,xh,il;
  list    B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP,L;
  pol     H,S,PLI,PLJ;
  list     EL;

  bind(PL,P);
  init(B,C,CPI,CPJ,CPP,D,DL,hDL,PLS,PP,PS,PPR,PPS,Q,QL,QLS,QP);
  init(H,S,PLI,PLJ);
  init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PS = dipmspmonic(r,p,P);
  if ( PL == _0 )  return(list1(PS));
  PS = dipmspnor(r,p,PS,PL);
  PP = linv(lcinv(PL));
  if ( PS == 0 )  return(PP);
  PS = dipmspmonic(r,p,PS);
  D  = _0;
  B  = _0;
  PPR = PP;
/*
 * Vorbesetzen - Ende
 * Konstruiere Paarlisten B und D - Anfang
 */
  while ( PPR != _0 ) {
        QL  = lfirst(PPR);  PPR = lred(PPR);
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
     S  = dipmspsp(r,p,PLI,PLJ);
     if ( S == 0 )  continue;
     H  = dipmspnor(r,p,S,PP);
     if ( H == 0 )  continue;
     H = dipmspmonic(r,p,H);
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
  PP = dipmspmogb(r,p,PP);
/*
 * minimale Groebner Basis - Ende
 * Rueckgabe
 */
  return(PP);
}
