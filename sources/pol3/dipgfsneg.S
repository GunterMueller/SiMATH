/*M
.SH NAME
dipgfsneg - distributive polynomial over Galois-field with single characteristic negation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfsneg(r, p, AL, P)  
single r, p; 
list AL; 
pol P;

.SH DESCRIPTION
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
dipgfsneg returns a polynomial over GF(p^n), say P1, where
.IP
P1 = -P.

.SH SEE ALSO
gfsalgen

M*/
                
/*H
	Version 1	02.10.1992	Th. Weis
   DATE dipgfsneg     : 930115
H*/

#include <_pol3.h>

pol dipgfsneg(r,p,AL,P)
single r,p;
list   AL;
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
    pol    PS,P1;
    gfel   BC,BC1;
    vec    EL;

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
       BC1 = gfsneg(p,AL,BC);
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
