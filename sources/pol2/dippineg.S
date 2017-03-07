/*M
.SH NAME
dippineg distributive polynomial over polynomials over integers negation

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol dippineg(r1, r2, P)  
single r1, r2; 
pol P;

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over a ring of polynomials in r2 variables over the integer numbers. 
.PP
dippineg returns the polynomial P1, where
.IP
P1 = - P.               

M*/
           
/*H
	Version 1	28.07.1992	Th. Weis
   DATE dippineg      : 930115
H*/

#include <_pol2.h>

pol dippineg(r1,r2,P)
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
    pol PS,P1;
    pol BC,BC1;
    vec EL;

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
       BC1 = pineg(r2,BC);
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
