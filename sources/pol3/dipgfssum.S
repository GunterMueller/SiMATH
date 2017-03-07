/*M
.SH NAME
dipgfssum - distributive polynomial over Galois-field with single characteristic sum

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfssum(r, p, AL, P1, P2)  
single r, p; 
list AL; 
pol P1, P2;
   
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
.B P1, P2
are distributive polynomials in r variables over GF(p^n).
.PP
dipgfssum returns a polynomial over GF(p^n), say P3, where
.IP
P3 = P1 + P2.

.SH SEE ALSO
gfsalgen

M*/
                              
/*H
	Version 1	02.10.1992	Th. Weis
   DATE dipgfssum     : 930115
H*/

#include <_pol3.h>

pol dipgfssum(r,p,AL,P1,P2)
single r,p;
list   AL;
pol    P1,P2;
{
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Anfang
 */
  if ( P1 == 0 )  return(P2);
  if ( P2 == 0 )  return(P1);
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    pol    P1P,P1PP,P2P,P2PP,P3,P3P,P3PP;
    gfel   BC1,BC2,BC3;
    vec    EL1,EL2,EL3;

    bind(AL,P1,P2);
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
 * Polynomaddition - Anfang
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
               P3P = lcomp2(EL2,BC2,P3P);
               /* EL2 und BC2 bei Uebergabe vertauscht, da spaeter 
                  linv(P3P) gemacht wird */
            }
            else {
                 P1P = dipmoad(r,P1P,&BC1,&EL1);
                 P2P = dipmoad(r,P2P,&BC2,&EL2);
                 BC3 = gfssum(p,AL,BC1,BC2);
                 if ( BC3 != 0 )  P3P = lcomp2(EL1,BC3,P3P);
                 /* EL1 und BC3 bei Uebergabe vertauscht, da spaeter 
                    linv(P3P) gemacht wird */
            }
    } while ( P1P != _0 && P2P != _0 );
    if ( P1P == _0 )  P1PP = P2P;
    else  P1PP = P1P;
    if ( P3P == _0 )  P3 = P1PP;
    else {
         P3PP = P3P;
         P3   = linv(P3P);
                lsred(P3PP,P1PP);
    }
    if ( P3 == _0 )  P3 = 0;
/*
 * Polynomaddition - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
