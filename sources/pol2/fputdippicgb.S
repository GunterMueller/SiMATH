/*M
.SH NAME
fputdippicgb - file put distributive polynomial over polynomials over integers
comprehensive Groebner basis

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippicgb(r1, r2, CGBL, i, VL1, VL2, pf)  
single r1, r2, i;
list CGBL, VL1, VL2; 
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
.B CGBL
is a list, created by dippicgb resp. dippircgb, which contains a comprehensive resp. reduced comprehensive Groebner basis.   
.IP
The polynomials in CGBL are polynomials in R1.
.TP 4
.B i
is the number of edges of the respective Groebner system.
.TP 4
.B pf
points to an input file.
.PP
fputdippicgb writes CGBL and i to the file *pf in the shape
.IP
 {
  p1
  ...
  pm
 }
 i condition(s)
.PP
where the pi, i=1,...,m, are the polynomials of the basis.
.PP
fputdippicgb returns 0 by success, ERROR else.

.SH SEE ALSO
 dippicgb
 dippircgb

M*/
      
/*H
        Version 1	28.06.1993	Th. Weis
   DATE fputdippicgb  : 931130
H*/

#include <_pol2.h>

fputdippicgb(r1,r2,CGBL,i,VL1,VL2,pf)
single r1,r2;
list   CGBL;
single i;
list   VL1,VL2;
FILE   *pf;
{
/*
 * Fall: CGBL == {}  - Anfang
 */
  if ( CGBL == _0 )  return(fprintf(pf,"{}\n%d condition(s).\n",i));
/*
 * Fall: CGBL == {}  - Ende
 * Fall: CGBL != {}
 */
  {
    single err;

    bind(CGBL,VL1,VL2);
/*
 * Ausgabe - Anfang
 */
    err = cgbiwrclp(r1,r2,VL1,VL2,CGBL,0,pf);
    if ( !err )  err = fprintf(pf,"%d condition(s).\n",i);
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
    return(err);
  }
}
