/*M
.SH NAME
dipgfsgbr - distributive polynomial over Galois-field with single characteristic Groebner basis recursion

.SH SYNOPSIS
.nf
#include<_pol3.h>

list dipgfsgbr(r, p, AL, PL)  
single r, p; 
list AL, PL;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B PL
is a list of distributive polynomials in r variables over GF(p^n).          
.PP
dipgfsgb returns the minimal, monic and ordered Groebner basis of PL.
.PP
The Groebner basis of PL will be computed recursively, i.e.
.PP
For PL = ( P1 ... Pn ), 
 - dipgfsgbr first computes the minimal, monic and 
   ordered Groebner basis of P1.
 - After that, the polynomial P2 will be added to the
   computed Groebner basis, and again dipgfsgbr computes
   the minimal, monic and ordered Groebner basis.
 - This procedure will be repeated for all n polynomials
   in PL.
     
.SH SEE ALSO
gfsalgen

M*/
                      
/*H
	Version 1	02.10.1992	Th. Weis
   DATE dipgfsgbr     : 930115
H*/

#include <_pol3.h>

list dipgfsgbr(r,p,AL,PL)
single r,p;
list   AL,PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  list PP,PPR;
  pol  P;

  bind(AL,PL);
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
        P   = lfirst(PPR);
        PPR = lred(PPR);
        PP  = dipgfsgba(r,p,AL,PP,P);
  }
/*
 * Groebner Basen Berechnung - Ende
 * Rueckgabe
 */
  return(PP);
}
