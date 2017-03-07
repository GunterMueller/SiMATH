/*M
.SH NAME
dipnfbgr - distributive polynomial over number field Groebner basis recursion

.SH SYNOPSIS
.nf
#include<_pol3.h>

list dipnfgbr(r, F, PL)  
single r; 
pol F; 
list PL;
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K. 
.TP 4
.B PL
is a list of distributive polynomials in r variables over K.
.PP
dipnfgb returns the minimal, monic and ordered Groebner basis of PL.
.PP
The Groebner basis of PL will be computed recursively, i.e.
.PP
For PL = ( P1 ... Pn ),
 - dipnfgbr first computes the minimal, monic and
   ordered Groebner basis of P1.
 - After that, the polynomial P2 will be added to the
   computed Groebner basis, and again dipnfgbr computes
   the minimal, monic and ordered Groebner basis.
 - This procedure will be repeated for all n polynomials
   in PL.
                                                  
M*/
                 
/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipnfgbr      : 930115
H*/

#include <_pol3.h>

list dipnfgbr(r,F,PL)
single r;
pol    F;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  list PP,PPR;
  pol  P;

  bind(F,PL);
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
        PP = dipnfgba(r,F,PP,P);
  }
/*
 * Groebner Basen Berechnung - Ende
 * Rueckgabe
 */
  return(PP);
}
