/*M
.SH NAME
dipnfmonic - distributive polynomial over number field monic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipnfmonic(r, F, P)  
single r; 
pol F, P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a distributive polynomial in r variables over K.       
.PP
dipnfmonic returns the monic polynomial associated to P.          

M*/
        
/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipnfmonic    : 930115
H*/

#include <_pol3.h>

pol dipnfmonic(r,F,P)
single r;
pol    F,P;
{
/*
 * Fall: P = 0 - Anfang
 */
  if ( P == 0 ) return(0);
/*
 * Fall: P = 0 - Ende
 * Fall: P != 0 - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single t;
    nfel   LBC,LBCinv;
    pol    P1;

    bind(F,P);
    init(LBC,LBCinv,P1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    P1  = P;
/*
 * Vorbesetzen - Ende
 * Test: Ist der fuehrende Koeffizient = 1 - Anfang
 * wenn ja, Rueckgabe
 */
    LBC = diplbc(r,P);
    t   = isnfone(F,LBC);
    if ( t == 1 ) return(P1);
/*
 * Test - Ende
 * Polynom normieren - Anfang
 */
    LBCinv = nfinv(F,LBC);
    P1     = dipnfnfprod(r,F,P1,LBCinv);
/*
 * Polynom normieren - Ende
 * Fall: P != 0 - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
