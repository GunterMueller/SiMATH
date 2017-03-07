/*M
.SH NAME
pflprod - polynomial over floating point numbers, product  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pflprod(r, P1, P2)
single r;
pol P1,P2;

.SH DESCRIPTION
pflprod() returns the polynomial P1*P2
where P1 and P2 are polynomials
in r variables over floating point numbers.
M*/

/*H
	Version 1	11.01.1994	S.Schmitt
   DATE pflprod       : 951201
H*/

#include <_pol1.h>

pol pflprod(r,P1,P2)
single r;
pol P1, P2;
{
   single e1, e2, rs;
   pol P1S, P3, P3S, k1, k2;
   bind2(P1,P2);
   init4(P3,P3S,k1,k2);

/* P1 oder P2 gleich 0 */

   if (P1 == 0  ||  P2 == 0) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

   else if (r == 0) P3 = flprod(P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

   else {
      P1 = lcinv(P1);
      P2 = lcinv(P2);
      P3 = 0;
      rs = r-1;
      do {
         k2 = lfirst(P2);
         P2 = lred(P2);
         e2 = lfirst(P2);
         P2 = lred(P2);
         P1S = P1;
         P3S = _0;
         do {
            k1 = lfirst(P1S);
            P1S = lred(P1S);
            e1 = lfirst(P1S);
            P1S = lred(P1S);
            if (rs) k1 = pflprod(rs,k1,k2);
            else k1 = flprod(k1,k2);
            P3S = lcomp2(e1+e2,k1,P3S);
            }
         while (P1S != _0);
         P3 = pflsum(r,P3,P3S);
         }
      while (P2 != _0);
      }

/* Ausgabe */

   return(P3);
}
