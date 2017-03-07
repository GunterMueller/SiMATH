/*M
.SH NAME
fputdippiqff - file put distributive polynomial over polynomials over integers quantifier free formula

.SH SYNOPSIS
.nf
#include<_pol2.h>

single fputdippiqff(r1, r2, QFFL, VL1, VL2, pf)  
single r1, r2;
list QFFL, VL1,i VL2; 
FILE *pf;
                  
.SH DESCRIPTION
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.TP 4
.B QFFL
is the quantifier free formula of a basis, created for example by dippiqff (s.dippiqff).
.TP 4
.B pf
points to an input file.
.PP
fputdippiqff writes QFFL to *pf, in the shape
.PP
             ( ( a == 0 )  or
             ( b != 0 )  or ... or  ( c != 0 ) )

             and

             ( ( d == 0 )  or
             ( e != 0 )  or ... or  ( f != 0 ) )

             and
             .                      
             .
             .
             and

             ( ( g == 0 )  or
             ( h != 0 )  or ... or  ( k != 0 ) );
.PP
whereat
.TP
.B a,b,c,...
are coefficients polynomials (polynomials in R2).
.PP
fputdippiqff returns 0 by success and ERROR else.

.SH SEE ALSO
 putdippiqff
 dippiqff
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2       

M*/

/*H
	Version 1	21.05.1993	Th. Weis
   DATE fputdippiqff  : 931130
H*/

#include <_pol2.h>

fputdippiqff(r1,r2,QFFL,VL1,VL2,pf)
single r1,r2;
list   QFFL,VL1,VL2;
FILE   *pf;
{
 single err=0,b,s,t;
 list   COEFLI,COEF,PA;
 list   L;

 bind(QFFL,VL1,VL2);
 init(COEFLI,COEF,PA,L);
/*
 * Ausgabe - Anfang
 */
 fprintf(pf,"\n");
 if ( QFFL == ERROR )  return(fprintf(pf,"false\n"));
 L = QFFL;
 s = 0;
 t = 0;
 while ( L != _0 ) {
       b      = lfirst(L);
       COEFLI = lsecond(L);
       COEF   = lthird(L);
       L      = lred3(L);
       if ( COEF != _0 && b == 0 ) {
          s = 1;
          if ( COEF != 0 ) {
             if ( t == 1 ) {
                if ( fprintf(pf,"\n\nand\n\n") != 0 ) { err = ERROR; break; }
             }
             t = 1;
             if ( fprintf(pf,"( ( ") != 0 ) { err = ERROR; break; }
             if ( fputpi(r2,COEF,VL2,pf) != 0 ) { err = ERROR; break; }
             if ( fprintf(pf,"  == 0 )") != 0 ) { err = ERROR; break; }
             if ( COEFLI != _0 ) {
                if ( fprintf(pf,"  or\n") != 0 ) { err = ERROR; break; }
             }
          }
          while ( COEFLI != _0 ) {
                PA     = lfirst(COEFLI);
                COEFLI = lred(COEFLI);
                if ( fprintf(pf,"( ") != 0 ) { err = ERROR; break; }
                if ( fputpi(r2,PA,VL2,pf) != 0 ) { err = ERROR; break; }
                if ( fprintf(pf,"  != 0 )") != 0 ) { err = ERROR; break; }
                if ( COEFLI != _0 ) {
                   if ( fprintf(pf,"  or  ") != 0 ) { err = ERROR; break; }
                }
          }
          if ( !err && fprintf(pf," )") != 0 ) { err = ERROR; break; }
       }
 }
 if ( !err && s == 0 )  err = fprintf(pf,"true");
 if ( !err )  err = fprintf(pf,"\n");
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
 return(err);
}
