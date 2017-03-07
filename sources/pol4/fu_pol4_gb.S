/* DOC_SKIP */

/***********************************************************************

	Funktionen in 'pol4 fuer den Groebner-Basen-Algorithmus

	enthaelt: diprfrmogb	<-- 2. Vers ab Vers. 3.9
		  diprfrnor

***********************************************************************/



/*c
                         diprfrmogb( r1, r2, PL )

        "distributive polynomial over rational functions over the rationals
         minimal ordered Groebner basis"
        Quellbibliothek: srclib.pol4
        Include-Datei:   _pol4.h
        list diprfrmogb(r1,r2,PL)  single r1,r2; list PL;
        PP = diprfrmogb(r1,r2,PL);
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r1 
	(0 <= r1 < BASIS) Variablen ueber rationalen Funktionen in r2 
	(0 <= r2 < BASIS) Variablen ueber Q.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	01.10.1992	Th. Weis
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE diprfrmogb    : 930115.941201
H*/

#include <_pol4.h>

list diprfrmogb(r1,r2,PL)
single r1,r2;
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
    rfunc  BC;

    bind(PL);
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
       EI = dipevl(r1,PIN);
       t  = 0;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);
             PB = lred(PB);
             EJ = dipevl(r1,PJ);
             t  = dipevmt(r1,EI,EJ);
       }
       PB = QP;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);
             PB = lred(PB);
             EJ = dipevl(r1,PJ);
             t  = dipevmt(r1,EI,EJ);
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
       PINP = dipmoad(r1,PIN,&BC,&EL);
       if ( PINP != _0 ) {
          PINP = diprfrnor(r1,r2,PINP,QP);
          if ( PINP != 0 )  PIN = lcomp2(BC,EL,PINP);
          else  PIN = dipfmo(r1,BC,EL);
       }
       PP = lcomp(PIN,PP);
    } while ( PS != _0 );
    PP = linv(PP);
    if ( PP == _0 || lred(PP) == _0 )  return(PP);
/*
 * Normalform - Ende
 * Sortieren - Anfang
 */
    PP = diplpm(r1,PP);
/*
 * Sortieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(PP);
  }
}



/*c
                         diprfrnor( r1, r2, P, PL )

        "distributive polynomial over rational functions over the rationals
         normal form"
        Quellbibliothek: srclib.pol4
        Include-Datei:   _pol4.h
        pol diprfrnor(r1,r2,P,PL)  single r1,r2; pol P; list PL;
        P1 = diprfrnor(r1,r2,P,PL);
        Dabei muss gelten:
              - 0 <= r1 < BASIS.
              - 0 <= r2 < BASIS.
              - P ist ein distributives Polynom in r1 Variablen ueber 
		rationalen Funktionen in r2 Variablen ueber Q.
              - PL ist eine Liste von distributiven Polynomen ungleich 0 
		in r1 Variablen ueber rationalen Funktionen in r2 Variablen 
		ueber Q.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	01.10.1992	Th. Weis
   DATE diprfrnor     : 930115
H*/

/* #include <_pol4.h> */

pol diprfrnor(r1,r2,P,PL)
single r1,r2;
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
    rfunc  BCP,BCQ,BCP1;
    vec    ELP,ELQ,ELP1;

    bind(P,PL);
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
       PS = dipmoad(r1,PS,&BCP,&ELP);
       if ( PS == _0 )  PS = 0;
       PLL = PL;
       do {
          Q  = lfirst(PLL);
          PLL = lred(PLL);
          QP = dipmoad(r1,Q,&BCQ,&ELQ);
          s  = dipevmt(r1,ELP,ELQ);
       } while ( PLL != _0 && s != 1 );
       if ( s == 0 )  P1 = lcomp2(ELP,BCP,P1);
                      /* BCP und ELP vertauscht eingesetzt, da spaeter linv(P1)
                         wieder die richtige Reihenfolge von Koeff. und Expo.-vek. herstellt */
       else  if ( QP != _0 ) {
                ELP1 = dipevdif(r1,ELP,ELQ);
                BCP1 = rfrquot(r2,BCP,BCQ);
                AP   = dipfmo(r1,BCP1,ELP1);
                APP  = diprfrprod(r1,r2,QP,AP);
                PS   = diprfrdif(r1,r2,PS,APP);
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
