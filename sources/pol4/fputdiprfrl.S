/*M
.SH NAME
fputdiprfrl - file put distributive polynomial over rational functions over the rationals list

.SH SYNOPSIS
.nf
#include<_pol4.h>

single fputdiprfrl(r1, r2, PL, VL1, VL2, pf)  
single r1, r2;   
list PL, VL1, VL2; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B r1,r2
are integral numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B VL1, VL2
are list of r1 or r2 variables names, respectively (s. pmakevl).
.PP
Let X_1, ..., X_r2 be the variables names of VL2, and let F denote the function field Q(X_1, ..., X_r2).
.TP 4
.B PL
is a list of distributive polynomials in r1 variables over F.   
.TP 4
.B pf
points to an input file. 
.PP
fputdiprfrl writes PL to the file *pf in the shape
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.     

M*/
   
/*H
	Version 1	30.06.1993	Th. Weis
   DATE fputdiprfrl   : 931130
H*/

#include <_pol4.h>

single fputdiprfrl(r1,r2,PL,VL1,VL2,pf)
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
    list   F,PP,P,VL;

    bind(PL,VL1,VL2);
    init(F,PP,P,VL);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"\n{\n") != 0 )  return(ERROR);
    PP = PL;
    VL = lcconc(VL2,VL1);
    while ( PP != _0 ) {
          P = lfirst(PP);
          F = diprfrtorfr(r1,r2,P);
          if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
          if ( fputrfr(r1+r2,F,VL,pf) != 0 ) { err = ERROR; break; }
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
