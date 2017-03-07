/*M
.SH NAME
diprfrneg - distributive polynomial over rational functions over the rationals negation

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol diprfrneg(r1, r2, P)  
single r1, r2; 
pol P;

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over rational functions in r2 variables over the rational numbers.
.PP
diprfrneg returns a polynomial, say P1, where
.IP
P1 = -P.

M*/
                          
/*H
	Version 1	01.10.1992	Th. Weis
   DATE diprfrneg     : 930115
H*/

#include <_pol4.h>

pol diprfrneg(r1,r2,P)
single r1,r2;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(0);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklarartion, Binden & Initialisieren - Anfang
 */
  {
    pol   PS,P1;
    rfunc BC,BC1;
    vec   EL;

    bind(P);
    init(PS,P1);
    init(BC,BC1);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    PS = P;
    P1 = _0;
/*
 * Vorbesetzen - Ende
 * Negieren - Anfang
 */
    do {
       PS  = dipmoad(r1,PS,&BC,&EL);
       BC1 = rfrneg(r2,BC);
       P1  = lcomp2(EL,BC1,P1);
       /* EL und BC1 vertauscht, da spaeter
          linv(P1) gemacht wird */
    } while ( PS != _0 );
    P1 = linv(P1);
/*
 * Negieren - Ende
 * allgemeiner Fall - Emde
 * Rueckgabe
 */
    return(P1);
  }
}
