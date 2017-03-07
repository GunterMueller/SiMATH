/*M
.SH NAME
dipiiprod - distributive polynomial over integers, integer product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipiiprod(r, P, A)  
single r; 
pol P; 
int A;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over the integer numbers.
.TP 4
.B A
is an integer number.
.PP
dipiiprod returns the polynomial P1, where
.IP
P1 = A * P.

M*/

/*H
	Version 1	20.07.1992	Th. Weis
   DATE dipiiprod     : 930115
H*/

#include <_pol1.h>

pol dipiiprod(r,P,A)
single r;
pol    P;
int    A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol  PP,P1;
  int  BC,C;
  list EV;

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
     PP = dipmoad(r,PP,&BC,&EV);
     C  = iprod(A,BC);
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
