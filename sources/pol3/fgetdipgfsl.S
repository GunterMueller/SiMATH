/*M
.SH NAME
fgetdipgfsl - file get distributive polynomial over Galois-field with single characteristic list

.SH SYNOPSIS
.nf
#include<_pol3.h>

list fgetdipgfsl(r, p, AL, VL, Vgfs, pf)  
single r, p; 
list AL, VL, Vgfs;
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
.B VL
is the list of variables names of lenght >= r (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).
.TP 4
.B pf
points to an output file.  
.PP
fgetdipgfsl reads a list of distributive polynomials over GF(p^n) from the file *pf.
.TP 4
Following rules must be considered:                                      
 1. The end of the polynomial must be marked with '#'.
 2. Only positive exponents are allowed. They must be
    marked by the prefix '^' or '**'. The input of the
    powers 1 or 0 is not necessary, but in the second
    case, the input of the according variable had to
    remain undone too.
 3. Coefficients of any size are allowed. The
    coefficient and its sign can be seperated by
    blanks, the coefficient and the according
    variables can be seperated by any blanks and/or
    '*'. These seperations are not necessary. The
    input of the coefficient 1 is not necessary.
 4. Variable names must be mentioned in VL, they are
    not allowed to be seperated by special
    characters.
    Single variables and its exponents can be
    seperated to other variables by any blanks and/or
    '*'. This seperation is only necessary if no
    exponent was specified.
 5. Appears a variable in a single monomial more than
    once, the several occurances will be merged.     
    Appears a monomial more than once, the several
    occurances will be merged.
 6. The monomials will be sorted according to the
    term order defined by the value of EVORD.


    Following values can occur:
    EVORD = 1 : lexicographical order,
          = 2 : graduated lexicographical order,
          = 3 : total degree ordering,
          = 4 : lexicographical order with inverse
                exponent vector.
    Default is EVORD = 1.
 7. The list of polynomials must beginn with '{'
    and end with '}'. The several polynomials must be
    seperated by commas.
.PP
fgetdipgfsl returns the list of distributive polynomials by success, ERROR else.

M*/
                                                                        
/*H
	Version 1       30.06.1993      Th. Weis
   DATE fgetdipgfsl   : 931130
H*/

#include <_pol3.h>

list fgetdipgfsl(r,p,AL,VL,Vgfs,pf)
single r,p;
list   AL,VL,Vgfs;
FILE   *pf;
{
  single c, f = 0;
  list   PL;
  pol    P;

  bind(AL,VL,Vgfs);

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
        P = fgetpgfs(r,p,AL,VL,Vgfs,pf);
        P = ptodip(r,P);
        if ( P == ERROR ) {
               errmsgio( "fgetvec", "V001" );
           f = 1;
        }
        switch ( EVORD ) {
               case  1:                             break;
               case  2: P = dipgfslotglo(r,p,AL,P); break;  /*  <----  wichtig fuer graduiert lexiko.  ---- */
               case  3: P = dipgfslottdo(r,p,AL,P); break;  /*  <----  wichtig fuer Totalgrad          ---- */
               case  4: P = dipgfslotlio(r,p,AL,P); break;  /*  <----  wichtig fuer lexiko. mit umgek. Exponentenvek. ---- */
               default:                             break;
        }
        PL = lcomp(P,PL);
        if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
  }
  if ( f )  return(ERROR);
  return(linv(PL));
}
