/*M
.SH NAME
fputdipgfsl - file put distributive polynomial over Galois-field with single characteristic list

.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputdipgfsl(r, p, AL, PL, VL, Vgfs, pf)  
single r, p;
list AL, PL, VL, Vgfs; 
FILE *pf;
                                                
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B PL
is a list of distributive polynomials, say P1,....,Pm, in r variables over GF(p^n).
.TP 4
.B VL
is the list of variables names, used by the polynomials in PL (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).  
.TP 4
.B pf
points to an input file.  
.PP
fputdipgfsl writes PL to the file *pf in the shape
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.

.SH SEE ALSO
.nf
gfsalgen
pmakevl
              
M*/
                 
/*H
	Version 1	30.06.1993	Th. Weis
   DATE fputdipgfsl   : 931130
H*/

#include <_pol3.h>

single fputdipgfsl(r,p,AL,PL,VL,Vgfs,pf)
single r,p;
list   AL,PL,VL,Vgfs;
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

    bind(AL,PL,VL,Vgfs);
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
          if ( fputpgfs(r,p,AL,P,VL,Vgfs,pf) != 0 ) { err = ERROR; break; }
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
