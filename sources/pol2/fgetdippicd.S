/*M
.SH NAME
fgetdippicd - file get distributive polynomial over polynomials over integers case distinction

.SH SYNOPSIS
.nf
#include<_pol2.h>

list fgetdippicd(r1, r2, VL1, VL2, fac, pf)  
single r1, r2, fac;
list VL1, VL2; 
FILE *pf;
               
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing variables names (s.pmakevl).
.TP 4
.B pf
is a pointer to an input file.    
.PP                                                              
fgetdippicd reads a list, say CONDS (used for example by dippicgb) from the file *pf and returns it, where
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
(s. dippicbg or dippircgb)
.PP
The coefficient polynomials are polynomials in r2 variables over the integer num
bers.
.PP
.TP 4
.B fac
turns the factorization of the coefficient polynomials on (fac=1) or off(fac=0).
.PP
fgetdippicd returns ERROR in the case of an error occurs.    

.SH SEE ALSO
 dippicgb
 dippirgcb
 pmakevl

M*/
              
/*H
	Version 1	22.03.1993	Th. Weis
   DATE fgetdippicd   : 930531.9311__
H*/

#include <_pol2.h>

static list fgetdippicon(single,single,list,list,list,single,single,FILE*);

list fgetdippicd(r1,r2,VL1,VL2,fac,pf)
single r1,r2;
list   VL1,VL2;
single fac;
FILE   *pf;
{
  single c, f = 0;
  list   CONS,CON,X;

  bind(VL1,VL2);

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

  /*** Einlesen   ***/

  init(CONS,CON,X);

  CONS = _0;
  while ( c != '}' ) {
              ungetc(c,pf);
        CON = _0;
        CON = fgetdippicon(r1,r2,VL1,VL2,CON,fac,0,pf);
        if ( (c=fgetcs(pf)) != ',' )  ungetc(c,pf);
        CON = fgetdippicon(r1,r2,VL1,VL2,CON,fac,1,pf);
        if ( CON != _0 ) {
           if ( CONS == _0 )  CONS = CON;
           else {
                X = llast(CONS);
                    lsred(X,CON);
           }
        }
        if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
  }
  if ( f )  return(ERROR);
  return(CONS);
}



/*c
	fgetdippicon( r1, r2, VL1, VL2, CONALT, fac, s, pf )	(static)

	"file get distributve polynomial over polynomials over integers
         condition"
	list fgetdippicon(r1,r2,VL1,VL2,CONALT,fac,s,pf)  single r1,r2;
             list VL1,VL2,CONALT; single fac,s; FILE *pf;
	CONNEU = fgetdippicon(r1,r2,VL1,VL2,CONALT,fac,s,pf);
c*/

static list fgetdippicon(r1,r2,VL1,VL2,CONALT,fac,s,pf)
single r1,r2;
list   VL1,VL2,CONALT;
single fac,s;
FILE   *pf;
{
  single c, f = 0;
  list   COEF,COEFFL,CONNEU;

  bind(VL1,VL2,CONALT);

  /*** Fehlerbehandlung   ***/

  c = fgetcs(pf);
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

  init(COEF,COEFFL,CONNEU);
  CONNEU = CONALT;
  while ( c != '}' ) {
                 ungetc(c,pf);
        COEF   = fgetpi(r2,VL2,pf);
        if ( COEF == ERROR ) {
               errmsgio( "fgetvec", "V001" );
           f = 1;
        }
        COEFFL = cgbiibcfac(r1,r2,COEF,fac);
        CONNEU = cgbucd(r1,r2,COEFFL,CONNEU,s);
        if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
  }
  if ( f )  return(ERROR);
  return(CONNEU);
}

