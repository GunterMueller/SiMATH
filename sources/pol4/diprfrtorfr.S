/*M
.SH NAME
diprfrtorfr - distributive polynomial over rational functions over the rationals to rational function over the rationals

.SH SYNOPSIS
.nf
#include<_pol4.h>

rfunc diprfrtorfr(r1, r2, P)  
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
diprfrtorfr returns the polynomial P as a rational function in r1 + r2 variables over the rational numbers.
  
M*/
      
/*H
	Version 1	30.09.1992	Th. Weis
   DATE diprfrtorfr   : 930115
H*/

#include <_pol4.h>

rfunc diprfrtorfr(r1,r2,P)
single r1,r2;
pol    P;
{
/*
 * Fall: P == 0  - Anfang
 */
  if ( P == 0 )  return(0);
/*
 * Fall: P == 0  - Ende
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single i;
    rfunc  F,CP1,P2;
    pol    P1,CP1Z,CP1N,P2Z,P2N;
    vec    EP1,NV;

    bind(P);
    init(F,CP1,P2);
    init(P1,CP1Z,CP1N,P2Z,P2N);
    init(EP1,NV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    F  = 0;
    P1 = P;
    for ( i=r1, NV=_0; i--; )  NV = lcomp(0,NV);
/*
 * Vorbesetzen - Ende
 * Umwandlung Polynom zu Funktion - Anfang
 */
    do {
       P2Z  = _0;
       P2N  = _0;
       CP1  = lfirst(P1);
       P1   = lred(P1);
       EP1  = lfirst(P1);
       P1   = lred(P1);
       CP1Z = lfirst(CP1);
       CP1  = lred(CP1);
       CP1N = lfirst(CP1);
       P2Z  = lcomp2(CP1Z,EP1,P2Z);
       P2Z  = diptop(r1,P2Z);
       P2N  = lcomp2(CP1N,NV,P2N);
       P2N  = diptop(r1,P2N);
       P2   = rfrcons(r1+r2,P2Z,P2N);
       F    = rfrsum(r1+r2,F,P2);
    } while ( P1 != _0 );
/*
 * Umwandlung Polynom zu Funktion - Ende
 * Rueckgabe
 */
    return(F);
  }
}
