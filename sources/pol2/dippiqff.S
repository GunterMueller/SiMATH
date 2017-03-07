/*M
.SH NAME
dippiqff - distributive polynomial over polynomials over integers quantifier free formula
.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippiqff(r1, r2, s, PL, CONDS, fac)  
single r1, r2, s, fac;
list PL, CONDS; 
          
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B s
is either 0 or 1, for s = 0,
.RS
.TP 4
.B PL
is a list of distributive polynomials in r1 variables over a ring of polynomials in r2 variables over the integer numbers.  
.TP 4
.B VL1
is a list, consisting of the r1 variables names used by the polynomials in PL.
.TP 4
.B VL2
is a list, consisting of the r2 variables names used by the ring of polynomials
over the integer numbers.
.PP
.RE
For s = 1,
.RS             
.PP
.B PL
is a parametric Groebnerbasis (s. dippicgb or dippircgb).
.RE
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n),
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero
 (i even).
.PP
(s.dippicgb)
.TP 4
.B fac
is either 0 or 1 and turns the factorization of the coefficient polynomials on (
fac=1) or off(fac=0).             
.PP
dippiqff returns the quantifier free formula of a basis.

.SH SEE ALSO
 dippicgb
 dippircgb
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)                   

M*/

/*H
	Version 1	21.05.1993	Th. Weis
   DATE dippiqff      : 931130
H*/

#include <_pol2.h>

static list cgbqff(single,single,list);
static single cgbmcl(single,single,list,list*,list*);

list dippiqff(r1,r2,s,PL,CONDS,fac)
single r1,r2,s;
list   PL,CONDS;
single fac;
{
/*
 * Fall: PL == {}  - Anfang
 */
  if ( PL == _0 )  return(_0);
/*
 * Fall: PL == {}  - Ende
 * Fall: PL != {}
 */
  {
    list   PP,CGBL,COND,HCGB,QFFL;

    bind(PL,CONDS);
    init(PP,CGBL,COND,HCGB,QFFL);
/*
 * Berechnungen vorbereiten - Anfang
 */
    if ( !s ) {
       PP   = lcopy(PL);
       PP   = diplpm(r1,PP);
       PP   = linv(PP);
       COND = cgbcc(r1,r2,CONDS);
       CGBL = cgbiglobred(r1,r2,COND,PP,fac);
    }
    else  CGBL = PL;
    HCGB = cgbgpwogm(r1,r2,CGBL);
/*
 * Berechnungen vorbereiten - Ende
 * Quantorenelimination berechnen - Anfang
 */
    QFFL = cgbqff(r1,r2,CGBL);
/*
 * Quantorenelimination berechnen - Ende
 * Rueckgabe
 */
    return(QFFL);
  }
}



/*c
			cgbqff( r1, r2, PP )        (static)

        "comprehensive Groebner basis, quantifier free formula"
        static list cgbqff(r1,r2,PP)  single r1,r2; list PP;
        QFFL = cgbqff(r1,r2,PP);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - PP ist eine Liste von gefaerbten Polynomen.
        QFFL ist die quantorenfreie Formel der Basis.
c*/

static list cgbqff(r1,r2,PP)
single r1,r2;
list   PP;
{
/*
 * Fall: PP == {}  - Anfang
 */
  if ( PP == _0 )  return(_0);
/*
 * Fall: PP == {}  - Ende
 * Fall: PP != {}
 */
  {
    single b;
    list   COEF,COEFLI,PA,PCO,P;
    list   QFFL;

    bind(PP);
    init(COEF,COEFLI,PA,PCO,P);
    init(QFFL);

    PCO = cgbcdopl(r1,r2,PP);
    if ( PCO != _0 )  return(ERROR);
    P    = PP;
    QFFL = _0;
    while ( P != _0 ) {
          PCO  = lfirst(P);
          P    = lred(P);
          b    = cgbmcl(r1,r2,PCO,&COEFLI,&COEF);
          QFFL = lconc(QFFL,list3(b,COEFLI,COEF));
    }
    return(QFFL);
  }
}



/*c
		cgbmcl( r1, r2, PCO, pCOEFLI, pCOEF )        (static)

        "comprehensive Groebner basis, make coefficient list"
        static single cgbmcl(r1,r2,PCO,pCOEFLI,pCOEF)  single r1,r2;
               list PCO,*pCOEFLI,*pCOEF;
        t = cgbmcl(r1,r2,PCO,pCOEFLI,pCOEF);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - PCO ist ein gefaerbtes Polynom.
        *pCOEFLI ist eine Liste von roten und weissen Koeffizienten in PCO,
        so dass der Grad der Terme in PCO nicht Null ist.
        *pCOEF ist 
                  die leere Liste, wenn kein Monom in PCO existiert, dessen
                  Koeffizient weiss gefaerbt ist und dessen Term vom Grad
                  Null ist
                  oder
                  es existiert ein Monom in PCO, dessen Koeffizient gruen
                  gefaerbt ist und dessen Term Grad Null hat;
         oder ist
                  gleich Null, wenn ein Monom in PCO existiert, dessen
                  Koeffizient rot gefaerbt ist und dessen Term vom Grad
                  Null ist;
         oder ist 
                  der weisse Koeffizient in PCO, dessen Term vom Grad Null
                  ist.
        t = 1, wenn ein rot gefaerbter Koeffizient existiert, dessen Term
               Grad groesser als Null hat;
        t = 0, andernfalls.
c*/

static single cgbmcl(r1,r2,PCO,pCOEFLI,pCOEF)
single r1,r2;
list   PCO,*pCOEFLI,*pCOEF;
{
/*
 * Fall: PCO == {}  - Anfang
 */
  *pCOEFLI = _0;
  *pCOEF   = _0;
  if ( PCO == _0 )  return(0);
/*
 * Fall: PCO == {}  - Ende
 * Fall: PCO != {}
 */
  {
    single s,t;
    list   COL,CRED,CWHITE,PA,PE,POL,R,XTERM;

    bind(PCO);
    init(COL,CRED,CWHITE,PA,PE,POL,R,XTERM);
/*
 * Vorbesetzen - Anfang
 */
    POL = lfirst(PCO);
    COL = lsecond(PCO);
    if ( COL == _0 )  return(0);
    t = 0;
/*
 * Vorbesetzen - Ende
 * Farben des Polynoms ueberpruefen - Anfang
 */
    CRED   = lfirst(COL);
    CWHITE = lsecond(COL);
    do {
       POL = dipmoad(r1,POL,&PA,&PE);
       s   = pisign(r2,PA);
       if ( s == (-1) )  PA = pineg(r2,PA);
       s = lmemb(PE,CRED);
       if ( s == 1 ) {
          if ( POL == _0 ) {
             XTERM = dipfmo(r1,PA,PE);
             R     = diptdg(r1,XTERM);
             if ( R != 0 )  t = 1;
             else  *pCOEF = 0;
          }
          else  t = 1;
       }
       else {
            s = cgbwtm(r1,r2,PE,CWHITE);
            if ( s == 1 ) {
               if ( POL == _0 ) {
                  XTERM = dipfmo(r1,PA,PE);
                  R     = diptdg(r1,XTERM);
                  if ( R == 0 )  *pCOEF = PA;
                  else {
                       if ( lmemb(PA,*pCOEFLI) == 0 )  *pCOEFLI = lcomp(PA,*pCOEFLI);
                  }
               }
               else {
                    if ( lmemb(PA,*pCOEFLI) == 0 )  *pCOEFLI = lcomp(PA,*pCOEFLI);
               }
            }
       }
    } while ( POL != _0 && t != 1 );
    if ( t == 1 ) {
       *pCOEFLI = _0;
       return(t);
    }
    *pCOEFLI = linv(*pCOEFLI);
/*
 * Farben des Polynoms ueberpruefen - Ende
 * Rueckgabe
 */
    return(t);
  }
}
