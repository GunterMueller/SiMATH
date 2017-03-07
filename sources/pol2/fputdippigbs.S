/*M
.SH NAME
fputdippigbs - file put distributive polynomial over polynomials over integers Groebner system

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippigbs(r1, r2, GS, VL1, VL2, cs, pf)  
single r1, r2, cs;  
list GS, VL1, VL2; 
FILE *pf;
      
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.TP 4
.B GS
is a Groebner system, created for example by dippicgb, i.e. GS is a kind of tree, with a pair of coefficient lists and the appendant Groebner basis in every edge. The coefficient lists are lists of polynomials in R2. The Groebner basis are lists of distributive polynomials in R1.
.TP 4
.B cs
turns the output of the monomials with coefficient equal to 0 on (cs=0) or off (cs=1). 
.TP 4
.B pf
points on an input file.
.PP
fputdippigbs writes GS to *pf and returns 0 by success and ERROR else. The ends of the polynomials will be marked with '#'. 

.SH SEE ALSO
 dippicgb
 dippircgb

M*/
        
/*H
	Version 1	10.05.1993	Th. Weis
        Version 2       29.06.1993      Aufruf von cgbiwrclpwogm verbessert. TW
   DATE fputdippigbs  : 930531.931130
H*/

#include <_pol2.h>

fputdippigbs(r1,r2,GS,VL1,VL2,cs,pf)
single r1,r2;
list   GS,VL1,VL2;
single cs;
FILE   *pf;
{
  single err,i,s;
  list   COND,HELEM,HLIST,HPP,PELEM,PLIST,PPL,X;

  bind(GS,VL1,VL2);
  init(COND,HELEM,HLIST,HPP,PELEM,PLIST,PPL,X);
/*
 * Ausgabe - Anfang
 */
  if ( GS == _0 ) {
     err = fprintf(pf,"{}\n");
     return(err);
  }
  err = 0;
  PPL = GS;
  X   = _0;
  while ( PPL != _0 ) {
        PELEM = lfirst(PPL);
        PPL   = lred(PPL);
        COND  = lfirst(PELEM);
        PLIST = lsecond(PELEM);
        if ( cgbiwrcond(r1,r2,VL1,VL2,COND,pf) != 0 ) {
           err = ERROR;
                 break;
        }
        i     = 1;
        HPP   = PPL;
        PPL   = _0;
        while ( HPP != _0 ) {
              HELEM = lfirst(HPP);
              HPP   = lred(HPP);
              HLIST = lsecond(HELEM);
              s     = cgbelocp(r1,r2,PLIST,HLIST);
              if ( s == 1 ) {
                 if ( cgbiwrcond(r1,r2,VL1,VL2,lfirst(HELEM),pf) != 0 ) {
                    err = ERROR;
                          break;
                 }
                 i = i+1;
              }
              else  PPL = lcomp(HELEM,PPL);
        }
        if ( PPL != _0 )  PPL = linv(PPL);
        if ( cs ) {    /* <--- Beginn der Ausagbe ohne verschwindende Monome */
           if ( PLIST == _0 ) {
              if ( fprintf(pf,"{}\n") != 0 ) {
                 err = ERROR;
                       break;
              }
           }
           else {
                if ( fprintf(pf,"base:") != 0 ) {
                   err = ERROR;
                         break;
                }
                if ( cgbiwrclp(r1,r2,VL1,VL2,PLIST,0,pf) != 0 ) {
                   err = ERROR;
                         break;
                }
                if ( cgbiwrclpwogm(r1,r2,VL1,VL2,COND,PLIST,pf) == ERROR ) {
                   err = ERROR;
                         break;
                }
           }
        }
        else {    /* <--- Beginn der Ausagbe mit allen Monomen */
             if ( fprintf(pf,"base:") != 0 ) {
                err = ERROR;
                      break;
             }
             if ( cgbiwrclp(r1,r2,VL1,VL2,PLIST,0,pf) != 0 ) {
                err = ERROR;
                      break;
             }
        }
        if ( fprintf(pf,"%d condition(s).\n",i) != 0 ) {
           err = ERROR;
                 break;
        }

  }
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
  return(err);
}
