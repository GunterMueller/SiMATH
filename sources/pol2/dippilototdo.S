/*M
.SH NAME
dippilototdo - distributive polynomial over polynomials over integers in lexicographical order to distributive polynomial over polynomials over integers with total degree ordering

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol dippilototdo(r1, r2, P)  
single r1, r2; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over a ring of polynomials in r2 variables over the integer numbers.   
P is a polynomial in lexicographical order.
.PP
dippilototdo returns the transformed polynomial P to a polynomial with total degree ordering.
                                      
M*/
                        
/*H
	Version 1	12.08.1992	Th. Weis
   DATE dippilototdo  : 930115
H*/

#include <_pol2.h>

pol dippilototdo(r1,r2,P)
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
    pol    BC1;
    vec    EL1;

    bind(P);
    init(P1,P2,P3);
    init(BC1);
    init(EL1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    EVORD = 3;
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
       P3 = dippisum(r1,r2,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
