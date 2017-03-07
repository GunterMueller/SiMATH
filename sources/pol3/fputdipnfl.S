/*M
.SH NAME
fputdipnfl - file put distributive polynomial over number field list

.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputdipnfl(r, F, PL, VL, Vnf, pf)  
single r; 
pol F;
list PL, VL, Vgfs;
FILE *pf;
              
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B PL
is a list of distributive polynomials, say P1,....,Pm, in r variables over K.
.TP 4
.B VL
is the list of variables names, used by the polynomials in PL (s. pmakevl).
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.  
.TP 4
.B pf
points to an input file.  
.PP
fputdipnfl writes PL to the file *pf in the shape
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.

.SH SEE ALSO
.nf
pmakevl
                   
M*/
                   
/*H
	Version 1	30.06.1993	Th. Weis
   DATE fputdipnfl    : 931130
H*/

#include <_pol3.h>

single fputdipnfl(r,F,PL,VL,Vnf,pf)
single r;
pol    F;
list   PL,VL,Vnf;
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
    list   PP,P;

    bind(F,PL,VL,Vnf);
    init(PP,P);
/*
 * Ausgabe - Anfang
 */
    if ( fprintf(pf,"\n{\n") != 0 )  return(ERROR);
    PP = PL;
    while ( PP != _0 ) {
          P = lfirst(PP);
          P = diptop(r,P);
          if ( fprintf(pf," ") != 0 ) { err = ERROR; break; }
          if ( fputpnf(r,F,P,VL,Vnf,pf) != 0 ) { err = ERROR; break; }
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
