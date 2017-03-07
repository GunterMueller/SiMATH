/*M
.SH NAME
dippidim - distributive polynomial over polynomials over integers dimension

.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippidim(r1, r2, s, PL, CONDS, fac, VL1, VL2, pf)  
single r1, r2, s, fact;
list PL, CONDS, VL1, VL2; 
FILE *pf;
 
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
is a Groebner system (s. dippicgb or dippircgb).
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
is either 0 or 1 and turns the factorization of the coefficient polynomials on (fac=1) or off(fac=0).
.TP 4
.B pf 
points on an open input file.
.PP
dippidim computes the dimension of every element of the Groebner system, and returns a list of conditions and dimensions.

.SH SEE ALSO
 dippicgb
 dippircgb
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)                   
M*/
           
/*H
	Version 1	29.06.1993	Th. Weis
   DATE dippidim      : 931130
H*/

#include <_pol2.h>

static list cgbipde(single,single,list,list,list,FILE*);

list dippidim(r1,r2,s,PL,CONDS,fac,VL1,VL2,pf)
single r1,r2,s;
list   PL,CONDS;
single fac;
list   VL1,VL2;
FILE   *pf;
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
    list   PP,D,GS,DIML;

    bind(PL,CONDS,VL1,VL2);
    init(PP,D,GS,DIML);
/*
 * Berechnungen vorbereiten - Anfang
 */
    if ( !s ) {
       PP = lcopy(PL);
       PP = diplpm(r1,PP);
       PP = linv(PP);
            cgbidlop(r1,r2,CONDS,PP,fac,&D,&GS);
    }
    else  GS = PL;
/*
 * Berechnungen vorbereiten - Ende
 * Dimension berechnen - Anfang
 */
    DIML = cgbipde(r1,r2,VL1,VL2,GS,pf);
/*
 * Dimension berechnen - Ende
 * Rueckgabe
 */
    return(DIML);
  }
}



/*c
		cgbipde( r1, r2, VL1, VL2, GS, pf )	(static)

	"comprehensive Groebner basis over integers,
         parametric dimension exec"
        static list cgbipde(r1,r2,VL1,VL2,GS,pf)  single r1,r2;
             list VL1,VL2,GS; FILE *pf;
        DIML = cgbipde(r1,r2,VL1,VL2,GS,pf);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - VL1 ist die Liste der Variablennamen;
              - GS ist ein Groebner-System;
              - pf ist ein Zeiger auf eine zum Schreiben geoeffnete
                Datei.
        Fuer jedes Element des Groebner-Systems wird die Dimension
        berechnet. DIML ist eine Liste von Bedingungen und
        Dimensionen.
c*/

static list cgbipde(r1,r2,VL1,VL2,GS,pf)
single r1,r2;
list   VL1,VL2,GS;
FILE   *pf;
{
  single dim;
  list   COND,DIML,P,PLIST,X,XELEM,S,M;

  bind(VL1,VL2,GS);
  init(COND,DIML,P,PLIST,X,XELEM,S,M);
/*
 * Vorbesetzen - Anfang
 */
  X    = GS;
  DIML = _0;
/*
 * Vorbesetzen - Ende
 * Berechnung der Dimension - Anfang
 */
  while ( X != _0 ) {
        XELEM = lfirst(X);
        X     = lred(X);
        COND  = lfirst(XELEM);
        PLIST = lsecond(XELEM);
                cgbiwrcond(r1,r2,VL1,VL2,COND,pf);
                fprintf(pf,"base:");
        if ( PLIST == _0 )  fprintf(pf,"\n{}\n\n");
        else {
                  cgbiwrclp(r1,r2,VL1,VL2,PLIST,0,pf);
             P  = cgbiwrclpwogm(r1,r2,VL1,VL2,COND,PLIST,pf);
             if ( P == _0 ) {
                      fprintf(pf,"{}\n\ndimension = %i\n",r1+r2);
                dim = r1+r2;
             }
             else {
                  dim = dipdimpolid(r1,P,&S,&M);
                        fputdipdim(r1,dim,S,M,VL1,pf);
             }
             if ( dim != _0 )  DIML = lcomp2(COND,dim,DIML);
        }
  }
/*
 * Berechnung der Dimension - Ende
 * Rueckgabe
 */
  return(DIML);
}
