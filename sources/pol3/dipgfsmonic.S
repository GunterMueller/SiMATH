/*M
.SH NAME
dipgfsmonic - distributive polynomial over Galois-field with single characteristic monic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfsmonic(r, p, AL, P)  
single r, p; 
pol P;

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
.B P
is a distributive polynomial over GF(p^n) in r variables.
.PP
dipgfsmonic returns the monic polynomial associated to P.

.SH SEE ALSO
gfsalgen

M*/                                                       
          
/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipgfsmonic   : 930115
H*/

#include <_pol3.h>

pol dipgfsmonic(r,p,AL,P)
single r,p;
list   AL;
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
    gfel   LBC,LBCinv;
    pol    P1;

    bind(AL,P);
    init(LBC,LBCinv);
    init(P1);
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
    t   = isgfsone(p,AL,LBC);
    if ( t == 1 ) return(P1);
/*
 * Test - Ende
 * Polynom normieren - Anfang
 */
    LBCinv = gfsinv(p,AL,LBC);
    P1     = dipgfsgfprod(r,p,AL,P1,LBCinv);
/*
 * Polynom normieren - Ende
 * Fall: P != 0 - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
