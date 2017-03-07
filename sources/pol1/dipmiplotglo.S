/*M
.SH NAME
dipmiplotglo - distributive polynomial over modular integer primes in lexicographical order to distributive polynomial over modular integer primes in graduated lexicographical order

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmiplotglo(r, p, P)  
single r; 
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a distributive polynomial in r variables over Z/pZ.        
P is a polynomial in lexicographical order.
.PP
dipmiplotglo returns the polynomial P as a polynomial in graduated lexicographical order.

.SH SEE ALSO
 dipmiplotlio
 dipmiplottdo

M*/

/*H
	Version 1	29.09.1992	Th. Weis
   DATE dipmiplotglo  : 930115
H*/

#include <_pol1.h>

pol dipmiplotglo(r,p,P)
single r;
int    p;
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

    bind(p,P);
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
       P1 = dipmoad(r,P1,&BC1,&EL1);
       P2 = dipfmo(r,BC1,EL1);
       P3 = dipmipsum(r,p,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
