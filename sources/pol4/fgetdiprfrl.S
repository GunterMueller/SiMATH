/*M
.SH NAME
fgetdiprfrl - file get distributive polynomial over rational functions over the rationals list

.SH SYNOPSIS
.nf
#include<_pol4.h>

list fgetdiprfrl(r1, r2, VL1, VL2, pf)  
single r1, r2; 
list VL1, VL2;  
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B r1,r2
are integral numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B VL1, VL2
are list of r1 or r2 variables names, respectively (s. pmakevl).
.TP 4
.B pf
points to an output file.  
.PP
Let X_1, ..., X_r2 be the variables names of VL2, and let F denote the function field Q(X_1, ..., X_r2). fgetdiprfrl reads a list of distributive polynomials in r1 variables over F from the file *pf.
.PP
Following rules must be considered:
.TP 4
1.
The input of the the polynomials is like the input of rational functions,
the denominator  has to be the least common denominator of the coefficients     of the polynomial.
.TP 4
2.
Only positive exponents are allowed. They must be
marked by the prefix '^' or '**'. The input of the
powers 1 or 0 is not necessary, but in the second
case, the input of the according variable had to
remain undone too.
.TP 4
3.
Coefficients of any size are allowed. The
coefficient and its sign can be seperated by
blanks, the coefficient and the according
variables can be seperated by any blanks and/or
'*'. These seperations are not necessary. The
input of the coefficient 1 is not necessary.
.TP 4 
4.
Variable names must be mentioned in VL, they are
not allowed to be seperated by special
characters.
Single variables and its exponents can be
seperated to other variables by any blanks and/or
'*'. This seperation is only necessary if no
exponent was specified.
.TP 4
5.
Appears a variable in a single monomial more than
once, the several occurances will be merged.
Appears a monomial more than once, the several
occurances will be merged.
.TP 4
6.
The monomials will be sorted according to the
term order defined by the value of EVORD.

                                       
    Following values can occur:
    EVORD = 1 : lexicographical order,
          = 2 : graduated lexicographical order,
          = 3 : total degree ordering,
          = 4 : lexicographical order with inverse
                exponent vector.
    Default is EVORD = 1.
.TP 4
7.
The list of polynomials must beginn with '{'
and end with '}'. The several polynomials must be
seperated by commas.
.PP
fgetdiprfrl returns the list of distributive polynomials by success, ERROR else.
                                                                               
M*/
     
/*H
	Version 1       30.06.1993      Th. Weis
   DATE fgetdiprfrl   : 931130
H*/

#include <_pol4.h>

list fgetdiprfrl(r1,r2,VL1,VL2,pf)
single r1,r2;
list   VL1,VL2;
FILE   *pf;
{
  single r,c, f = 0;
  list   F,VL,PL;
  pol    P;

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
  if ( c == '{' ) {
         errmsgio( "fgetvec", "V000" );
     f = 1;
  }

  /*** Einlesen   ***/

  init(F,VL,PL,P);

  VL = lcconc(VL2,VL1);
  r  = r1+r2;
  PL = _0;
  while ( c != '}' ) {
            ungetc(c,pf);
        F = fgetrfr(r,VL,pf); /* <-- siehe Dokumentation zu getrfr und beachte,
                                 dass im Nenner nur Variablen aus VL2 stehen duerfen. */
        P = rfrtodiprfr(r1,r2,F);
        if ( P == ERROR ) {
               errmsgio( "fgetvec", "V001" );
           f = 1;
        }
        switch ( EVORD ) {
               case  1:                            break;
               case  2: P = diprfrlotglo(r1,r2,P); break;  /*  <----  wichtig fuer graduiert lexiko.  ---- */
               case  3: P = diprfrlottdo(r1,r2,P); break;  /*  <----  wichtig fuer Totalgrad          ---- */
               case  4: P = diprfrlotlio(r1,r2,P); break;  /*  <----  wichtig fuer lexiko. mit umgek. Exponentenvek. ---- */
               default:                            break;
        }
        PL = lcomp(P,PL);
        if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
  }
  if ( f )  return(ERROR);
  return(linv(PL));
}
