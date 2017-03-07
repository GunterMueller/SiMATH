/*M
.SH NAME
fputdippil - file put distributive polynomial over polynomials over integers list
 
.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippil(r1, r2, PL, VL1, VL2, pf)  
single r1, r2;
list PL, VL1, VL2; 
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
.B PL
is a list of distributive polynomials in R1.
.TP 4
.B pf
points to an input file.
.PP
fputdippil writes the list Pl to the file *pf, in the shape 
.IP
{ p1, ..., pm }.
.PP
The ends of the polynomials will be marked with '#'.
.PP
fputdippil returns 0 by success or ERROR else.

.SH SEE ALSO
 putdippil
 getdippil
 fgetdippil

M*/

/*H
	Version 1	10.05.1993	Th. Weis
        Version 2	28.06.1993	Programm Dokumentation angepasst.  TW
   DATE fputdippil    : 930531.931130
H*/

#include <_pol2.h>

single fputdippil(r1,r2,PL,VL1,VL2,pf)
single r1,r2;
list   PL,VL1,VL2;
FILE   *pf;
{
/*
 * Fall: PL == {}  - Anfang
 */
  if ( PL == _0 )  return(fprintf(pf,"{}\n"));
/*
 * Fall: PL == {}  - Ende
 * Fall: PL != {}
 */
  {
    single err=0;
    list   PP,P,VL;

    bind(PL,VL1,VL2);
    init(PP,P,VL);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"\n{\n") != 0 )  return(ERROR);
    PP = PL;
    VL = lcconc(VL2,VL1);
    while ( PP != _0 ) {
          P = lfirst(PP);
          P = diptop(r1,P);
          if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
          if ( fputpi(r1+r2,P,VL,pf) != 0 ) { err = ERROR; break; }
          if ( fprintf(pf,"\n") != 0 ) { err = ERROR; break; }
          PP = lred(PP);
    }
    if ( !err )  err = fprintf(pf,"}\n");
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
    return(err);
  }
}


