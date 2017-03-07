/*M
.SH NAME
dipmipmiprod - distributive polynomial over modular integer primes, modular integer primes product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmipmiprod(r, p, P, A)  
single r; 
int p, A; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B A
is an element of Z/pZ.
.TP 4
.B P
is a distributive polynomial in r variables over Z/pZ.     
.PP
dipmipmiprod returns the polynomial P1, where 
.IP
P1 = A * P.

M*/

/*H
	Version 1	28.09.1992	Th. Weis
   DATE dipmipmiprod  : 930115
H*/

#include <_pol1.h>

pol dipmipmiprod(r,P,POL,A)
single r;
int    P;
pol    POL;
int    A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol    PP,P1;
  int    BC,C;
  list    EV;

  bind(P,POL,A);
  init(BC,C);
  init(PP,P1,EV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Fall: POL = 0 oder A = 0 - Anfang
 */
  if ( POL == 0 || A == 0 ) return(0);
/*
 * Fall: POL = 0 oder A = 0 - Ende
 * Fall: POL != 0 und A != 0 - Anfang
 * Vorbesetzen - Anfang
 */
  P1 = _0;
  PP = POL;
/*
 * Vorbesetzen - Ende
 * Multiplizieren - Anfang
 */
  do {
     PP = dipmoad(r,PP,&BC,&EV);
     C  = miprod(P,A,BC);
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
