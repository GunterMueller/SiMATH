/*M
.SH NAME
pflneg - polynomial over floating point numbers, negation  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pflneg(r, P)
single r;
pol P;

.SH DESCRIPTION
pflneg() returns the polynomial -P
where P is a polynomial in r variables over floating point numbers.
M*/


/*H
	Version 1	11.01.1995	S.Schmitt
   DATE pflneg        : 951201
H*/

#include <_pol1.h>

pol pflneg(r,P)
single r;
pol P;
{
   single e;
   pol P1, k;
   bind(P);
   init2(P1,k);

/* P gleich 0 */

   if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

   else if (r == 0) P1 = flneg(P);

/* allgemeiner Fall: r,P ungleich 0 */

   else {
      r--;
      P1 = _0;
      do {
         e = lfirst(P);
         P = lred(P);
         k = lfirst(P);
         P = lred(P);
         if (r) k = pflneg(r,k);
         else k = flneg(k);
         P1 = lcomp2(k,e,P1);
         }
      while (P != _0);
      P1 = linv(P1);
      }

/* Ausgabe */

   return(P1);
}
