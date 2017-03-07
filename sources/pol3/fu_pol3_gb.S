/* DOC_SKIP */

/***********************************************************************

	Funktionen in 'pol3 fuer den Groebner-Basen-Algorithmus

	enthaelt: dipgfsmogb	<-- 2. Vers. ab Vers. 3.9
		  dipgfsnor	<-- 2. Vers. ab Vers. 3.9
		  dipnfmogb	<-- 2. Vers. ab Vers. 3.9
		  dipnfnor	<-- 2. Vers. ab Vers. 3.9

***********************************************************************/



/*c
                         dipgfsmogb( r, p, AL, PL )

        "distributive polynomial over Galois-field with single
         characteristic minimal ordered Groebner basis"
        Quellbibliothek: srclib.pol3
        Include-Datei:   _pol3.h
        list dipgfsmogb(r,p,AL,PL)  single r,p; list AL,PL;
        PP = dipgfsmogb(r,p,AL,PL);
        Dabei muss gelten:
              - p ist Primzahl.
	      - AL = (G,AL1) kann als Arithmetikliste fuer GF(p^n)
                interpretiert werden (siehe gfsalgen), wobei
                n = llength(AL1)+1.
              - PL ist eine Liste von distributiven Polynomen ungleich 0
		in r (0 <= r < BASIS) Variablen ueber GF(p^n).
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	02.10.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipgfsmogb    : 930115.941201
H*/

#include <_pol3.h>

list dipgfsmogb(r,p,AL,PL)
single r,p;
list   AL,PL;
{
/*
 * Fall: PL = ()  oder  PL = (A)  - Anfang
 */
  if ( PL == _0 || lred(PL) == _0 )  return(PL);
/*
 * Fall: PL = ()  oder  PL = (A)  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single t;
    list   PP,PS,PIN,PINP,PJ,PB,QP;
    vec    EI,EJ,EL;
    gfel   BC;

    bind(AL,PL);
    init(PP,PS,PIN,PINP,PJ,PB,QP);
    init(EI,EJ,EL);
    init(BC);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen & Exponentenvektorsuche - Anfang
 */
    PP = PL;
    PS = PP;
    QP = _0;
    do {
       PIN = lfirst(PS);
       PS = lred(PS);
       PB = PS;
       EI = dipevl(r,PIN);
       t  = 0;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);
             PB = lred(PB);
             EJ = dipevl(r,PJ);
             t  = dipevmt(r,EI,EJ);
       }
       PB = QP;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);
             PB = lred(PB);
             EJ = dipevl(r,PJ);
             t  = dipevmt(r,EI,EJ);
       }
       if ( t == 0 )  QP = lcomp(PIN,QP);
    } while ( PS != _0 );
    PP = linv(QP);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
/*
 * Vorbesetzen & Exponentenvektorsuche - Ende
 * Normalform - Anfang
 */
    PS = PP;
    QP = PP;
    PP = _0;
    do {
       PIN  = lfirst(PS);
       PS  = lred(PS);
       PINP = dipmoad(r,PIN,&BC,&EL);
       if ( PINP != _0 ) {
          PINP = dipgfsnor(r,p,AL,PINP,QP);
          if ( PINP != 0 )  PIN = lcomp2(BC,EL,PINP);
          else  PIN = dipfmo(r,BC,EL);
       }
       PP = lcomp(PIN,PP);
    } while ( PS != _0 );
    PP = linv(PP);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
/*
 * Normalform - Ende
 * Sortieren - Anfang
 */
    PP = diplpm(r,PP);
/*
 * Sortieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                         dipgfsnor( r, p, AL, P, PL )

        "distributive polynomial over Galois-field with single
         characteristic normal form"
        Quellbibliothek: srclib.pol3
        Include-Datei:   _pol3.h
        pol dipgfsnor(r,p,AL,P,PL)  single r,p; list AL; pol P; list PL;
        P1 = dipgfsnor(r,p,AL,P,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist Primzahl.
	      - AL = (G,AL1) kann als Arithmetikliste fuer GF(p^n)
                interpretiert werden (siehe gfsalgen), wobei
                n = llength(AL1)+1.
              - P ist ein distributives Polynom in r Variablen ueber 
		GF(p^n).
              - PL ist eine Liste von distributiven Polynomen ungleich 0 
		in r Variablen ueber GF(p^n).
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	02.10.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipgfsnor     : 930115.941201
H*/

/* #include <_pol3.h> */

pol dipgfsnor(r,p,AL,P,PL)
single r,p;
list   AL;
pol    P;
list   PL;
{
/*
 * Fall: P = 0  oder  PL = ()  - Anfang
 */
  if ( P == 0 || PL == _0 )  return(P);
/*
 * Fall: P = 0  oder  PL = ()  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    list   PLL;
    pol    P1,PS,Q,QP,AP,APP;
    gfel   BCP,BCQ,BCP1;
    vec    ELP,ELQ,ELP1;

    bind(AL,P,PL);
    init(PLL);
    init(P1,PS,Q,QP,AP,APP);
    init(BCP,BCQ,BCP1);
    init(ELP,ELQ,ELP1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Berechnung der Normalform von P - Anfang
 */
    P1 = _0;
    PS = P;
/*
 * Reduktionsschritt
 */
    do {
       PS = dipmoad(r,PS,&BCP,&ELP);
       if ( PS == _0 )  PS = 0;
       PLL = PL;
       do {
          Q   = lfirst(PLL);
          PLL = lred(PLL);
          QP  = dipmoad(r,Q,&BCQ,&ELQ);
          s   = dipevmt(r,ELP,ELQ);
       } while ( PLL != _0 && s != 1 );
       if ( s == 0 )  P1 = lcomp2(ELP,BCP,P1);
                      /* BCP und ELP vertauscht eingesetzt, da spaeter linv(P1)
                         wieder die richtige Reihenfolge von Koeff. und Expo.-vek. herstellt */
       else  if ( QP != _0 ) {
                ELP1 = dipevdif(r,ELP,ELQ);
                BCP1 = gfsquot(p,AL,BCP,BCQ);
                AP   = dipfmo(r,BCP1,ELP1);
                APP  = dipgfsprod(r,p,AL,QP,AP);
                PS   = dipgfsdif(r,p,AL,PS,APP);
             }
    } while ( PS != 0 );
    if ( P1 == _0 )  P1 = 0;
    else  P1 = linv(P1);
/*
 * Berechnung der Normalform von P - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P1);
  }
}



/*c
                         dipnfmogb( r, F, PL )

        "distributive polynomial over number field minimal ordered
         Groebner basis"
        Quellbibliothek: srclib.pol3
        Include-Datei:   _pol3.h
        list dipnfmogb(r,F,PL)  single r; pol F; list PL;
        PP = dipnfmogb(r,F,PL);
        Dabei muss gelten:
	      - F ist ein irreduzibles Polynom in einer Variablen ueber Z
		vom Grad >= 1 in dense-Darstellung, das den Zahlkoerper k 
		erzeugt.
              - PL ist eine Liste von distributiven Polynomen ungleich 0
                in r (0 <= r < BASIS) Variablen ueber k.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	29.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipnfmogb     : 930115.941201
H*/

/* #include <_pol3.h> */

list dipnfmogb(r,F,PL)
single r;
pol    F;
list   PL;
{
/*
 * Fall: PL = ()  oder  PL = (A)  - Anfang
 */
  if ( PL == _0 || lred(PL) == _0 )  return(PL);
/*
 * Fall: PL = ()  oder  PL = (A)  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single t;
    list   PP,PS,PIN,PINP,PJ,PB,QP;
    vec    EI,EJ,EL;
    nfel   BC;

    bind(F,PL);
    init(PP,PS,PIN,PINP,PJ,PB,QP);
    init(EI,EJ,EL);
    init(BC);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen & Exponentenvektorsuche - Anfang
 */
    PP = PL;
    PS = PP;
    QP = _0;
    do {
       PIN = lfirst(PS);    PS = lred(PS);
       PB = PS;
       EI = dipevl(r,PIN);
       t  = 0;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);        PB = lred(PB);
             EJ = dipevl(r,PJ);
             t  = dipevmt(r,EI,EJ);
       }
       PB = QP;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);        PB = lred(PB);
             EJ = dipevl(r,PJ);
             t  = dipevmt(r,EI,EJ);
       }
       if ( t == 0 )  QP = lcomp(PIN,QP);
    } while ( PS != _0 );
    PP = linv(QP);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
/*
 * Vorbesetzen & Exponentenvektorsuche - Ende
 * Normalform - Anfang
 */
    PS = PP;
    QP = PP;
    PP = _0;
    do {
       PIN  = lfirst(PS);              PS = lred(PS);
       PINP = dipmoad(r,PIN,&BC,&EL);
       if ( PINP != _0 ) {
          PINP = dipnfnor(r,F,PINP,QP);
          if ( PINP != 0 )  PIN = lcomp2(BC,EL,PINP);
          else  PIN = dipfmo(r,BC,EL);
       }
       PP = lcomp(PIN,PP);
    } while ( PS != _0 );
    PP = linv(PP);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
/*
 * Normalform - Ende
 * Sortieren - Anfang
 */
    PP = diplpm(r,PP);
/*
 * Sortieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                         dipnfnor( r, F, P, PL )

        "distributive polynomial over number field normal form"
        Quellbibliothek: srclib.pol3
        Include-Datei:   _pol3.h
        pol dipnfnor(r,F,P,PL)  single r; pol F,P; list PL;
        P1 = dipnfnor(r,F,P,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
	      - F ist ein irreduzibles Polynom in einer Variablen ueber Z
		vom Grad >= 1 in dense-Darstellung, das den Zahlkoerper k 
		erzeugt.
              - P ist ein distributives Polynom in r Variablen ueber k.
              - PL ist eine Liste von distributiven Polynomen ungleich 0 
		in r Variablen ueber k.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	29.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipnfnor      : 930115.941201
H*/

/* #include <_pol3.h> */

pol dipnfnor(r,F,P,PL)
single r;
pol    F,P;
list   PL;
{
/*
 * Fall: P = 0  oder  PL = ()  - Anfang
 */
  if ( P == 0 || PL == _0 )  return(P);
/*
 * Fall: P = 0  oder  PL = ()  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    list   PLL;
    pol    P1,PS,Q,QP,AP,APP;
    nfel   BCP,BCQ,BCP1;
    vec    ELP,ELQ,ELP1;

    bind(F,P,PL);
    init(PLL);
    init(P1,PS,Q,QP,AP,APP);
    init(BCP,BCQ,BCP1);
    init(ELP,ELQ,ELP1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Berechnung der Normalform von P - Anfang
 */
    P1 = _0;
    PS = P;
/*
 * Reduktionsschritt
 */
    do {
       PS = dipmoad(r,PS,&BCP,&ELP);
       if ( PS == _0 )  PS = 0;
       PLL = PL;
       do {
          Q  = lfirst(PLL);
          PLL = lred(PLL);
          QP = dipmoad(r,Q,&BCQ,&ELQ);
          s  = dipevmt(r,ELP,ELQ);
       } while ( PLL != _0 && s != 1 );
       if ( s == 0 )  P1 = lcomp2(ELP,BCP,P1);
                      /* BCP und ELP vertauscht eingesetzt, da spaeter linv(P1)
                         wieder die richtige Reihenfolge von Koeff. und Expo.-vek. herstellt */
       else  if ( QP != _0 ) {
                ELP1 = dipevdif(r,ELP,ELQ);
                BCP1 = nfquot(F,BCP,BCQ);
                AP   = dipfmo(r,BCP1,ELP1);
                APP  = dipnfprod(r,F,QP,AP);
                PS   = dipnfdif(r,F,PS,APP);
             }
    } while ( PS != 0 );
    if ( P1 == _0 )  P1 = 0;
    else  P1 = linv(P1);
/*
 * Berechnung der Normalform von P - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
