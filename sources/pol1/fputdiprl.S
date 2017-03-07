/*M
.SH NAME
fputdiprl - file put distributive polynomial over rationals list

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputdiprl(r, PL, VL, pf)  
single r; 
list PL, VL; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B PL                                                                           
is a list of distributive polynomials in r variables over the rational numbers. 
.TP 4                                                                           
.B VL                                                                           
= (V1 ... Vr)                                                                   
is a list of variables names, used by the polynomials in PL (s. pmakevl).       
For r = 0, VL is the empty list.                                                
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                    
fputdiprl writes PL to the file *pf. The several ends of the polynomials will be marked with '#'.
.PP                                                                             
fputdiprl returns                                                               
                                                                                
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                                                         
                                                
M*/

/*H
	Version 1	30.06.1993	Th. Weis
   DATE fputdiprl     : 931130
H*/

#include <_pol1.h>

single fputdiprl(r,PL,VL,pf)
single r;
list   PL,VL;
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

    bind(PL,VL);
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
          if ( fputpr(r,P,VL,pf) != 0 ) { err = ERROR; break; }
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
