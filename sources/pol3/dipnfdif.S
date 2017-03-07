/*M
.SH NAME
dipnfdif - distributive polynomial over number field difference

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipnfdif(r, F, P1, P2)  
single r; 
pol F, P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P1, P2
are distributive polynomials in r variables over K.
.PP
dipnfdif returns a polynomial over K, say P3, where
.IP
P3 = P1 - P2.
                                          
M*/
                  
/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipnfdif      : 930115
H*/

#include <_pol3.h>

pol dipnfdif(r,F,P1,P2)
single r;
pol    F,P1,P2;
{
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Anfang
 */
  if ( P1 == 0 )  return(dipnfneg(r,F,P2));
  if ( P2 == 0 )  return(P1);
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    pol    P1P,P1PP,P2P,P2PP,P3,P3P,P3PP;
    nfel   BC1,BC2,BC3;
    vec    EL1,EL2,EL3;

    bind(P1,P2);
    init(P1P,P1PP,P2P,P2PP,P3,P3P,P3PP);
    init(BC1,BC2,BC3);
    init(EL1,EL2,EL3);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    P1P = P1;
    P2P = P2;
    P3P = _0;
/*
 * Vorbesetzen - Ende
 * Polynomsubtraktion - Anfang
 */
    do {
       EL1 = dipevl(r,P1P);
       EL2 = dipevl(r,P2P);
       s   = dipevcomp(r,EL1,EL2);
       if ( s == 1 ) {
          P1P = dipmoad(r,P1P,&BC1,&EL1);
          P3P = lcomp2(EL1,BC1,P3P);
          /* EL1 und BC1 bei Uebergabe vertauscht, da spaeter 
             linv(P3P) gemacht wird */
       }
       else if ( s == (-1) ) {
               P2P = dipmoad(r,P2P,&BC2,&EL2);
               BC3 = nfneg(F,BC2);
               P3P = lcomp2(EL2,BC3,P3P);
               /* EL2 und BC2 bei Uebergabe vertauscht, da spaeter 
                  linv(P3P) gemacht wird */
            }
            else {
                 P1P = dipmoad(r,P1P,&BC1,&EL1);
                 P2P = dipmoad(r,P2P,&BC2,&EL2);
                 BC3 = nfdif(F,BC1,BC2);
                 if ( BC3 != 0 )  P3P = lcomp2(EL1,BC3,P3P);
                 /* EL1 und BC3 bei Uebergabe vertauscht, da spaeter 
                    linv(P3P) gemacht wird */
            }
    } while ( P1P != _0 && P2P != _0 );
    P1PP = P1P;
    if ( P1P == _0 )  if ( P2P != _0 )  P1PP = dipnfneg(r,F,P2P);
    if ( P3P == _0 )  P3 = P1PP;
    else {
         P3PP = P3P;
         P3   = linv(P3P);
                lsred(P3PP,P1PP);
    }
    if ( P3 == _0 )  P3 = 0;
/*
 * Polynomsubtraktion - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
