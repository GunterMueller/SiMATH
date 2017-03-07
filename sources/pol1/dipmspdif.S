/*M
.SH NAME
dipmspdif - distributive polynomial over modular single primes difference

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmspdif(r, p, P1, P2)  
single r, p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are distributive polynomials in r variables over Z/pZ.  
.PP
dipmspdif returns the polynomial P3, where
.IP
P3 = P1 - P2.

M*/

/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipmspdif     : 930115
H*/

#include <_pol1.h>

pol dipmspdif(r,p,P1,P2)
single r,p;
pol    P1,P2;
{
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Anfang
 */
  if ( P1 == 0 )  return(dipmspneg(r,p,P2));
  if ( P2 == 0 )  return(P1);
/*
 * Faelle: P1 = 0  oder  P2 = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    pol    P1P,P1PP,P2P,P2PP,P3,P3P,P3PP;
    single BC1,BC2,BC3;
    list    EL1,EL2,EL3;

    bind(P1,P2);
    init(P1P,P1PP,P2P,P2PP,P3,P3P,P3PP);
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
               BC3 = msneg(p,BC2);
               P3P = lcomp2(EL2,BC3,P3P);
               /* EL2 und BC2 bei Uebergabe vertauscht, da spaeter 
                  linv(P3P) gemacht wird */
            }
            else {
                 P1P = dipmoad(r,P1P,&BC1,&EL1);
                 P2P = dipmoad(r,P2P,&BC2,&EL2);
                 BC3 = msdif(p,BC1,BC2);
                 if ( BC3 != 0 )  P3P = lcomp2(EL1,BC3,P3P);
                 /* EL1 und BC3 bei Uebergabe vertauscht, da spaeter 
                    linv(P3P) gemacht wird */
            }
    } while ( P1P != _0 && P2P != _0 );
    P1PP = P1P;
    if ( P1P == _0 )  if ( P2P != _0 )  P1PP = dipmspneg(r,p,P2P);
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
