/*M
.SH NAME
fputdippipim - file put distributive polynomial over polynomials over integers parametric ideal membership test

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippipim(r1, r2, NOUT, VL1, VL2, pf)  
single r1, r2;
list NOUT, VL1, VL2; 
FILE *pf;
                 
.SH DESCRIPTION
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polnomials in R1 resp. R2.
.TP 4
.B NOUT
is a list, consisting of the polynomials, tested for parametric ideal membership, the conditions and normal forms, so that a  polynomial is member of the ideal, and the conditions and normal forms, so that a polynomial is not member of the ideal
(s. dippipim). The polynomials occuring are polynomials in R1.
.TP 4
.B pf
points to an input file.      
.PP
fputdippipim writes NOUT to the file *pf, in the shape
.nf
.IP          
tested polynomial
TP1 #
.IP
polynomial completely reduced for
the following condition(s)
.IP
condition:
{
{ cfp11 # ... cfp1m # } == 0
{ cfp21 # ... cfp2n # } != 0
}
factor
cff1 #
          
 .
 .
 .

polynomial not completely reduced for
the following condition(s)

condition:
{
{ cfp31 # ... cfp3l # } == 0
{ cfp41 # ... cfp4k # } != 0
}
reduced to
RTP1 #
factor
cff2 #

 .
 .
 .

quantifier free formula for
parametric ideal membership
( ( a == 0 )  and ... and  ( b == 0 )  and ( c != 0 )  and
 ... and  ( d != 0 ) )

or
 .
 .
 .
or

( ( e == 0 )  and ... and  ( f == 0 )  and ( g != 0 )  and
 ... and  ( h != 0 ) )

tested polynomial
TP2 #
               
 .
 .
 .    ,                                                  
.PP
whereat 
.TP
.B TP1, TP2
are the tested polynomials,
.TP 4
.B cfpij
are coefficient polynomials, creating the conditions, and
.TP 4
.B a,b,c,...
are coefficient polynomials.
.PP
fputdippipim returns 0 by success and ERROR else.

.SH SEE ALSO
 dippipim
 putdippipim

M*/ 

/*H
        Version 1	12.06.1993	Th. Weis
   DATE fputdippipim  : 931130
H*/

#include <_pol2.h>

static single cgbinfw0(single,single,list,list,list,FILE*);
static single cgbinfw1(single,single,list,list,list,FILE*);
static single cgbiwqffpims(single,single,list,list,list,FILE*);

single fputdippipim(r1,r2,NOUT,VL1,VL2,pf)
single r1,r2;
list   NOUT,VL1,VL2;
FILE   *pf;
{
  single err=0;
  list   NN,NN0,NN1,PP,POL,VL;

  bind(NOUT,VL1,VL2);
  init(NN,NN0,NN1,PP,POL,VL);
/*
 * Ausgabe - Anfang
 */
  NN = NOUT;
  VL = lcconc(VL2,VL1);
  while ( NN != _0 ) {
        POL = lfirst(NN);
        NN  = lred(NN);
        NN0 = lfirst(NN);
        NN  = lred(NN);
        NN1 = lfirst(NN);
        NN  = lred(NN);
        if ( fprintf(pf,"\ntested polynomial\n") != 0 ) { err = ERROR; break; }
        PP = diptop(r1,POL);
        if ( fputpi(r1+r2,PP,VL,pf) != 0 ) { err = ERROR; break; }
        if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
        if ( NN0 != _0 ) {
           if ( cgbinfw0(r1,r2,VL1,VL2,NN0,pf) != 0 ) { err = ERROR; break; }
        }
        if ( NN1 != _0 ) {
           if ( cgbinfw1(r1,r2,VL1,VL2,NN1,pf) != 0 ) { err = ERROR; break; }
        }
        if ( cgbiwqffpims(r1,r2,VL1,VL2,NN0,pf) != 0 ) { err = ERROR; break; }
        if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
  }
/*
 * Ausgabe - Ende
 * Ruecksprung
 */
  return(err);
}



/*c
		cgbinfw0( r1, r2, VL1, VL2, N, pf )	(static)

        "comprehensive Groebner basis over integers, normalforms write 0"
        static single cgbinfw0(r1,r2,VL1,VL2,N,pf)  single r1,r2; 
		list VL1,VL2,N; FILE *pf;
        a = cgbinfw0(r1,r2,VL1,VL2,N,pf);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - VL1 ist die Liste der Variablennamen;
              - VL2 ist die Liste der Parameternamen;
              - N ist eine Liste von Tripeln, wobei jede eine
                Bedingung enthaelt, ein bzgl. der Bedingung
                gruen gefaerbtes Polynom und ein Faktor C.
              - pf ist ein Zeiger auf eine zum Schreiben geoeffnete
                Datei.
        Die Polynome bilden eine Liste von Normalformen. Die
        Bedingungen und die Faktoren werden auf die Datei *pf
        geschrieben.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/

static single cgbinfw0(r1,r2,VL1,VL2,N,pf)
single r1,r2;
list   VL1,VL2,N;
FILE   *pf;
{
/*
 * Fall: N == {}  - Anfang
 */
  if ( fprintf(pf,"\n") != 0 )  return(ERROR);
  if ( N == _0 )  return(fprintf(pf,"empty\n"));
/*
 * Fall: N == {}  - Ende
 * Fall: N != {}
 */
  {
    single err=0;
    list   C,COND,NP,PCO,VL;

    bind(VL1,VL2,N);
    init(C,COND,NP,PCO,VL);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"polynomial completely reduced for\n") != 0 )  return(ERROR);
    if ( fprintf(pf,"the following condition(s)\n") != 0 )  return(ERROR);
    NP = N;
    VL = lcconc(VL2,VL1);
    while ( NP != _0 ) {
          COND = lfirst(NP);
          NP   = lred(NP);
          PCO  = lfirst(NP);
          NP   = lred(NP);
          C    = lfirst(NP);
          NP   = lred(NP);
          if ( cgbiwrcond(r1,r2,VL1,VL2,COND,pf) != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"factor\n") != 0 ) { err = ERROR; break; }
          if ( fputpi(r2,C,VL2,pf) != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
    }
/*
 * Ausgabe - Ende
 * Ruecksprung
 */
    return(err);
  }
}



/*c
		cgbinfw1( r1, r2, VL1, VL2, N, pf )	(static)

        "comprehensive Groebner basis over integers, normalforms write 1"
        static single cgbinfw1(r1,r2,VL1,VL2,N,pf)  single r1,r2;
                      list VL1,VL2,N; FILE *pf;
        a = cgbnfw1(r1,r2,VL1,VL2,N);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - VL1 ist die Liste der Variablennamen;
              - VL2 ist die Liste der Parameternamen;
              - N ist eine Liste von Tripeln, wobei jede eine
                Bedingung enthaelt, ein bzgl. der Bedingung
                gruen gefaerbtes Polynom und ein Faktor C.
              - pf ist ein Zeiger auf eine zum Schreiben geoeffnete
                Datei.
        Die Polynome bilden eine Liste von Normalformen. Die
        Bedingungen und die Faktoren werden auf die Datei *pf
        geschrieben.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/

static single cgbinfw1(r1,r2,VL1,VL2,N,pf)
single r1,r2;
list   VL1,VL2,N;
FILE   *pf;
{
/*
 * Fall: N == {}  - Anfang
 */
  if ( fprintf(pf,"\n") != 0 )  return(ERROR);
  if ( N == _0 )  return(fprintf(pf,"empty\n"));
/*
 * Fall: N == {}  - Ende
 * Fall: N != {}
 */
  {
    single err=0;
    list   C,COL,COND,NP,PCO,POL,PP,VL;

    bind(VL1,VL2,N);
    init(C,COL,COND,NP,PCO,POL,PP,VL);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"polynomial not completely reduced for\n") != 0 )  return(ERROR);
    if ( fprintf(pf,"the following condition(s)\n") != 0 )  return(ERROR);
    NP = N;
    VL = lcconc(VL2,VL1);
    while ( NP != _0 ) {
          COND = lfirst(NP);
          NP   = lred(NP);
          PCO  = lfirst(NP);
          NP   = lred(NP);
          C    = lfirst(NP);
          NP   = lred(NP);
          if ( cgbiwrcond(r1,r2,VL1,VL2,COND,pf) != 0 ) { err = ERROR; break; }
          POL = lfirst(PCO);
          COL = lsecond(PCO);
          if ( fprintf(pf,"reduced to\n") != 0 ) { err = ERROR; break; }
          PP = diptop(r1,POL);
          if ( fputpi(r1+r2,PP,VL,pf) != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"factor\n") != 0 ) { err = ERROR; break; }
          if ( fputpi(r2,C,VL2,pf) != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
    }
/*
 * Ausgabe - Ende
 * Ruecksprung
 */
    return(err);
  }
}



/*c
		cgbiwqffpims( r1, r2, VL1, VL2, N0, pf )	(static)

        "comprehensive Groebner basis over integers, write quantifier
         free formula for parametric ideal membership"
        static single cgbiwqffpims(r1,r2,VL1,VL2,N0,pf)  single r1,r2;
                      list VL1,VL2,N0; FILE *pf;
        a = cgbiwqffpims(r1,r2,VL1,VL2,N0,pf);
        Dabei muss gelten:
              - 0 <= r1 < BASIS  ist die Anzahl der Variablen;
              - 0 <= r2 < BASIS  ist die Anzahl der Parameter;
              - VL1 ist die Liste der Variablennamen;
              - VL2 ist die Liste der Parameternamen;
              - N0 ist eine Liste von Tripel der Form ( COND,PCO,C ),
                wobei:
                - COND eine Bedingung ist;
                - PCO eine Normalform von FCO ist, bei der die Koef-
                  fizienten alle gruen bzgl. COND sind;
                - C ist multiplikativer Faktor.
              - pf ist ein Zeiger auf eine zum Schreiben geoeffnete
                Datei.
        Die Formel wird auf den Bildschirm geschrieben.
	a ist
	    0	   falls der Programmlauf fehlerfrei war;
	    ERROR  falls Fehler auftraten.
c*/

static single cgbiwqffpims(r1,r2,VL1,VL2,N0,pf)
single r1,r2;
list   VL1,VL2,N0;
FILE   *pf;
{
/*
 * Fall: N0 == {}  - Anfang
 */
  if ( fprintf(pf,"\nquantifier free formula for\n") != 0 )  return(ERROR);
  if ( fprintf(pf,"parametric ideal membership\n") != 0 )  return(ERROR);
  if ( N0 == _0 )  return(fprintf(pf,"false"));
  if ( fprintf(pf,"\n") != 0 )  return(ERROR);
/*
 * Fall: N0 == {}  - Anfang
 * Fall: N0 != {}
 */
  {
    single err=0;
    list   C,C0,COND,COND0,COND1,NN0,PA,PCO;

    bind(VL1,VL2,N0);
    init(C,C0,COND,COND0,COND1,NN0,PA,PCO);
/*
 * Schreibe Bedingungen - Anfang
 */
    NN0 = N0;
    while ( NN0 != _0 ) {
          COND  = lfirst(NN0);
          NN0   = lred(NN0);
          PCO   = lfirst(NN0);
          NN0   = lred(NN0);
          C     = lfirst(NN0);
          NN0   = lred(NN0);
          COND0 = lfirst(COND);
          COND1 = lsecond(COND);
          C0    = COND0;
          if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
          while ( COND0 != _0 ) {
                PA    = lfirst(COND0);
                COND0 = lred(COND0);
                if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
                if ( fputpi(r2,PA,VL2,pf) != 0 ) { err = ERROR; break; }
                if ( fprintf(pf,"  == 0 ) ") != 0 ) { err = ERROR; break; }
                if ( COND0 != _0 ) {
                   if ( fprintf(pf," and  ") != 0 ) { err = ERROR; break; }
                }
          }
          if ( !err && C0 != _0 && COND1 != _0 ) {
             if ( fprintf(pf," and  ") != 0 ) { err = ERROR; break; }
          }
          while ( COND1 != _0 ) {
                PA    = lfirst(COND1);
                COND1 = lred(COND1);
                if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
                if ( fputpi(r2,PA,VL2,pf) != 0 ) { err = ERROR; break; }
                if ( fprintf(pf,"  != 0 ) ") != 0 ) { err = ERROR; break; }
                if ( COND1 != _0 ) {
                   if ( fprintf(" and  ") != 0 ) { err = ERROR; break; }
                }
          }
          if ( !err && fprintf(pf,")") != 0 ) { err = ERROR; break; }
          if ( NN0 != _0 ) {
             if ( fprintf(pf,"\n\nor\n\n") != 0 ) { err = ERROR; break; }
          }
    }
    if ( !err )  err = fprintf(pf,"\n");
/*
 * Schreibe Bedingungen - Ende
 * Ruecksprung
 */
    return(err);
  }
}
