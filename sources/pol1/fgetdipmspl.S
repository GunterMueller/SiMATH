/*M
.SH NAME
fgetdipmspl - file get distributive polynomial over modular single primes list

.SH SYNOPSIS
.nf
#include<_pol1.h>

list fgetdipmspl(r, p, VL, pf)
single r, p;
list VL;
FILE *pf;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B VL
= (V1 ... Vr)
is a list of variables names, (s. pmakevl).
For r = 0, VL is the empty list.
.TP 4
.B pf
is a pointer to an input file.
.PP
fgetdipmspl reads the list PL from the file pf.
PL consists of distributive polynomials in r variables over Z/pZ.
.PP
fgetdipmspl returns the list PL, or ERROR in case of an error has occured.

M*/

/*H
	Version 1       30.06.1993      Th. Weis
   DATE fgetdipmspl   : 931130
H*/

#include <_pol1.h>

list fgetdipmspl(r,p,VL,pf)
single r,p;
list   VL;
FILE   *pf;
{
  single c, f = 0;
  list   PL;
  pol    P;

  bind(VL);

  /*** Fehlerbehandlung   ***/

  if ( (c=fgetcs(pf)) == EOF ) {
     errmsgio( "fgetvec", "MA120" );
     return(ERROR);
  }
  if ( c != '{' ) {
         errmsgio( "fgetvec", "MA132" );
     f = 1;
  }
  c = fgetcs(pf);
  if ( c == '{' ) {
         errmsgio( "fgetvec", "V000" );
     f = 1;
  }

  /*** Einlesen   ***/

  init(PL,P);

  PL = _0;
  while ( c != '}' ) {
            ungetc(c,pf);
        P = fgetpms(r,p,VL,pf);
        P = ptodip(r,P);
        if ( P == ERROR ) {
               errmsgio( "fgetvec", "V001" );
           f = 1;
        }
        switch ( EVORD ) {
               case  1:                          break;
               case  2: P = dipmsplotglo(r,p,P); break;  /*  <----  wichtig fuer graduiert lexiko.  ---- */
               case  3: P = dipmsplottdo(r,p,P); break;  /*  <----  wichtig fuer Totalgrad          ---- */
               case  4: P = dipmsplotlio(r,p,P); break;  /*  <----  wichtig fuer lexiko. mit umgek. Exponentenvek. ---- */
               default:                          break;
        }
        PL = lcomp(P,PL);
        if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
  }
  if ( f )  return(ERROR);
  return(linv(PL));
}
