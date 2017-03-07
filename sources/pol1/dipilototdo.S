/*M
.SH NAME
dipilototdo - distributive polynomial over integers in lexicographical order to distributive polynomial over integers with total degree ordering

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipilototdo(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over the integer numbers.
P is a polynomial in lexicographical order.
.PP
dipilototdo returns the transformed polynomial P to a polynomial with total degree ordering.

M*/

/*H
	Version 1	12.08.1992	Th. Weis
   DATE dipilototdo   : 930115
H*/

#include <_pol1.h>

pol dipilototdo(r,P)
single r;
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
    int    BC1;
    list    EL1;

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
       P1 = dipmoad(r,P1,&BC1,&EL1);
       P2 = dipfmo(r,BC1,EL1);
       P3 = dipisum(r,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
