/*M
.SH NAME
dipmipgbr - distributive polynomial over modular integer primes Groebner basis recursion

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dipmipgbr(r, p, PL)  
single r; 
int p; 
list PL;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B PL
is a list of distributive polynomials in r variables over Z/pZ.
.PP
dipmipgbr returns the minimal, normalized and sorted Groebner basis of PL.      
.PP                                                                             
The Groebner basis of PL will be computed recursively, i.e.                     
.PP                                                                             
For PL = ( P1 ... Pn ),                                                         
 - dipmipgbr first computes the minimal, normalized 
   and sorted Groebner basis of P1.                           
 - After that, the polynomial P2 will be added to the                           
   computed Groebner basis, and again dipmipgbr 
   computes the minimal, normalized and sorted Groebner 
   basis.                          
 - This procedure will be repeated for all n polynomials                        
   in PL.                                                                       
           
.SH SEE ALSO
 dipmipgb
 dipmipgba

M*/

/*H
	Version 1	29.09.1992	Th. Weis
   DATE dipmipbgr     : 930115
H*/

#include <_pol1.h>

list dipmipgbr(r,P,PL)
single r;
int    P;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  list PP,PPR;
  pol  POL;

  bind(PL);
  init(PP,PPR);
  init(POL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PP  = _0;
  PPR = PL;
/*
 * Vorbesetzen - Ende
 * Groebner Basen Berechnung - Anfang
 */
  while ( PPR != _0 ) {
        POL = lfirst(PPR);
        PPR = lred(PPR);
        PP  = dipmipgba(r,P,PP,POL);
  }
/*
 * Groebner Basen Berechnung - Ende
 * Rueckgabe
 */
  return(PP);
}
