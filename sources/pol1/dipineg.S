/*M
.SH NAME
dipineg - distributive polynomial over integers negation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipineg(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over the integer numbers.
.PP
dipineg returns the polynomial P1, where
.IP
P1 = - P.

M*/

/*H
	Version 1	20.07.1992	Th. Weis
   DATE dipineg       : 930115
H*/

#include <_pol1.h>

pol dipineg(r,P)
single r;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(0);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklarartion, Binden & Initialisieren - Anfang
 */
  {
    pol PS,P1;
    int BC,BC1;
    list EL;

    bind(P);
    init(PS,P1);
    init(BC,BC1);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    PS = P;
    P1 = _0;
/*
 * Vorbesetzen - Ende
 * Negieren - Anfang
 */
    do {
       PS  = dipmoad(r,PS,&BC,&EL);
       BC1 = ineg(BC);
       P1  = lcomp2(EL,BC1,P1);
       /* EL und BC1 vertauscht, da spaeter
          linv(P1) gemacht wird */
    } while ( PS != _0 );
    P1 = linv(P1);
/*
 * Negieren - Ende
 * allgemeiner Fall - Emde
 * Rueckgabe
 */
    return(P1);
  }
}
