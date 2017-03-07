/*M
.SH NAME
dipmspmsprod - distributive polynomial over modular single primes, modular single primes product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmspmsprod(r, p, P, a)  
single r, p, a; 
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
.TP 4
.B a
is an element of Z/pZ.
.PP
dipmspmsprod returns the polynomial P1, where
.IP
P1 = a * P.

M*/

/*H
	Version 1	28.07.1992	Th. Weis
   DATE dipmspmsprod  : 930115
H*/

#include <_pol1.h>

pol dipmspmsprod(r,p,P,a)
single r,p;
pol    P;
single a;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol    PP,P1;
  single BC,C;
  list    EV;

  bind(P);
  init(PP,P1,EV);
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
     C  = msprod(p,a,BC);
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
