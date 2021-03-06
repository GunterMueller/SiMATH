/*M
.SH NAME
fputdipmipl - file put distributive polynomial over modular integer primes list

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputdipmipl(r, p, PL, VL, pf)  
single r; 
int p; 
list PL, VL; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4                                                                           
.B PL                                                                           
is a list of distributive polynomials in r variables over Z/pZ.  
.TP 4                                                                           
.B VL
= (V1 ... Vr)                                                                   
is a list of variables names, used by the polynomials in PL (s. pmakevl).       
For r = 0, VL is the empty list.                                                
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                                             
fputdipmipl writes PL to the file *pf. The several ends of the polynomials will be marked with '#'.
.PP                                                                             
fputdipmipl returns                                                               
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                           

M*/

/*H
	Version 1	30.06.1993	Th. Weis
   DATE fputdipmipl   : 931130
H*/

#include <_pol1.h>

single fputdipmipl(r,p,PL,VL,pf)
single r;
int    p;
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

    bind(p,PL,VL);
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
          if ( fputpmi(r,p,P,VL,pf) != 0 ) { err = ERROR; break; }
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
