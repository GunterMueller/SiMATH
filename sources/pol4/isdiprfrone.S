/*M
.SH NAME
isdiprfrone - is distributive polynomial over rational functions over the rationals one ?

.SH SYNOPSIS
.nf
#include<_pol4.h>

single isdiprfrone(r1, r2, P)  
single r1, r2; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B r1,r2
are integral numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over the rational functions in r2 variables over Q.
.PP
isdiprfrone returns 1, if P = 1, and 0 else.

M*/
                
/*H
	Version 1	16.11.1992	Th. Weis
   DATE isdiprfrone   : 930115
H*/

#include <_pol4.h>

single isdiprfrone(r1,r2,P)
single r1,r2;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(0);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    pol    PS;
    rfunc  BC;
    vec    EL;

    bind(P);
    init(PS,BC,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Test, ob P = 1  - Anfang
 */
    PS = dipmoad(r1,P,&BC,&EL);
    if ( PS != _0 )  return(0);
    if ( dipevsign(r1,EL) != 0 ) return(0);
    return(isrfrone(r2,BC));
/*
 * Test, ob P = 1 & Rueckgabe - Ende
 */
  }
}
