/*M
.SH NAME
diprfrmonic - distributive polynomial over rational functions over the rationals monic

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol diprfrmonic(r1, r2, P)  
single r1, r2; 
pol P;
     
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over rational functions in r2 variables over the rational numbers.
.PP
diprfrmonic returns the monic polynomial associated to P.

M*/
  
/*H
	Version 1	16.11.1992	Th. Weis
   DATE diprfrmonic   : 930115
H*/

#include <_pol4.h>

pol diprfrmonic(r1,r2,P)
single r1,r2;
pol    P;
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
    rfunc  LBC,LBCinv;
    pol    P1;

    bind(P);
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
    LBC = diplbc(r1,P);
    t   = isrfrone(r2,LBC);
    if ( t == 1 ) return(P1);
/*
 * Test - Ende
 * Polynom normieren - Anfang
 */
    LBCinv = rfrinv(r2,LBC);
    P1     = diprfrrfprod(r1,r2,P1,LBCinv);
/*
 * Polynom normieren - Ende
 * Fall: P != 0 - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
