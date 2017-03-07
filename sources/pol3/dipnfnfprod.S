/*M
.SH NAME
dipnfnfprod - distributive polynomial over number field, number field element product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipnfnfprod(r, F, P, A)  
single r; 
pol F, P; 
nfel A;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a distributive polynomial in r variables over K.       
.TP 4
.B A
is an element in K.
.PP
dipnfnfprod returns a polynomial over K, say P1, where
.IP
P1 = A * P.

M*/
      
/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipnfnfprod   : 930115
H*/

#include <_pol3.h>

pol dipnfnfprod(r,F,P,A)
single r;
pol    F,P;
nfel   A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol    PP,P1;
  nfel   BC,C;
  vec    EV;

  bind(F,P);
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
     C  = nfprod(F,A,BC);
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
