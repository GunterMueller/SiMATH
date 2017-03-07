/*M
.SH NAME
dippicp - distributive polynomial over polynomials over integers content and primitive part

.SH SYNOPSIS
.nf
#include<_pol2.h>

int dippicp(r1, r2, P, pPP)  
single r1, r2; 
pol P, *pPP;

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B P
is a distributive polynomial in r1 variables over a ring of polynomials in r2 variables over the integer numbers.
.PP
dippicp computes the content of the polynomial P (say C) and it's primitive part (say PP). 	The leading coefficient of the leading coefficient of PP is positive.
.PP
dippicp returns C and writes PP to *pPP.
     
M*/

/*H
	Version 1	28.07.1992	Th. Weis
   DATE dippicp       : 930115
H*/

#include <_pol2.h>

static pol dippibcquot(single,single,pol,pol);

pol dippicp(r1,r2,P,pPP)
single r1,r2;
pol    P,*pPP;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  {
     *pPP = P;
     return(0);
  }
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    pol    C,BC,BC1,pQ1,pQ2;
    vec    EL;

    bind(P);
    init(C,BC,BC1,pQ1,pQ2);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * ggT berechnen - Anfang
 */
    *pPP = dipmoad(r1,P,&BC,&EL);
    s    = pisign(r2,BC);
    if ( s < 0 )  BC = pineg(r2,BC);
    while ( *pPP != _0 && BC != 1 ) {
          *pPP = dipmoad(r1,*pPP,&BC1,&EL);
          BC   = pigcdcf(r2,BC,BC1,&pQ1,&pQ2);
    }
/*
 * ggT berechnen - Ende
 * Dividieren - Anfang
 */
    C    = BC;
    *pPP = P;
    if ( oequal(BC,pvinsert(0,1,r2)) == 1 ) {
       if ( s < 0 ) {
          C    = pineg(r2,BC);
          *pPP = dippineg(r1,r2,P);
       }
    }
    else {
         if ( s < 0 )  C = pineg(r2,BC);
         *pPP = dippibcquot(r1,r2,P,C);
    }
/*
 * Dividieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(C);
  }
}



/*c
                         dippibcquot( r1, r2, P, A )        (static)

        "distributive polynomial over polynomials over integers, base
         coefficient quotient"
        Quellbibliothek: srclib.pol2
        Include-Datei:   _pol2.h
        static pol dippibcquot(r1,r2,P,A)  single r1,r2; pol P,A;
        P1C = dippibcquot(r1,r2,P,A);
        Dabei muss gelten:
              - 0 <= r1 < BASIS.
              - 0 <= r2 < BASIS.
              - P ist ein Polynom in r1 Variablen ueber einem Polynomring
                ueber Z in r2 Variablen, wobei die Koeffizientenpolynome
                alle durch das Polynom A teilbar sind.
              - A ist ein Polynom ungleich 0 ueber Z in r2 Variablen (in
                sparse Darstellung).
        P1 = P/A.
c*/

static pol dippibcquot(r1,r2,P,A)
single r1,r2;
pol    P,A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol PP,P1;
  pol BC,C,CR;
  vec EV;

  bind(P,A);
  init(PP,P1,BC,C,CR,EV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 ) return(0);
/*
 * Fall: P = 0  - Ende
 * Fall: P != 0  - Anfang
 * Vorbesetzen - Anfang
 */
  P1 = _0;
  PP = P;
/*
 * Vorbesetzen - Ende
 * Dividieren - Anfang
 */
  do {
     PP = dipmoad(r1,PP,&BC,&EV);
     C  = piqrem(r2,BC,A,&CR);
     P1 = lcomp2(EV,C,P1);
     /* EV und C vertauscht, da spaeter 
        linv(P1) gemacht wird */
  } while ( PP != _0 );
  P1 = linv(P1);
/*
 * Dividieren - Ende
 * Rueckgabe
 */
  return(P1);
}
