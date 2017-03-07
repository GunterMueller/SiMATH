/*M
.SH NAME
fputdippigt - file put distributive polynomial over polynomials over integers Groebner test

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippigt(r1, r2, CONDS, PP, CGB0, CGB1, VL1, VL2, pf)  
single r1, r2;
list CONDS, PP, CGB0, CGB1, VL1, VL2; 
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
are lists of lenght r1 resp. r2, containing the variables names used by the
polynomials in R1 resp. R2.      
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n)
,
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero
 (i even).
 (s.dippicgb)
.PP
The coefficient polynomials are polynomials in R2.
.TP 4
.B PP
is a list of distributive polynomials in R1.
.TP 4
.B CGB0
is a list, which arises by CONDS and contains the conditions, so that PP is a Groebner basis (s. dippicgb and dippigt).
.TP 4
.B CGB1
is a list, which arises by CONDS and contains the conditions, so that PP is not a Groebner basis (s. dippicgb and dippigt).
.TP 4
.B pf
points to an input file.
.PP
fputdippigt writes CONDS, PP, CGB0 and CGB1 to *pf and returns 0 by success and ERROR else.

.SH SEE ALSO
 dippicgb
 dippigt

M*/

/*H
	Version 1	11.06.1993	Th. Weis
   DATE fputdippigt   : 931130
H*/

#include <_pol2.h>

static single cgbcp(single,single,list,list);
static single cgbiwrcase(single,single,list,list,list,FILE*);

single fputdippigt(r1,r2,C,PP,CGB0,CGB1,VL1,VL2,pf)
single r1,r2;
list   C,PP,CGB0,CGB1,VL1,VL2;
FILE *pf;
{
  single err=0,s,t;
  list   C0,C1,COND;

  bind(C,PP,CGB0,CGB1,VL1,VL2);
  init(C0,C1,COND);
/*
 * Ausgabe
 */

  if ( fprintf(pf,"\nGroebner test for ") != 0 )  return(ERROR);
  if ( C != _0 ) {
     if ( fprintf(pf,"case distinction\n") != 0 )  return(ERROR);
     if ( cgbiwrcase(r1,r2,VL1,VL2,C,pf) != 0 )  return(ERROR);
     if ( fprintf(pf,"\nand ") != 0 )  return(ERROR);
  }
  if ( fprintf(pf,"polynomial list") != 0 )  return(ERROR);
  if ( fputdippil(r1,r2,PP,VL1,VL2,pf) != 0 )  return(ERROR);

  C0 = CGB0;
  C1 = CGB1;
  if ( C0 != _0 && C1 != _0 ) {
     if ( fprintf(pf,"\nconditions such that G is Groebner basis") != 0 )  return(ERROR);
     t = 0;
     while ( C0 != _0 ) {
           COND = lfirst(C0);
           C0   = lred(C0);
           s    = cgbcp(r1,r2,COND,C1);
           if ( s == 0 )  s = cgbcp(r1,r2,COND,C0);
           if ( s == 0 ) {
              if ( cgbiwrcond(r1,r2,VL1,VL2,COND,pf) != 0 ) { err = ERROR; break; }
              t = 1;
           }
     }
     if ( !err && t == 0 ) {
        if ( fprintf(pf,"sorry, none.\n") != 0 )  return(ERROR);
     }
  }

  if ( !err && C1 != _0 ) {
     if ( fprintf(pf,"\nconditions such that G is no Groebner basis") != 0 )  return(ERROR);
     while ( C1 != _0 ) {
           COND = lfirst(C1);
           C1   = lred(C1);
           s    = cgbcp(r1,r2,COND,C1);
           if ( s == 0 ) {
              if ( cgbiwrcond(r1,r2,VL1,VL2,COND,pf) != 0 ) { err = ERROR; break; }
           }
     }
  }

  if ( !err && CGB1 == _0 )  err = fprintf(pf,"\nG is comprehensive Groebner basis.\n");
  return(err);
}



/*c
			cgbcp( r1, r2, COND, CONDS )	(static)

        "comprehensive Groebner basis, condition part"
        static single cgbcp(r1,r2,COND,CONDS)  single r1,r2; list COND,CONDS;
        s = cgbcp(r1,r2,COND,CONDS);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - COND ist eine Bedingung;
              - CONDS ist eine Liste von Bedingungen.
        s = 1, wenn COND eine Bedingung aus CONDS ist
               oder wenn COND ein Nachfolger einer Bedingung aus CONDS ist,
        s = 0, sonst.
c*/

static single cgbcp(r1,r2,COND,CONDS)
single r1,r2;
list   COND,CONDS;
{
/*
 * Fall: COND == {}  oder  CONDS == {}  - Anfang
 */
  if ( COND == _0 || CONDS == _0 )  return(0);
/*
 * Fall: COND == {}  oder  CONDS == {}  - Ende
 * Fall: COND != {}  und   CONDS != {}
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    list   A,A0,A1,COND0,COND1,X;

    bind(COND,CONDS);
    init(A,A0,A1,COND0,COND1,X);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    X     = CONDS;
    COND0 = lfirst(COND);
    COND1 = lsecond(COND);
/*
 * Vorbesetzen - Ende
 * Test, ob COND in CONDS - Anfang
 */
    do {
       A  = lfirst(X);
       X  = lred(X);
       if ( A != _0 ) {
          A0 = lfirst(A);
          if ( lred(A) != _0 ) {
             A1 = lsecond(A);
             s  = cgbainb(r1,r2,COND0,A0);
             if ( s == 1 )  s = cgbainb(r1,r2,COND1,A1);
          }
       }
    } while ( X != _0 && s != 1 );
/*
 * Test, ob COND in CONDS - Ende
 * Rueckgabe
 */
    return(s);
  }
}



/*c
			cgbiwrcase( r1, r2, VL1, VL2, DE, pf )	(static)

        "comprehensive Groebner basis over integers, write case distinction"
        static single cgbiwrcase(r1,r2,VL1,VL2,DE,pf)  single r1,r2;
        	list VL1,VL2,DE; FILE *pf;
        a = cgbiwrcase(r1,r2,VL1,VL2,DE,pf);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - VL1 ist die Liste der Variablennamen;
              - VL2 ist die Liste der Parameternamen;
              - DE ist eine Fallunterscheidung.
	cgbiwrcase schreibt die Fallunterscheidung in die Datei *pf.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/

static single cgbiwrcase(r1,r2,VL1,VL2,DE,pf)
single r1,r2;
list   VL1,VL2,DE;
FILE   *pf;
{
/*
 * Fall DE == {} oder DE == 0  - Anfang
 */
  if ( DE == _0 || DE == 0 )  return(fprintf(pf,"{}\n"));
/*
 * Fall DE == {} oder DE == 0  - Ende
 * Fall DE != {} und  DE != 0
 */
  {
    single err=0;
    list   DL,COND;

    bind(VL1,VL2,DE);
    init(DL,COND);
/*
 * Ausgabe
 */
    DL = DE;
    while ( DL != _0 ) {
          COND = lfirst(DL);
          DL   = lred(DL);
          if ( cgbiwrcond(r1,r2,VL1,VL2,COND,stdout) != 0 ) { err = ERROR; break; }
    }
    if ( !err ) err = fprintf(pf,"\n");
    return(err);
  }
}
