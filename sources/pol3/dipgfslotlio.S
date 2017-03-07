/*M
.SH NAME
dipgfslotolio - distributive polynomial over Galois-field with single characteristic in lexicographical order to distributive polynomial over Galois-field with single characteristic in lexicographical order with inverse exponent vector

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfslotlio(r, p, AL, P)  
single r, p; 
list AL; 
pol P;
 
.SH DESCRIPTION
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a distributive polynomial over GF(p^n) in r variables. P is a polynomial in lexicographical order.
.PP
dipgfslotlio returns the polynomial P as a polynomial in lexicographical order with regard to the inverse exponent vector.  

.SH SEE ALSO
gfsalgen

M*/

/*H
	Version 1	12.08.1992	Th. Weis
   DATE dipgfslotlio  : 930115
H*/

#include <_pol3.h>

pol dipgfslotlio(r,p,AL,P)
single r,p;
list   AL;
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
    gfel   BC1;
    vec    EL1;

    bind(AL,P);
    init(P1,P2,P3);
    init(BC1);
    init(EL1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    EVORD = 4;
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
       P3 = dipgfssum(r,p,AL,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
