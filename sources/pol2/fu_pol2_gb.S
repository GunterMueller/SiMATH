/* DOC_SKIP */

/***********************************************************************

	Funktionen in 'pol2 fuer den Groebner-Basen-Algorithmus

	enthaelt: dippimogb	<-- 2. Vers. ab Vers. 3.9
		  dippinor	<-- 2. Vers. ab Vers. 3.9

***********************************************************************/



/*c
                         dippimogb( r1, r2, PL )

        "distributive polynomial over polynomials over integers minimal
         ordered Groebner basis"
        Quellbibliothek: srclib.pol2
        Include-Datei:   _pol2.h
        list dippimogb(r1,r2,PL)  single r1,r2; list PL;
        PP = dippimogb(r1,r2,PL);
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r1
	(0 <= r1 < BASIS) Variablen ueber einem Polynomring ueber Z in 
	r2 (0 <= r2 < BASIS) Variablen.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	28.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dippimogb     : 930115.941201
H*/

#include <_pol2.h>

list dippimogb(r1,r2,PL)
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
    list   P,PP,PS,PIN,PINP,PJ,PB,QP;
    vec    EI,EJ,EL;
    pol    C,BC;

    bind(PL);
    init(P,PP,PS,PIN,PINP,PJ,PB,QP);
    init(EI,EJ,EL);
    init(C,BC);
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
       EI = dipevl(r1,PIN);
       t  = 0;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);        PB = lred(PB);
             EJ = dipevl(r1,PJ);
             t  = dipevmt(r1,EI,EJ);
       }
       PB = QP;
       while ( PB != _0 && t == 0 ) {
             PJ = lfirst(PB);        PB = lred(PB);
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
       PIN  = lfirst(PS);              PS = lred(PS);
       PINP = dipmoad(r1,PIN,&BC,&EL);
       if ( PINP != _0 ) {
          P  = dipfmo(r1,BC,EL);
          PIN = dippinor(r1,r2,PINP,QP,P);
          C  = dippicp(r1,r2,PIN,&PIN);
       }
       PP = lcomp(PIN,PP);
    } while ( PS != _0 );
    PP = linv(PP);
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
                         dippinor( r1, r2, P, PL, PP )

        "distributive polynomial over polynomials over integers normal
         form"
        Quellbibliothek: srclib.pol2
        Include-Datei:   _pol2.h
        pol dippinor(r1,r2,P,PL,PP)  single r1,r2; pol P; list PL; pol PP;
        P1 = dipprnor(r1,r2,P,PL,PP);
        Dabei muss gelten:
              - 0 <= r1 < BASIS.
              - 0 <= r2 < BASIS.
              - P und PP sind distributive Polynome in r1 Variablen ueber 
		einem Polynomring ueber Z in r2 Variablen.
              - PL ist eine Liste von distributiven Polynomen ungleich 0 
		in r1 Variablen ueber einem Polynomring ueber Z in r2 
		Variablen.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	28.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dippinor      : 930115.941201
H*/

/* #include <_pol2.h> */

pol dippinor(r1,r2,P,PL,PP)
single r1,r2;
pol    P;
list   PL;
pol    PP;
{
/*
 * Fall: P = 0  oder  PL = ()  - Anfang
 */
  if ( P == 0 )  return(PP);
  if ( PL == _0 )
     if ( PP == 0 )  return(P);
     else  return(lcconc(PP,P));
/*
 * Fall: P = 0  oder  PL = ()  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    list   PLL;
    pol    P1,P1P,P1S,PS,R,RP,PA,PAA;
    pol    BCPS,BCR,BC1,BC2,BC3;
    vec    ELPS,ELR,EL;

    bind(P,PL,PP);
    init(PLL);
    init(P1,P1P,P1S,PS,R,RP,PA,PAA);
    init(BCPS,BCR,BC1,BC2,BC3);
    init(ELPS,ELR,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Berechnung der Normalform von P - Anfang
 */
    PS = P;
    P1 = PP;
/*
 * Reduktionsschritt
 */
    do {
       PS = dipmoad(r1,PS,&BCPS,&ELPS);
       if ( PS == _0 )  PS = 0;
       PLL = PL;
       do {
          R   = lfirst(PLL);
          PLL = lred(PLL);
          RP  = dipmoad(r1,R,&BCR,&ELR);
          s   = dipevmt(r1,ELPS,ELR);
       } while ( PLL != _0 && s != 1 );
       if ( s == 0 ) {
          P1P = dipfmo(r1,BCPS,ELPS);
          if ( P1 == 0 )  P1 = P1P;
          else {
               P1S = llast(P1);
                     lsred(P1S,P1P);
          }
       }
       else  if ( RP != _0 ) {
                EL   = dipevdif(r1,ELPS,ELR);
                BC3  = pigcdcf(r2,BCPS,BCR,&BC1,&BC2);
                PA   = dipfmo(r1,BC1,EL);
                PAA  = dippiprod(r1,r2,RP,PA);
                PS   = dippipiprod(r1,r2,PS,BC2);
                P1   = dippipiprod(r1,r2,P1,BC2);
                PS   = dippidif(r1,r2,PS,PAA);
             }
    } while ( PS != 0 );
/*
 * Berechnung der Normalform von P - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
