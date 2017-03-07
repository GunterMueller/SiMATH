/*M
.SH NAME
dipgfsprod - distributive polynomial over Galois-field with single characteristic product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol dipgfsprod(r, p, AL, P1, P2)  
single r, p; 
list AL; 
pol P1, P2;

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
.B P1, P2
are distributive polynomials in r variables over GF(p^n).
.PP
dipgfsprod returns a polynomial over GF(p^n), say P3, where
.IP
P3 = P1 * P2.

.SH SEE ALSO
gfsalgen

M*/
                                                
/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipgfsprod    : 930115
H*/

#include <_pol3.h>
static pol dipgfslsum(single,single,list,list);
pol dipgfsprod(r,p,AL,P1,P2)
single r,p;
list   AL;
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
    gfel   BC1,BC2,BC3;
    vec    EL1,EL2,EL3;

    bind(AL,P1,P2);
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
       P2S = dipmoad(r,P2S,&BC2,&EL2);
       P1P = P1S;
       P31 = _0;
       do {
          P1P = dipmoad(r,P1P,&EL1,&BC1);
          /* Vertauschen von &BC1 und &EL1, da P1P = lcinv(P1), d.h.
             bei P1P stehen jetzt Koeffizient und Exponentenvektor vertauscht */
          BC3 = gfsprod(p,AL,BC1,BC2);
          EL3 = dipevsum(r,EL1,EL2);
          P31 = lcomp2(BC3,EL3,P31);
       } while ( P1P != _0 );
       P3 = lcomp(P31,P3);
    } while ( P2S != _0 );
    P31 = lfirst(P3);
    P3  = lred(P3);
          lsfirst(P3S,P31);
          lsred(P3S,P3);
    P3  = dipgfslsum(r,p,AL,P3);
/*
 * Produkt berechnen - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P3);
  }
}



/*c
                        dipgfslsum( r, p, AL, PL )        (static)

        "distributive polynomial over Galois-field with single
         characteristic list sum"
        static pol dipgfslsum(r,p,AL,PL)  single r,p; list AL,PL;
        P = dipgfslsum(r,p,AL,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist Primzahl.
	      - AL = (G,AL1) kann als Arithmetikliste fuer GF(p^n)
                interpretiert werden (siehe gfsalgen), wobei
                n = llength(AL1)+1.
              - PL ist eine "kreisfoermige" Liste von distributiven 
		Polynomen in r Variablen ueber GF(p^n).
        P ist die Summe aller Polynome der Liste.
c*/

static pol dipgfslsum(r,p,AL,PL)
single r,p;
list   AL,PL;
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

    bind(AL,PL);
    init(L,LP,LPP);
    init(P,PP,PPP);
/*
 * Deklaration, Binden & Initialiseren - Ende
 * Vorbesetzen - Anfang
 */
    L  = PL;
    P  = lfirst(L);
    LP = lred(L);
/*
 * Vorbesetzen - Ende
 * Polynome aufaddieren - Anfang
 */
    while ( L != LP ) {
          PP  = lfirst(LP);
          LPP = lred(LP);
          PPP = dipgfssum(r,p,AL,P,PP);
                lsfirst(L,PPP);
                lsred(L,LPP);
          L   = LPP;
          P   = lfirst(L);
          LP  = lred(L);
    }
/*
 * Polynome aufaddieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P);
  }
}
