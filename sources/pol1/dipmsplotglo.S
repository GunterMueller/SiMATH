/*M
.SH NAME
dipmsplotglo - distributive polynomial over modular single primes in lexicographical order to distributive polynomial over modular single primes in graduated lexicographical order

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmsplotglo(r, p, P)  
single r, p; 
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
dipmsplotglo returns the polynomial P as a polynomial in graduated lexicographical order.

.SH SEE ALSO
 dipmsplotlio
 dipmsplottdo

M*/

/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipmsplotglo  : 930115
H*/

#include <_pol1.h>

pol dipmsplotglo(r,p,P)
single r,p;
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
    single BC1;
    list    EL1;

    bind(P);
    init(P1,P2,P3);
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
       P3 = dipmspsum(r,p,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
