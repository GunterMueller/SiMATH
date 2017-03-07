/*M
.SH NAME
dippigbr - distributive polynomial over polynomials over integers Groebner basis recursion

.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippigbr(r1, r2, PL)  
single r1, r2; 
list PL;

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B PL
is a list, consisting of distributive polynomials in r1 variables over a ring of
polynomials in r2 variables over the integer numbers.        
.PP
dippigbr returns the minimal, normalized and ordered Groebner basis of PL.
.PP
The Groebner basis of PL will be computed recursively, i.e.
.PP
For PL = ( P1 ... Pn ),
 - dippigbr first computes the minimal, normalized and
   sorted Groebner basis of P1.
 - After that, the polynomial P2 will be added to the
   computed Groebner basis, and again dippigbr computes
   the minimal, normalized and sorted Groebner basis.
 - This procedure will be repeated for all n polynomials
   in PL.
                                                                    
M*/
                         
/*H
	Version 1	28.07.1992	Th. Weis
   DATE dippigbr      : 930115
H*/

#include <_pol2.h>

list dippigbr(r1,r2,PL)
single r1,r2;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  list PP,PPR;
  pol  P;

  bind(PL);
  init(PP,PPR);
  init(P);
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
        P = lfirst(PPR);  PPR = lred(PPR);
        PP = dippigba(r1,r2,PP,P);
  }
/*
 * Groebner Basen Berechnung - Ende
 * Rueckgabe
 */
  return(PP);
}
