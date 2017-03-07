/*M
.SH NAME
diprfrprod - distributive polynomial over rational functions over the rationals product

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol diprfrprod(r1, r2, P1, P2)  
single r1, r2; 
pol P1, P2;
   
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B P1, P2
are distributive polynomials in r1 variables over rational functions in r2 variables over the rational numbers.
.PP  
diprfrprod returns a polynomial, say P, where
.IP
P = P1 * P2.

M*/
               
/*H
	Version 1	16.11.1992	Th. Weis
   DATE diprfrprod    : 930115
H*/

#include <_pol4.h>
static pol diprfrlsum(single,single,list);
pol diprfrprod(r1,r2,P1,P2)
single r1,r2;
pol    P1,P2;
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
    list  P3,P3S,P31;
    pol   P1S,P1P,P2S,P2P;
    rfunc BC1,BC2,BC3;
    vec   EL1,EL2,EL3;

    bind(P1,P2);
    init(P3,P3S,P31);
    init(P1S,P1P,P2S);
    init(BC1,BC2,BC3);
    init(EL1,EL2,EL3);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    P1S = lcinv(P1);
    P2S = P2;
    P3  = list1(0);
    P3S = P3;
/*
 * Vorbesetzen - Ende
 * Produkt berechnen - Anfang
 */
    do {
       P2S = dipmoad(r1,P2S,&BC2,&EL2);
       P1P = P1S;
       P31 = _0;
       do {
          P1P = dipmoad(r1,P1P,&EL1,&BC1);
          /* Vertauschen von &BC1 und &EL1, da P1P = lcinv(P1), d.h.
             bei P1P stehen jetzt Koeffizient und Exponentenvektor vertauscht */
          BC3 = rfrprod(r2,BC1,BC2);
          EL3 = dipevsum(r1,EL1,EL2);
          P31 = lcomp2(BC3,EL3,P31);
       } while ( P1P != _0 );
       P3 = lcomp(P31,P3);
    } while ( P2S != _0 );
    P31 = lfirst(P3);
    P3  = lred(P3);
          lsfirst(P3S,P31);
          lsred(P3S,P3);
    P3  = diprfrlsum(r1,r2,P3);
/*
 * Produkt berechnen - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}



/*c
                        diprfrlsum( r1, r2, PL )        (static)

        "distributive polynomial over rational functions over the rationals
         list sum"
        static pol diprfrlsum(r1,r2,PL)  single r1,r2; list PL;
        P = diprfrlsum(r1,r2,PL);
        Dabei muss gelten:
              - 0 <= r1 < BASIS.
              - 0 <= r2 < BASIS.
              - PL ist eine "kreisfoermige" Liste von distributiven
		Polynomen in r1 Variablen ueber rationalen Funktionen 
		in r2 Variablen ueber Q.
        P ist die Summe aller Polynome der Liste.
c*/

static pol diprfrlsum(r1,r2,PL)
single r1,r2;
list   PL;
{
/*
 * Fall: PL = ()  - Anfang
 */
  if ( PL == _0 )  return(0);
/*
 * Fall: PL = ()  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    list L,LP,LPP;
    pol  P,PP,PPP;

    bind(PL);
    init(L,LP,LPP);
    init(P,PP,PPP);
/*
 * Deklaration, Binden & Initialiseren - Ende
 * Vorbesetzen - Anfang
 */
    L = PL;
    P = lfirst(L);  LP = lred(L);
/*
 * Vorbesetzen - Ende
 * Polynome aufaddieren - Anfang
 */
    while ( L != LP ) {
          PP  = lfirst(LP);      LPP = lred(LP);
          PPP = diprfrsum(r1,r2,P,PP);
                lsfirst(L,PPP);
                lsred(L,LPP);
          L   = LPP;
          P   = lfirst(L);       LP  = lred(L);
    }
/*
 * Polynome aufaddieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P);
  }
}
