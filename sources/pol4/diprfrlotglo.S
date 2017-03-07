/*M
.SH NAME
diprfrlotglo - distributive polynomial over rational functions over the rationals in lexicographical order to distributive polynomial over rational functions over the rationals in graduated lexicographical order

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol diprfrlotglo(r1, r2, P)  
single r1, r2; 
pol P;
    
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4    
.B P 
is a distributive polynomial in r1 variables over rational functions in r2 variables over the rational numbers. P is a polynomial in lexicographical order.
.PP
diprfrlotglo returns the polynomial P as a polynomial in graduated lexicographical order. 
  
M*/
                 
/*H
	Version 1	01.10.1992	Th. Weis
   DATE diprfrlotglo  : 930115
H*/

#include <_pol4.h>

pol diprfrlotglo(r1,r2,P)
single r1,r2;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(P);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    pol    P1,P2,P3;
    rfunc  BC1;
    vec    EL1;

    bind(P);
    init(P1,P2,P3);
    init(BC1);
    init(EL1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    EVORD = 2;
    P1    = P;
    P2    = _0;
    P3    = 0;
/*
 * Vorbesetzen - Ende
 * Sortieren - Anfang
 */
    do {
       P1 = dipmoad(r1,P1,&BC1,&EL1);
       P2 = dipfmo(r1,BC1,EL1);
       P3 = diprfrsum(r1,r2,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
