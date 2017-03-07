/*M
.SH NAME
dipnfsp - distributive polynomial over number field S-polynomial

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipnfsp(r, F, P1, P2)  
single r; 
pol F, P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial of degree >= 1 in dense representation over Z. F generates a number field, say K.
.TP 4
.B P1, P2
are distributive polynomials in r variables over K.
.PP
dipnfsp returns the S-polynomial P3 of P1 and P2.
.TP 4
Let
 f be the leading monomial of P1, and
 g the leading monomial of P2, then
.PP
the S-polynomial P3 arise from
.IP
P3 = lcm(f, g)/f*P1 - lcm(f, g)/g*P2.

.SH SEE ALSO
B. Buchberger : "Ein algorithmisches Kriterium fuer die
                 Loesbarkeit eines algebraischen
                 Gleichungssystems"
 (Aequationes mathematicae, Vol.4, 1970)

M*/                                                 

/*H
	Verison 1	29.07.1992	Th. Weis
   DATE dipnfsp       : 930115
H*/

#include <_pol3.h>

pol dipnfsp(r,F,P1,P2)
single r;
pol    F,P1,P2;
{
/*
 * Fall: P1 = 0  oder  P2 = 0  - Anfang
 */
  if ( P1 == 0 || P2 == 0 )  return(0);
/*
 * Fall: P1 = 0  oder  P2 = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    pol    P1P,P1PP;
    pol    P2P,P2PP;
    pol    P3;
    nfel   BC1,BC2,BC3;
    vec    EL1,EL11,EL2,EL21,EL3;

    bind(F,P1,P2);
    init(P1P,P1PP);
    init(P2P,P2PP);
    init(P3);
    init(BC1,BC2,BC3);
    init(EL1,EL11,EL2,EL21,EL3);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Berechnung des S-Polynoms - Anfang
 */
    P1P = dipmoad(r,P1,&BC1,&EL1);
    P2P = dipmoad(r,P2,&BC2,&EL2);
    if ( P1P == _0 && P2P == _0 )  return(0);
    EL3 = dipevlcm(r,EL1,EL2);
    if ( P1P == _0 ) {
       EL21 = dipevdif(r,EL3,EL2);
       BC3  = nfneg(F,BC1);
       P2PP = dipfmo(r,BC3,EL21);
       P3   = dipnfprod(r,F,P2P,P2PP);
       return(P3);
    }
    if ( P2P == _0 ) {
       EL11 = dipevdif(r,EL3,EL1);
       P1PP = dipfmo(r,BC2,EL11);
       P3   = dipnfprod(r,F,P1P,P1PP);
       return(P3);
    }
    EL11 = dipevdif(r,EL3,EL1);
    EL21 = dipevdif(r,EL3,EL2);
    P1PP = dipfmo(r,BC2,EL11);
    P2PP = dipfmo(r,BC1,EL21);
    P1PP = dipnfprod(r,F,P1P,P1PP);
    P2PP = dipnfprod(r,F,P2P,P2PP);
    P3   = dipnfdif(r,F,P1PP,P2PP);
/*
 * Berechnung des S-Polynoms - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
