/*M
.SH NAME
rfrtodiprfr - rational function over the rationals to distributive polynomial over rational functions over the rationals

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol rfrtodiprfr(r1, r2, F)  
single r1, r2; 
rfunc F;

.SH DESCRIPTION
.TP 4
.B r1, r2
are integral numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B F 
is a rational function in r1+r2 variables over Q, the denominator of F has to be a polynomial in r2 variables over Q.
.PP
rfrtodiprfr returns F as a distributive polynomial in r1 variables over the rational functions in r2 variables over Q.

M*/
          
/*H
	Version 1	30.09.1992	Th. Weis
   DATE rfrtodiprfr   : 930115
H*/

#include <_pol4.h>

pol rfrtodiprfr(r1,r2,F)
single r1,r2;
rfunc  F;
{
/*
 * Fall: F == 0  - Anfang
 */
  if ( F == 0 )  return(0);
/*
 * Fall: F == 0  - Ende
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    rfunc F1,CPZ,CPN,CP;
    pol   PZ,PN,P;
    vec   EPZ;

    bind(F);
    init(F1,CPZ,CPN,CP);
    init(PZ,PN,P);
    init(EPZ);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    P  = _0;
    F1 = F;
    PZ = lfirst(F1);
    F1 = lred(F1);
    PN = lfirst(F1);
/*
 * Vorbesetzen - Ende
 * Umwandlung Funktion zu Polynom - Anfang
 */
    PZ = ptodip(r1,PZ);
    PN = ptodip(r1,PN);
    if ( isnullvec(lsecond(PN)) == 1 ) {
       CPN = pitorfr(r2,lfirst(PN));
       do {
          CPZ = lfirst(PZ);
          PZ  = lred(PZ);
          EPZ = lfirst(PZ);
          PZ  = lred(PZ);
          CPZ = pitorfr(r2,CPZ);
          CP  = rfrquot(r2,CPZ,CPN);
          P   = lcomp2(EPZ,CP,P);
       } while ( PZ != _0 );
       P = linv(P);
    }
/*
 * Umwandlung Funktion zu Polynom - Ende
 * Rueckgabe
 */
    return(P);
  }
}
