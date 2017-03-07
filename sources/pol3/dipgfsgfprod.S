/*M
.SH NAME
dipgfsgfprod distributive polynomial over Galois-field with single characteristic, Galois-field with single characteristic element product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfsgfprod(r, p, AL, P, a)  
single r, p; 
list AL; 
pol P; 
gfel a;
  
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
.TP 4
.B a
is an element in GF(p^n).
.PP
dipgfsgfsprod returns a polynomial over GF(p^n), say P1, where
.IP
P1 = a * P.

.SH SEE ALSO
gfsalgen
                                        
M*/
     
/*H
	Version 1	02.10.1992	Th. Weis
   DATE dipgfsgfprod  : 930115
H*/

#include <_pol3.h>

pol dipgfsgfprod(r,p,AL,P,a)
single r,p;
list   AL;
pol    P;
gfel   a;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol    PP,P1;
  gfel   BC,C;
  vec    EV;

  bind(AL,P,a);
  init(PP,P1,BC,C,EV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Fall: P = 0 oder a = 0 - Anfang
 */
  if ( P == 0 || a == 0 ) return(0);
/*
 * Fall: P = 0 oder a = 0 - Ende
 * Fall: P != 0 und a != 0 - Anfang
 * Vorbesetzen - Anfang
 */
  P1 = _0;
  PP = P;
/*
 * Vorbesetzen - Ende
 * Multiplizieren - Anfang
 */
  do {
     PP = dipmoad(r,PP,&BC,&EV);
     C  = gfsprod(p,AL,a,BC);
     P1 = lcomp2(EV,C,P1);
     /* EV und C vertauscht, da spaeter 
        linv(P1) gemacht wird */
  } while ( PP != _0 );
  P1 = linv(P1);
/*
 * Multiplizieren - Ende
 * Rueckgabe
 */
  return(P1);
}
