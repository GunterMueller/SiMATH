/*M
.SH NAME
dippipim - distributive polynomial over polynomials over integers parametric ideal membership test

.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippipim(r1, r2, s, PL, PTL, CONDS, OPL)  
single r1, r2, s;
list PL, PTL, CONDS, OPL;
                           
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
.B PTL
is a list of distributive polynomials in r1 variables over a ring of polynomials in r2 variables over the integer numbers.
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
.B OPL
is a list of length 3, every element (say e1,e2,e3) has value 0 or 1.
.RS
.TP 4
.B e1
turns the factorization of the coefficient polynomials on (e1=1) or off(e1=0).
.TP 4
.B e2
determines the algorithm used to normalize the polynomials.
.IP
e2 = 0: 'Top reduction' will be used, i.e. only
        the leading monomials (with regard to
        the term order) unequal to zero will be
        eliminated.
.IP
e2 = 1: the 'common' algorithm to compute Groebner
        basis will be used.
.TP 4
.B e3
is optional.                                         
.RE
.PP
dippipim returns a list containing every element of PTL, the conditions and normal forms, so that a  polynomial is member of the ideal spanned by PTL, and the conditions and normal forms, so that a polynomial is not member of the ideal.
  
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
   DATE dippipim      : 931130
H*/

#include <_pol2.h>

static cgbpimse(single,single,list,list,list,single,single,list*);

list dippipim(r1,r2,s,PL,PTL,CONDS,OPL)
single r1,r2,s;
list   PL,PTL,CONDS,OPL;
{
/*
 * Fall: PL == {} oder PTL == {}  - Anfang
 */
  if ( PL == _0 || PTL == _0 )  return(_0);
/*
 * Fall: PL == {} oder PTL == {}  - Ende
 * Fall: PL != {} und PTL != {}
 */
  {
    single fac,red;
    list   CGB,NOUT;

    bind(PL,PTL,CONDS,OPL);
    init(CGB,NOUT);
/*
 * Berechnungen vorbereiten - Anfang
 */
    fac = lfirst(OPL);
    red = lsecond(OPL);
    if ( !s ) {
       CGB = lcopy(PL);
       CGB = diplpm(r1,CGB);
       CGB = linv(CGB);
    }
    else  CGB = cgbfcb(r1,r2,PL);
/*
 * Berechnungen vorbereiten - Ende
 * Quantorenelimination berechnen - Anfang
 */
    cgbpimse(r1,r2,CONDS,PTL,CGB,fac,red,&NOUT);
/*
 * Quantorenelimination berechnen - Ende
 * Rueckgabe
 */
    return(NOUT);
  }
}



/*c
	    cgbpimse( r1, r2, C, PPS, PP, fac, red, pNOUT )	(static)

        "comprehensive Groebner basis, parametric ideal membership exec"
        static cgbpimse(r1,r2,C,PPS,PP,fac,red,pNOUT)  single r1,r2;
        	list C,PPS,PP; single fac,red; list *pNOUT;
        cgbpimse(r1,r2,C,PPS,PP,fac,red,pNOUT);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - C ist eine Bedingung;
              - PPS ist eine Liste von Polynomen, die getestet werden
                sollen;
              - PP ist eine Liste von Polynomen, die eine parametrische
                Groebnerbasis bilden;
              - fac ist ein Schalter fuer die Faktorisierung der Koef-
                fizienten;
              - red ist ein Schalter fuer den Reduktionstyp;
                fuer red = 0 wird cgbnorbtop  und
                fuer red = 1 wird cgbpanor benutzt.
        *pNOUT ist eine Liste, die jedes Polynom aus PPS enthaelt und die
        Bedingungen und Normalformen, so dass das Polynom ein Element des
        Ideals ist, und solche Bedingungen und Normalformen, so dass das
        Polynom kein Element des Ideals ist.
c*/

static cgbpimse(r1,r2,C,PPS,PP,fac,red,pNOUT)
single r1,r2;
list C,PPS,PP;
single fac,red;
list *pNOUT;
{
  list COL,COND,D,N0,N1,NN0,NN1,PCO,PELEM,PL,PLIST,POL,PPL,PS,X;

  bind(C,PPS,PP);
  init(COL,COND,D,N0,N1,NN0,NN1,PCO,PELEM,PL,PLIST,POL,PPL,PS,X);
/*
 * Vorbesetzen - Anfang
 */
  *pNOUT = _0;
/*
 * Vorbesetzen - Ende
 * Bestimme PP - Anfang
 */
  cgbidlop(r1,r2,C,PP,fac,&D,&PL);
/*
 * Bestimme PP - Ende
 * Teste Polynome aus PPS - Anfang
 */
  PS = PPS;
  while ( PS != _0 ) {
        POL = lfirst(PS);
        PS  = lred(PS);
        NN0 = _0;
        NN1 = _0;
        PPL = PL;
        while ( PPL != _0 ) {
              PELEM = lfirst(PPL);
              PPL   = lred(PPL);
              COND  = lfirst(PELEM);
              PLIST = lsecond(PELEM);
              PLIST = cgbrep(r1,r2,PLIST);
              COL   = cgbiic(r1,r2,COND,POL,fac);
              PCO   = list2(POL,COL);
              if ( red == 0 )  cgbinorbtop(r1,r2,COND,PCO,PLIST,fac,&N0,&N1);
              else  cgbipanor(r1,r2,COND,PCO,PLIST,fac,&N0,&N1);
              if ( N0 != _0 ) {
                 if ( NN0 == _0 )  NN0 = N0;
                 else {
                      X = llast(NN0);
                          lsred(X,N0);
                 }
              }
              if ( N1 != _0 ) {
                 if ( NN1 == _0 )  NN1 = N1;
                 else {
                      X = llast(NN1);
                          lsred(X,N1);
                 }
              }
        }
        *pNOUT = lcomp3(POL,NN0,NN1,*pNOUT);
  }
/*
 * Teste Polynome aus PPS - Ende
 * Ruecksprung
 */
  return;
}
