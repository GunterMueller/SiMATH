/* DOC_SKIP */

/***********************************************************************

	Funktionen in 'pol1 fuer den Groebner-Basen-Algorithmus

	enthaelt: dipevplm
                  dipevplso
                  dipgbc3	<-- 2. Vers. ab Vers. 3.9
		  dipgbc4
		  dipimogb	<-- 2. Vers. ab Vers. 3.9
		  dipinor
		  diplcaupl	<-- 2. Vers. ab Vers. 3.9
		  diplpm
		  dipmipmogb	<-- 2. Vers. ab Vers. 3.9
		  dipmipnor
		  dipmspmogb	<-- 2. Vers. ab Vers. 3.9
		  dipmspnor
		  diprmogb	<-- 2. Vers. ab Vers. 3.9
		  diprnor

***********************************************************************/



/*c
                         dipevplm( r, L1, L2 )

        "distributive polynomial exponent vector pair-list merge"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list dipevplm(r,L1,L2)  single r; list L1,L2;
        L = dipevplm(r,L1,L2);
        Dabei muss gelten:
              - 0 <= r < BASIS ist die Anzahl der Variablen.
              - L1 und L2 sind Paar-Listen von Exponentenvektoren in
                aufsteigender Ordnung von Polynomen in distributiver
                Darstellung.
        L ist die Vereinigung von L1 und L2.
        !! ACHTUNG: L1 und L2 werden veraendert. !!
c*/
/*H
	Version 1	19.05.1992	Th. Weis
	Version 2	29.04.1993	Th. Weis
                                        static --> normale Funktion
   DATE dipevplm      : 930531
H*/

#include <_pol1.h>

static list diplm(single,list,list);

list dipevplm(r,L1,L2)
list L1,L2;
{
/*
 * 1. Fall: eine der beiden Listen ist leer - Anfang
 */
  if ( L1 == _0 )  return(L2);
  if ( L2 == _0 )  return(L1);
/*
 * 1. Fall - Ende
 * 2. Fall: beide Listen sind nicht leer - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single TL;
    list   L,LP,LP1,AL1;
    list   LP2,AL2;
    list    EL1,EL2;

    bind(L1,L2);
    init(L,LP,LP1,AL1);
    init(LP2,AL2);
    init(EL1,EL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    LP1 = L1;
    LP2 = L2;
    AL1 = lfirst(L1);
    AL2 = lfirst(L2);
    EL1 = lfirst(AL1);
    EL2 = lfirst(AL2);
/*
 * Vorbesetzen - Ende
 * Mischen - Anfang
 */
    STEP1: TL  = dipevcomp(r,EL1,EL2);
           if ( TL > 0 ) {
              L   = L2;
              LP  = L2;
              LP2 = lred(L2);
              goto STEP3;
           }
           else {
                L   = L1;
                LP  = L1;
                LP1 = lred(L1);
           }
    STEP2: /* letztes Element von L1 */
           if ( LP1 == _0 )  goto STEP4;
           AL1 = lfirst(LP1);
           EL1 = lfirst(AL1);
           TL  = dipevcomp(r,EL1,EL2);
           if ( TL <= 0 ) {
              LP  = LP1;
              LP1 = lred(LP1);
              goto STEP2;
           }
           else {
                      lsred(LP,LP2);
                LP  = LP2;
                LP2 = lred(LP2);
           }
    STEP3: /* letztes Element von L2 */
           if ( LP2 == _0 )  goto STEP4;
           AL2 = lfirst(LP2);
           EL2 = lfirst(AL2);
           TL  = dipevcomp(r,EL1,EL2);
           if ( TL <= 0 ) {
                    lsred(LP,LP1);
              LP  = LP1;
              LP1 = lred(LP1);
              goto STEP2;
           }
           else {
                LP  = LP2;
                LP2 = lred(LP2);
                goto STEP3;
           }
    STEP4: /* Schluss */
           if ( LP1 == _0 )  lsred(LP,LP2);
           else  lsred(LP,LP1);
/*
 * Mischen - Ende
 * Rueckgabe
 */
    return(L);
  }
}



/*c
                         dipevplso( r, L )

        "distributive polynomial exponent vector pair-list sort"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list dipevplso(r,L)  single r; list L;
        L1 = dipevplso(r,L);
        Dabei muss gelten:
              - 0 <= r < BASIS  ist die Anzahl der Variablen.
              - L ist eine Liste von Paarlisten.
        L1 ist eine in nicht aufsteigender Ordnung sortierte Liste.
        !! ACHTUNG: L wird veraendert. !!
c*/
/*H
	Version 1	19.05.1992	Th. Weis
	Version 2	29.04.1993	Th. Weis
                                        static --> normale Funktion
   DATE dipevplso     : 930531
H*/

/* #include <_pol1.h> */

list dipevplso(r,L)
single r;
list   L;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single TL;
  list   LP,LPP,LPPP,LL1,LL2;
  list   L1,L1P,L1PP;
  list   L2,L2S,L2P,L2PP;
  list    EL1,EL2;

  bind(L);
  init(LP,LPP,LPPP,LL1,LL2);
  init(L1,L1P,L1PP);
  init(L2,L2S,L2P,L2PP);
  init(EL1,EL2);
/*
 * Deklaration, Binden & Initilaisieren - Ende
 * Faelle: L = (), L = (a) - Anfang
 */
  if ( L == _0 || lred(L) == _0 )  L1 = L;
/*
 * Faelle: L = (), L = (a) - Ende
 * restliche Faelle - Anfang
 */
  else {
/*
 * Vorbesetzen - Anfang
 */
       L2  = list1(0);
       L2S = L2;
       LP  = L;
/*
 * Vorbesetzen - Ende
 * Paare zusammenbauen - Anfang
 */
       do {
          LL1 = lfirst(LP);  LPP = lred(LP);
          if ( LPP == _0 )  L1P = LP;
          else {
               LL2 = lfirst(LPP);  LPPP = lred(LPP);
               EL1 = lfirst(LL1);
               EL2 = lfirst(LL2);
               TL  = dipevcomp(r,EL1,EL2);
               if ( TL <= 0 ) {
                  L1P = LP;
                        lsred(LPP,_0);
               }
               else {
                    L1P = LPP;
                          lsred(LPP,LP);
                          lsred(LP,_0);
               }
          }
          L2 = lcomp(L1P,L2);
          LP = LPPP;
       } while ( LPP != _0 && LP != _0 );
/*
 * Paare zusammenbauen - Ende
 * Permutieren und Speichern - Anfang
 */
       L1P = lfirst(L2);        L2  = lred(L2);
             lsfirst(L2S,L1P);
             lsred(L2S,L2);
       L1  = lfirst(L2);        L2P = lred(L2);
       while ( L2 != L2P ) {
             L1P  = lfirst(L2P);         L2PP = lred(L2P);
             L1PP = dipevplm(r,L1,L1P);
                    lsfirst(L2,L1PP);
                    lsred(L2,L2PP);
             L2   = L2PP;
             L1   = lfirst(L2);          L2P = lred(L2);
       }
/*
 * Permutieren und Speichern - Ende
 */
  }
/*
 * Rueckgabe
 */
  return(L1);
}



/*c
                        dipgbc3( r, B, PLI, PLJ, EL )

        "distributive polynomial Groebner basis criterion 3"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        single dipgbc3(r,B,PLI,PLJ,EL)  single r; list B,EL; pol PLI,PLJ;
        s = dipgbc3(r,B,PLI,PLJ,EL);
        Dabei muss gelten:
              - B ist eine nicht leere Liste von "reduzierten Polynom-
                mengen".
              - PLI und PLJ sind Polynome in r (0 <= r < BASIS) Variablen 
		in distributiver Darstellung ueber einem beliebigen Grund-
		ring.
              - EL ist das kgV (also das komponentenweise Maximun) der 
		fuehrenden Exponentenvektoren von PLI und PLJ.
        s=1, wenn die Reduktion von PLI und PLJ notwendig ist.
        s=0, sonst.
c*/
/*H
	Version 1	03.06.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipgbc3       : 930115.941201
H*/

/* #include <_pol1.h> */

single dipgbc3(r,B,PLI,PLJ,EL)
single r;
list   B;
pol    PLI,PLJ;
list    EL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single s,t;
  list   BP;
  list   PS,PL,PP,PPIN,PPJ;
  list   Q,QL;
  list    EP;

  bind(B,PLI,PLJ,EL);
  init(BP);
  init(PS,PL,PP,PPIN,PPJ);
  init(Q,QL);
  init(EP);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Ueberpruefung der Polynome vor PLI - Anfang
 */
  BP = B;
  do {
     PS = lfirst(BP);
     BP = lred(BP);
     Q  = lfirst(BP);
     BP = lred(BP);
     PL = lfirst(PS);
     PS = lred(PS);
     if ( PL != PLI ) {
        EP = dipevl(r,PL);
        t  = dipevmt(r,EL,EP);
        if ( t == 1 ) {
           s  = 0;
           PP = PS;
           while ( PP != _0 && s == 0 ) {
                 QL = lfirst(PP);
                 PP = lred(PP);
                 if ( QL == PLI || QL == PLJ )  s = 1;
           }
           if ( s == 0 )  return(s);
        }
     }
  } while ( PL != PLI );
/*
 * Ueberpruefung der Polynome vor PLI - Ende
 * Ueberpruefung der Polynome zwischen PLI und PLJ - Anfang
 */
  PPIN = PS;
  do {
     PS = lfirst(BP);
     BP = lred(BP);
     Q  = lfirst(BP);
     BP = lred(BP);
     PL = lfirst(PS);
     PS = lred(PS);
     if ( PL != PLJ ) {
        EP = dipevl(r,PL);
        t  = dipevmt(r,EL,EP);
        if ( t == 1 ) {
           s  = 0;
           PP = PPIN;
           while ( PP != _0 && s == 0 ) {
                 QL = lfirst(PP);
                 PP = lred(PP);
                 if ( QL == PL )  s = 1;
           }
           PP = PS;
           while ( PP != _0 && s == 0 ) {
                 QL = lfirst(PP);
                 PP = lred(PP);
                 if ( QL == PLJ )  s = 1;
           }
           if ( s == 0 )  return(s);
        }
     }
  } while ( PL != PLJ );
/*
 * Ueberpruefung der Polynome zwischen PLI und PLJ - Ende
 * Ueberpruefung der Polynome nach PLJ - Anfang
 */
  PPJ = PS;
  while ( BP != _0 ) {
        PS = lfirst(BP);
        BP = lred(BP);
        Q  = lfirst(BP);
        BP = lred(BP);
        PL = lfirst(PS);
        PS = lred(PS);
        EP = dipevl(r,PL);
        t  = dipevmt(r,EL,EP);
        if ( t == 1 ) {
           s  = 0;
           PP = PPIN;
           while ( PP != _0 && s == 0 ) {
                 QL = lfirst(PP);
                 PP = lred(PP);
                 if ( QL == PL )  s = 1;
           }
           PP = PPJ;
           while ( PP != _0 && s == 0 ) {
                 QL = lfirst(PP);
                 PP = lred(PP);
                 if ( QL == PL )  s = 1;
           }
           if ( s == 0 )  return(s);
        }
  }
  s = 1;
/*
 * Ueberpruefung der Polynome nach PLJ - Ende
 * Rueckgabe
 */
  return(s);
}



/*c
                         dipgbc4( r, PLI, PLJ, EL )

        "distributive polynomial Groebner basis criterion 4"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        single dipgbc4(r,PLI,PLJ,EL)  single r; pol PLI,PLJ; list EL;
        s = dipgbc4(r,PLI,PLJ,EL);
        Dabei muss gelten:
              - PLI und PLJ sind Polynome in r (0 <= r < BASIS) Variablen 
		in distributiver Darstellung ueber einem beliebigen Grund-
		ring.
              - EL ist das kgV (also das komponentenweise Maximum) der 
		fuehrenden Exponentenvektoren von PLI und PLJ.
        s=1, wenn die Reduktion von PLI und PLJ notwendig ist.
        s=0, sonst.
c*/
/*H
	Version 1	03.06.1992	Th. Weis
   DATE dipgbc4       : 930115
H*/

/* #include <_pol1.h> */

single dipgbc4(r,PLI,PLJ,EL)
single r;
pol    PLI,PLJ;
list    EL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single s;
  list    EI,EJ,EP;

  bind(PLI,PLJ,EL);
  init(EI,EJ,EP);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vergleich des kgV mit dem Produkt - Anfang
 */
  EI = dipevl(r,PLI);
  EJ = dipevl(r,PLJ);
  EP = dipevsum(r,EI,EJ);
  s  = oequal(EL,EP);
  s  = 1-s;
/*
 * Vergleich des kgV mit dem Produkt - Ende
 * Rueckgabe
 */
  return(s);
}



/*c
                         diplcaupl( r, P, PL, D, B, sch, pB )

        "distributive polynomial list construct and update pair list"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list diplcaupl(r,P,PL,D,B,sch,pB)  single r; pol P; list PL,D,B;
             				   single sch; list pB;
        D1 = diplcaupl(r,P,PL,D,B,sch,pB);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - P ist im Fall der Konstruktion der Paarlisten Null und im
                Fall der Modifizierung der Paarlisten ein von Null ver-
                schiedenes Polynom in r Variablen in distributiver Dar-
                stellung ueber einem beliebigen Grundring.
              - PL ist eine Liste von Polynomen in r Variablen in distri-
                butiver Darstellung ueber einem beliebigen Grundring;
              - D ist im Fall der Konstruktion der Paarlisten die leere
                Liste und im Fall der Modifizierung der Paarlisten die
                Liste, in der die Polynome nach ihren fuehrenden Monomen
                (bgzl. ihrer Termordnung) geordnet und zusammengefasst
                sind.
              - B ist im Fall der Konstruktion der Paarlisten die leere
                Liste und im Fall der Modifizierung der Paarlisten die
                Liste, in der die Polynome zu Paaren zusammengefasst
                werden.
              - sch ist ein Schalter, der die Werte 1 und 0 annimmt.
                Ist sch = 1, so werden die Paarlisten konstruiert;
                ist sch = 0, so werden die Paarlisten auf den neuesten
                Stand gebracht.
        diplcaupl erstellt im Fall der Konstruktion aus PL die Paarliste
        D1, in der die Polynome nach ihren fuehrenden Monomen (bzgl. ihrer
        Termordnung) geordnet und zusammengefasst werden, und die Polynom-
        paarliste pB.
        Im Fall der Modifizierung der Listen wird P in die Listen PL, D
        und B eingebaut, wobei D1 die auf den neuesten Stand gebrachte
        Paarliste D ist.
        !! ACHTUNG: PL, D und B werden im Fall    !!
        !!          der Modifizierung veraendert. !!        
c*/
/*H
	Version 1	19.05.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE diplcaupl     : 930115.941201
H*/

/* #include <_pol1.h> */

list diplcaupl(r,P,PL,D,B,sch,pB)
single r;
pol    P;
list   PL,D,B;
single sch;
list   *pB;
{
/*
 * Fall: Konstruktion der Paarlisten - Anfang
 */
  if ( sch == 1 ) {
/*
 * Fall: PL = {} - Anfang
 */
     if ( PL == _0 )  return(_0);
/*
 * Fall: PL = {} - Ende
 * Fall: PL != {}
 * Deklaration, Binden & Initialisieren - Anfang
 */
     {
       list D1,PSS,PP,BR,BP,QP,Q,DL;
       pol  PIN,PJ;
       list  ELI,ELJ,EL;

       bind(PL);
       init(D1,PSS,PP,BR,BP,QP,Q,DL);
       init(PIN,PJ);
       init(ELI,ELJ,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
       D1  = _0;
       *pB = _0;
       PP  = PL;
       BR  = _0;
       PSS = PP;
/*
 * Vorbestzen - Ende
 * Konstruktion von pD und pB - Anfang
 */
        do {
           PIN  = lfirst(PSS);
           QP  = lred(PSS);
           Q   = list1(PIN);
           BP  = lcomp(0,BR);
           ELI = dipevl(r,PIN);
           while ( QP != _0 ) {
                 PJ  = lfirst(QP);
                 QP  = lred(QP);
                 ELJ = dipevl(r,PJ);
                 EL  = dipevlcm(r,ELI,ELJ);
                 DL  = list3(EL,BP,Q);
                 D1  = lcomp(DL,D1);
                 Q   = lcomp(PJ,Q);
           }
           QP = linv(Q);
                lsfirst(BP,QP);
           BR = lcomp(Q,BP);
           PSS = lred(PSS);
        } while ( PSS != _0 );
        D1  = dipevplso(r,D1);
        *pB = linv(BR);
/*
 * Konstruktion von D1 und pB - Ende
 * Rueckgabe
 */
        return(D1);
     }
  }
/*
 * Fall: Konstruktion der Paarlisten - Ende
 * Fall: Modifizierung der Paarlisten - Anfang
 */
  if ( sch == 0 ) {
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
     list BP,BPP,BPPP,BR,DL,DP,PB,PP,PS,PPR,Q,QS;
     pol  H,PLI;
     list  EL,ELJ,ELI;

     bind(P,PL,D,B);
     init(BP,BPP,BPPP,BR,DL,DP,PB,PP,PS,PPR,Q,QS);
     init(H,PLI);
     init(EL,ELJ,ELI);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen & PL modifizieren - Anfang
 */
      BP  = B;
      DP  = _0;
      PP  = PL;
      H   = P;
      PS  = list1(H);
      PPR = llast(PP);
            lsred(PPR,PS);
/*
 * Vorbesetzen & PL modifizieren - Ende
 * B und D modifizieren - Anfang
 */
      ELJ = dipevl(r,H);
      while ( BP != _0 ) {
            QS   = lfirst(BP);
            BPP  = lred(BP);
            Q    = lfirst(BPP);
            BPPP = lred(BPP);
            PLI  = lfirst(QS);
            ELI  = dipevl(r,PLI);
            EL   = dipevlcm(r,ELI,ELJ);
            DL  = list3(EL,BP,Q);
            DP  = lcomp(DL,DP);
            PS  = list1(H);
                  lsred(Q,PS);
                  lsfirst(BPP,PS);
            BP  = BPPP;
      }
      DP = dipevplso(r,DP);
      DP = dipevplm(r,D,DP);
      PS = list1(H);
      PB = list2(PS,PS);
      BR = llast(B);
           lsred(BR,PB);
/*
 * B und D modifizieren - Ende
 * Rueckgabe
 */
     return(DP);
  }
/*
 * Fall: Modifizierung der Paarlisten - Ende
 */
}



/*c
                         diplpm( r, PL )

        "distributive polynomial list pair-merge sort"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list diplpm(r,PL)  single r; list PL;
        PL1 = diplpm(r,PL);
        PL ist eine Liste von distributiven Polynomen in r (0 <= r < BASIS)
	Variablen ueber einem beliebigen Grundring.
        PL1 ist die Liste PL, nachdem sie mit Hilfe des merge-sort
        Verfahrens geordnet wurde.
c*/
/*H
	Version 1	02.06.1992	Th. Weis
   DATE diplpm        : 930115
H*/

/* #include <_pol1.h> */

list diplpm(r,PL)
single r;
list   PL;
{
/*
 * Faelle: PL = () oder PL = (A) - Anfang
 * wenn ja, Rueckgabe
 */
   if ( PL == _0 || lred(PL) == _0 ) return(PL);
/*
 * Faelle: PL = () oder PL = (A) - Ende
 * restliche Faelle - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single t;
    list   PPL,PPPL,PPPPL,PLL1,PLL2;
    list   PL1,PPL1,PPPL1;
    list   L,LS,LP,LPP;
    list    EL1,EL2;

    bind(PL);
    init(PPL,PPPL,PPPPL,PLL1,PLL2);
    init(PL1,PPL1,PPPL1);
    init(L,LS,LP,LPP);
    init(EL1,EL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
     L   = list1(0);
     LS  = L;
     PPL = PL;
/*
 * Vorbesetzen - Ende
 * Konstruiere Paare - Anfang
 */
     do {
        PLL1 = lfirst(PPL);
        PPPL = lred(PPL);
        if ( PPPL == _0 ) PPL1 = PPL;
        else {
             PLL2  = lfirst(PPPL);
             PPPPL = lred(PPPL);
             EL1   = dipevl(r,PLL1);
             EL2   = dipevl(r,PLL2);
             t     = dipevcomp(r,EL1,EL2);
             if ( t <= 0 ) {
                PPL1 = PPL;
                       lsred(PPPL,_0);
             }
             else {
                  PPL1 = PPPL;
                         lsred(PPPL,PPL);
                         lsred(PPL,_0);
             }
        }
        L   = lcomp(PPL1,L);
        PPL = PPPPL;
     } while ( PPPL != _0 && PPL != _0 );
/*
 * Konstruiere Paare - Ende
 * "circle and merge" - Anfang
 */
     PPL1 = lfirst(L);
     L    = lred(L);
            lsfirst(LS,PPL1);
            lsred(LS,L);
     PL1  = lfirst(L);
     LP   = lred(L);
     while ( L != LP ) {
           PPL1  = lfirst(LP);
           LPP   = lred(LP);
           PPPL1 = diplm(r,PL1,PPL1);
                   lsfirst(L,PPPL1);
                   lsred(L,LPP);
           L     = LPP;
           PL1   = lfirst(L);
           LP    = lred(L);
     }
/*
 * "circle and merge" - Ende
 * Rueckgabe
 */
     return(PL1);
   }
}



/*c
                        diplm( r, L1, L2 )        (static)

        "distributive polynomial list merge"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        static list diplm(r,L1,L2)  single r; list L1,L2;
        L = diplm(r,L1,L2);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - L1 und L2 sind Listen von Polynomen in r Variablen
                in distributiver Darstellung ueber einem beliebigen
                Grundring und in aufsteigender Ordnung.
        L ist die Vereinigung von L1 und L2.
        !! ACHTUNG: L1 und L2 werden veraendert. !!
c*/

static list diplm(r,L1,L2)
single r;
list   L1,L2;
{
/*
 * 1. Fall: eine der beiden Listen ist leer - Anfang
 */
  if ( L1 == _0 )  return(L2);
  if ( L2 == _0 )  return(L1);
/*
 * 1. Fall - Ende
 * 2. Fall: beide Listen sind nicht leer - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single TL;
    list   L,LP,LP1,AL1;
    list   LP2,AL2;
    list    EL1,EL2;

    bind(L1,L2);
    init(L,LP,LP1,AL1);
    init(LP2,AL2);
    init(EL1,EL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    LP1 = L1;
    LP2 = L2;
    AL1 = lfirst(L1);
    AL2 = lfirst(L2);
    EL1 = dipevl(r,AL1);
    EL2 = dipevl(r,AL2);
/*
 * Vorbesetzen - Ende
 * Mischen - Anfang
 */
    STEP1: TL  = dipevcomp(r,EL1,EL2);
           if ( TL > 0 ) {
              L   = L2;
              LP  = L2;
              LP2 = lred(L2);
                    goto STEP3;
           }
           else {
                L   = L1;
                LP  = L1;
                LP1 = lred(L1);
           }
    STEP2: /* letztes Element von L1 */
           if ( LP1 == _0 )  goto STEP4;
           AL1 = lfirst(LP1);
           EL1 = dipevl(r,AL1);
           TL  = dipevcomp(r,EL1,EL2);
           if ( TL <= 0 ) {
              LP  = LP1;
              LP1 = lred(LP1);
                    goto STEP2;
           }
           else {
                      lsred(LP,LP2);
                LP  = LP2;
                LP2 = lred(LP2);
           }
    STEP3: /* letztes Element von L2 */
           if ( LP2 == _0 )  goto STEP4;
           AL2 = lfirst(LP2);
           EL2 = dipevl(r,AL2);
           TL  = dipevcomp(r,EL1,EL2);
           if ( TL <= 0 ) {
                    lsred(LP,LP1);
              LP  = LP1;
              LP1 = lred(LP1);
                    goto STEP2;
           }
           else {
                LP  = LP2;
                LP2 = lred(LP2);
                      goto STEP3;
           }
    STEP4: /* Schluss */
           if ( LP1 == _0 )  lsred(LP,LP2);
           else  lsred(LP,LP1);
/*
 * Mischen - Ende
 * Rueckgabe
 */
    return(L);
  }
}



/*c
                         dipimogb( r, PL )

        "distributive polynomial over integers minimal ordered Groebner
         basis"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list dipimogb(r,PL)  single r; list PL;
        PP = dipimogb(r,PL);
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r 
	(0 <= r < BASIS) Variablen ueber Z.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	21.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipimogb      : 930115.941201
H*/

/* #include <_pol1.h> */

list dipimogb(r,PL)
single r;
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
    list    EI,EJ,EL;
    int    C,BC;

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
          P  = dipfmo(r,BC,EL);
          PIN = dipinor(r,PINP,QP,P);
          C  = dipicp(r,PIN,&PIN);
       }
       PP = lcomp(PIN,PP);
    } while ( PS != _0 );
    PP = linv(PP);
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
                         dipmipmogb( r, p, PL )

        "distributive polynomial over modular integer primes minimal
         ordered Groebner basis"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list dipmipmogb(r,p,PL)  single r; int p; list PL;
        PP = dipmipmogb(r,p,PL);
	p ist Primzahl.
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r 
	(0 <= r < BASIS) Variablen ueber Z/pZ.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	29.09.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipmipmogb    : 930115.941201
H*/

/* #include <_pol1.h> */

list dipmipmogb(r,p,PL)
single r;
int    p;
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
    list    EI,EJ,EL;
    single BC;

    bind(p,PL);
    init(PP,PS,PIN,PINP,PJ,PB,QP);
    init(EI,EJ,EL);
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
          PINP = dipmipnor(r,p,PINP,QP);
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
                         dipmspmogb( r, p, PL )

        "distributive polynomial over modular single primes minimal
         ordered Groebner basis"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list dipmspmogb(r,p,PL)  single r,p; list PL;
        PP = dipmspmogb(r,p,PL);
	p ist Primzahl.
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r 
	(0 <= r < BASIS) Variablen ueber Z/pZ.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	29.07.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE dipmspmogb    : 930115.941201
H*/

/* #include <_pol1.h> */

list dipmspmogb(r,p,PL)
single r,p;
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
    list    EI,EJ,EL;
    single BC;

    bind(PL);
    init(PP,PS,PIN,PINP,PJ,PB,QP);
    init(EI,EJ,EL);
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
          PINP = dipmspnor(r,p,PINP,QP);
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
                         diprmogb( r, PL )

        "distributive polynomial over rationals minimal ordered Groebner
         basis"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        list diprmogb(r,PL)  single r; list PL;
        PP = diprmogb(r,PL);
        PL ist eine Liste von distributiven Polynomen ungleich 0 in r 
	(0 <= r < BASIS) Variablen ueber Q.
        PP ist die minimale normierte und geordnete Groebner Basis von PL.
c*/
/*H
	Version 1	05.06.1992	Th. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE diprmogb      : 930115.941201
H*/

/* #include <_pol1.h> */

list diprmogb(r,PL)
single r;
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
    list    EI,EJ,EL;
    rat    BC;

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
          PINP = diprnor(r,PINP,QP);
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
                         dipinor( r, P, PL, PP )

        "distributive polynomial over integers normal form"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        pol dipinor(r,P,PL,PP)  single r; pol P; list PL; pol PP;
        P1 = dipinor(r,P,PL,PP);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - P ist ein Polynom in r Variablen ueber Z in distributiver
                Darstellung.
              - PL ist eine Liste von Polynomen ungleich 0 in r Variablen 
		ueber Z in distributiver Darstellung.
              - PP ist ein Polynom in r Variablen ueber Z in distributiver
                Darstellung.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	20.07.1992	Th. Weis
   DATE dipinor       : 930115
H*/

/* #include <_pol1.h> */

pol dipinor(r,P,PL,PP)
single r;
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
    int    BCPS,BCR,BC1,BC2,BC3;
    list    ELPS,ELR,EL;

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
       PS = dipmoad(r,PS,&BCPS,&ELPS);
       if ( PS == _0 )  PS = 0;
       PLL = PL;
       do {
          R   = lfirst(PLL);
          PLL = lred(PLL);
          RP  = dipmoad(r,R,&BCR,&ELR);
          s   = dipevmt(r,ELPS,ELR);
       } while ( PLL != _0 && s != 1 );
       if ( s == 0 ) {
          P1P = dipfmo(r,BCPS,ELPS);
          if ( P1 == 0 )  P1 = P1P;
          else {
               P1S = llast(P1);
                     lsred(P1S,P1P);
          }
       }
       else  if ( RP != _0 ) {
                EL   = dipevdif(r,ELPS,ELR);
                BC3  = igcdcf(BCPS,BCR,&BC1,&BC2);
                PA   = dipfmo(r,BC1,EL);
                PAA  = dipiprod(r,RP,PA);
                PS   = dipiiprod(r,PS,BC2);
                P1   = dipiiprod(r,P1,BC2);
                PS   = dipidif(r,PS,PAA);
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



/*c
                         dipmipnor( r, p, P, PL )

        "distributive polynomial over modular integer primes normal form"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        pol dipmipnor(r,p,P,PL)  single r; int p; pol P; list PL;
        P1 = dipmipnor(r,p,P,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist Primzahl.
              - P ist ein Polynom in r Variablen ueber Z/pZ in
                distributiver Darstellung.
              - PL ist eine Liste von Polynomen ungleich 0 in r Variablen 
		ueber Z/pZ in distributiver Darstellung.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	29.09.1992	Th. Weis
   DATE dipmipnor     : 930115
H*/

/* #include <_pol1.h> */

pol dipmipnor(r,p,P,PL)
single r;
int    p;
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
    int    BCP,BCQ,BCP1;
    list    ELP,ELQ,ELP1;

    bind(p,P,PL);
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
                BCP1 = miquot(p,BCP,BCQ);
                AP   = dipfmo(r,BCP1,ELP1);
                APP  = dipmipprod(r,p,QP,AP);
                PS   = dipmipdif(r,p,PS,APP);
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
                         dipmspnor( r, p, P, PL )

        "distributive polynomial over modular single primes normal form"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        pol dipmspnor(r,p,P,PL)  single r,p; pol P; list PL;
        P1 = dipmspnor(r,p,P,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - p ist Primzahl.
              - P ist ein Polynom in r Variablen ueber Z/pZ in
                distributiver Darstellung.
              - PL ist eine Liste von Polynomen ungleich 0 in r Variablen 
		ueber Z/pZ in distributiver Darstellung.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	29.07.1992	Th. Weis
   DATE dipmspnor     : 930115
H*/

/* #include <_pol1.h> */

pol dipmspnor(r,p,P,PL)
single r,p;
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
    single BCP,BCQ,BCP1;
    list    ELP,ELQ,ELP1;

    bind(P,PL);
    init(PLL);
    init(P1,PS,Q,QP,AP,APP);
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
                BCP1 = msquot(p,BCP,BCQ);
                AP   = dipfmo(r,BCP1,ELP1);
                APP  = dipmspprod(r,p,QP,AP);
                PS   = dipmspdif(r,p,PS,APP);
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
                         diprnor( r, P, PL )

        "distributive polynomial over rationals normal form"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        pol diprnor(r,P,PL)  single r; pol P; list PL;
        P1 = diprnor(r,P,PL);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - P ist ein Polynom in r Variablen ueber Q in distributiver
                Darstellung.
              - PL ist eine Liste von Polynomen ungleich 0 in r Variablen 
		ueber Q in distributiver Darstellung.
        P1 berechnet sich durch Reduktion von P modulo PL, und es gilt:
        P1 ist in Normalform bzgl. PL.
c*/
/*H
	Version 1	04.06.1992	Th. Weis
   DATE diprnor       : 930115
H*/

/* #include <_pol1.h> */

pol diprnor(r,P,PL)
single r;
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
    rat    BCP,BCQ,BCP1;
    list    ELP,ELQ,ELP1;

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
                BCP1 = rquot(BCP,BCQ);
                AP   = dipfmo(r,BCP1,ELP1);
                APP  = diprprod(r,QP,AP);
                PS   = diprdif(r,PS,APP);
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
