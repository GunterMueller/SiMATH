/*M
.SH NAME
dipmipneg - distributive polynomial over modular integer primes negation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmipneg(r, p, P)  
single r; 
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P
is a distributive polynomial in r variables over Z/pZ.           
.PP
dipmipneg returns the polynomial P1, where
.IP
P1 = -P.

M*/

/*H
	Version 1	29.09.1992	Th. Weis
   DATE dipmipneg     : 930115
H*/

#include <_pol1.h>

pol dipmipneg(r,p,P)
single r;
int    p;
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

    bind(p,P);
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
       BC1 = mineg(p,BC);
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
