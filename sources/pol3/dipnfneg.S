/*M
.SH NAME
dipnfneg - distributive polynomial over number field negation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipnfneg(r, F, P)  
single r; 
pol F, P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a distributive polynomial in r variables over K.
.PP  
dipnfneg returns a polynomial over K, say P1, where
.IP
P1 = -P.
           
M*/
              
/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipnfneg      : 930115
H*/

#include <_pol3.h>

pol dipnfneg(r,F,P)
single r;
pol    F,P;
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
    pol    PS,P1;
    nfel   BC,BC1;
    vec    EL;

    bind(F,P);
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
       PS  = dipmoad(r,PS,&BC,&EL);
       BC1 = nfneg(F,BC);
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
