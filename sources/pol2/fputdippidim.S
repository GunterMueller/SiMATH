/*M
.SH NAME
fputdippidim file put distributive polynomial over polynomials over integers dimension

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippidim(r1, r2, DIML, VL1, VL2, pf)  
single r1, r2;
list DIML, VL1, VL2; 
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
.B DIML
is a list of conditions and dimensions, created for example by dippidim, (s.dippidim). The polynomials which appear in DIML are polynomials in R2, the end of a polynomial is marked with '#'.
.TP 4
.B pf
points on an input file *pf.
.PP
fputdippidim writes the list DIML to *pf, and returns 0 by success and ERROR else.

.SH SEE ALSO
 dippidim
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)                                   
M*/
   
/*H
	Version 1	29.06.1993	Th. Weis
   DATE fputdippidim  : 931130
H*/

#include <_pol2.h>

static single cgbiwrconj(single,single,list,list,list,FILE*);

single fputdippidim(r1,r2,DIML,VL1,VL2,pf)
single r1,r2;
list   DIML,VL1,VL2;
FILE   *pf;
{
/*
 * Fall: DIML == {}  - Anfang
 */
  if ( DIML == _0 )  return(0);
/*
 * Fall: DIML == {}  - Ende
 * Fall: DIML != {}
 */
  {
    single err=0,dim,d;
    list   COND,CONDS,DIMO,X,XP;

    bind(DIML,VL1,VL2);
    init(COND,CONDS,DIMO,X,XP);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"\nquantifier free formula for parametric dimension:\n") != 0 )  return(ERROR);
    X    = DIML;
    DIMO = _0;
    while ( X != _0 ) {
          COND  = lfirst(X);
          X     = lred(X);
          dim   = lfirst(X);
          X     = lred(X);
          CONDS = _0;
          if ( lmemb(dim,DIMO) == 0 ) {
             DIMO  = lcomp(dim,DIMO);
             CONDS = lcomp(COND,CONDS);
             XP    = X;
             while ( XP != _0 ) {
                   COND = lfirst(XP);
                   XP   = lred(XP);
                   d    = lfirst(XP);
                   XP   = lred(XP);
                   if ( d == dim )  CONDS = lcomp(COND,CONDS);
             }
             if ( fprintf(pf,"dimension = %i",dim) != 0 ) { err = ERROR; break; }
             if ( cgbiwrconj(r1,r2,VL1,VL2,CONDS,pf) != 0 ) { err = ERROR; break; }
          }
    }
    if ( !err )  err = fprintf(pf,"\n\n");
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
    return(err);
  }
}



/*c
		cgbiwrconj( r1, r2, VL1, VL2, CONDS, pf )	(static)

	static single cgbiwrconj(r1,r2,VL1,VL2,CONDS,pf)  single r1,r2;
        	list VL1,VL2,CONDS; FILE *pf;
        a = cgbiwrconj(r1,r2,VL1,VL2,CONDS,pf);
c*/

static single cgbiwrconj(r1,r2,VL1,VL2,CONDS,pf)
single r1,r2;
list   VL1,VL2,CONDS;
FILE   *pf;
{
/*
 * Fall: CONDS == {}  - Anfang
 */
  if ( CONDS == _0 ) {
     if ( fprintf(pf,"false\n") != 0 )  return(ERROR);
  }
/*
 * Fall: CONDS == {}  - Ende
 * Fall: CONDS != {}
 */
  {
    single err=0;
    list C,C0,COND,COND0,COND1,PA;

    bind(VL1,VL2,CONDS);
    init(C,C0,COND,COND0,COND1,PA);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"\n") != 0 )  return(ERROR);
    C = CONDS;
    while ( C != _0 ) {
          COND  = lfirst(C);
          C     = lred(C);
          COND0 = lfirst(COND);
          COND1 = lsecond(COND);
          C0    = COND0;
          if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
          while ( COND0 != _0 ) {
                PA    = lfirst(COND0);
                COND0 = lred(COND0);
                if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
                if ( fputpi(r2,PA,VL2) != 0 ) { err = ERROR; break; }
                if ( fprintf(pf,"  == 0 ) ") != 0 ) { err = ERROR; break; }
                if ( COND0 != _0 ) {
                   if ( fprintf(pf," and  ") != 0 ) { err = ERROR; break; }
                }
          }
          if ( err )  break;
          if ( C0 != _0 && COND1 != _0 ) {
             if ( fprintf(pf," and  ") != 0 ) { err = ERROR; break; }
          }
          while ( COND1 != _0 ) {
                PA    = lfirst(COND1);
                COND1 = lred(COND1);
                if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
                if ( fputpi(r2,PA,VL2) != 0 ) { err = ERROR; break; }
                if ( fprintf(pf,"  != 0 ) ") != 0 ) { err = ERROR; break; }
                if ( COND1 != _0 ) {
                   if ( fprintf(pf," and  ") != 0 ) { err = ERROR; break; }
                }
          }
          if ( err )  break;
          if ( fprintf(pf,")") != 0 ) { err = ERROR; break; }
          if ( C != _0 ) {
             if ( fprintf(pf,"\n\nor\n\n") != 0 ) { err = ERROR; break; }
          }
    }
    if ( !err )  err = fprintf(pf,"\n");
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
    return(err);
  }
}
