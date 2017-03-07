/*M
.SH NAME
isdippione - is distributive polynomial over polynomials over integers one ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isdippione(r1, r2, P)  
single r1, r2; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over a ring of polynomials in r2 variables over the integer numbers.
.PP
isdippione returns 1, if P is 1, and 0 else.

M*/
                                 
/*H
	Version 1	28.07.1992	Th. Weis
   DATE isdippione    : 930115
H*/

#include <_pol2.h>

single isdippione(r1,r2,P)
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
    int    BC;
    vec    EL;

    bind(P);
    init(PS,BC,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Test, ob P = 1  - Anfang
 */
    PS = dipmoad(r1,P,&BC,&EL);
    if ( oequal(BC,pvinsert(0,1,r2)) != 1 || PS != _0 )  return(0);
    if ( dipevsign(r1,EL) == 0 ) return(1);
    return(0);
/*
 * Test, ob P = 1 & Rueckgabe - Ende
 */
  }
}
