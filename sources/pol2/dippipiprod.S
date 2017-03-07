/*M
.SH NAME
dippipiprod - distributive polynomial over polynomials over integers, polynomial over integers product

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol dippipiprod(r1, r2, P, A)  
single r1, r2; 
pol P, A;
  
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over a ring of polynomials in r2 variables over the integer numbers.   
.TP 4
.B A
is a distributive polynomial in r2 variables over the integer numbers (in sparse representation).
.PP
dippipiprod returns the polynomial P1, where
.IP
P1 = A * P1.
 
M*/
      
/*H
	Version 1	28.07.1992	Th. Weis
   DATE dippipiprod   : 930115
H*/

#include <_pol2.h>

pol dippipiprod(r1,r2,P,A)
single r1,r2;
pol    P,A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol PP,P1;
  pol BC,C;
  vec EV;

  bind(P,A);
  init(PP,P1,BC,C,EV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Fall: P = 0 oder A = 0 - Anfang
 */
  if ( P == 0 || A == 0 ) return(0);
/*
 * Fall: P = 0 oder A = 0 - Ende
 * Fall: P != 0 und A != 0 - Anfang
 * Vorbesetzen - Anfang
 */
  P1 = _0;
  PP = P;
/*
 * Vorbesetzen - Ende
 * Multiplizieren - Anfang
 */
  do {
     PP = dipmoad(r1,PP,&BC,&EV);
     C  = piprod(r2,A,BC);
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
