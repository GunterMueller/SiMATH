/*M
.SH NAME
dipmspprod - distributive polynomial over modular single primes product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmspprod(r, p, P1, P2)  
single r, p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are distributive polynomials in r variables over Z/pZ.       
.PP
dipmspprod returns the polynomial P3, where 
.IP
P3 = P1 * P2.

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipmspprod    : 930115
H*/

#include <_pol1.h>

static pol dipmsplsum(single,single,list);

pol dipmspprod(r,p,P1,P2)
single r,p;
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
    list   P3,P3S,P31;
    pol    P1S,P1P,P2S,P2P;
    single BC1,BC2,BC3;
    list    EL1,EL2,EL3;

    bind(P1,P2);
    init(P3,P3S,P31);
    init(P1S,P1P,P2S);
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
       P2S = dipmoad(r,P2S,&BC2,&EL2);
       P1P = P1S;
       P31 = _0;
       do {
          P1P = dipmoad(r,P1P,&EL1,&BC1);
          /* Vertauschen von &BC1 und &EL1, da P1P = lcinv(P1), d.h.
             bei P1P stehen jetzt Koeffizient und Exponentenvektor vertauscht */
          BC3 = msprod(p,BC1,BC2);
          EL3 = dipevsum(r,EL1,EL2);
          P31 = lcomp2(BC3,EL3,P31);
       } while ( P1P != _0 );
       P3 = lcomp(P31,P3);
    } while ( P2S != _0 );
    P31 = lfirst(P3);        P3 = lred(P3);
          lsfirst(P3S,P31);
          lsred(P3S,P3);
    P3  = dipmsplsum(r,p,P3);
/*
 * Produkt berechnen - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}



/*c
                        dipmsplsum( r, p, PL )        (static)

        "distributive polynomial over modular single primes list sum"
        static pol dipmsplsum(r,p,PL)  single r,p; list PL;
        P = dipmsplsum(r,p,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist eine Primzahl.
              - PL ist eine "kreisfoermige" Liste von Polynomen in r
                Variablen ueber Z/pZ in distributiver Darstellung.
        P ist die Summe aller Polynome der Liste.
c*/

static pol dipmsplsum(r,p,PL)
single r,p;
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
          PPP = dipmspsum(r,p,P,PP);
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
