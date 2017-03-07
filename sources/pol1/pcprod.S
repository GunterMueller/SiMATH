/*M
.SH NAME
pcprod - polynomial over the complex numbers, product (recursive)                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>

pol pcprod(r, P1, P2)  
single r; 
pol P1, P2;                                                                       
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer, 0 <= r < BASIS.        
.TP 4
.B P1, P2
are polynomials in r variables over the complex numbers.
.PP
pcprod returns the polynomial P3, where 
.IP
P3 = P1 * P2.
                                                                 
M*/                                  

/*H
	Version 1	15.01.1994	Georg Lay
   DATE pcprod        : 941201
H*/

#include <_pol1.h>

/*
   pcprod ist von pisum abgeschrieben:
   isum |-> csum	iprod |-> cprod
*/

pol pcprod(r,P1,P2)
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

   else if (r == 0) P3 = cprod(P1,P2);

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
            if (rs) k1 = pcprod(rs,k1,k2);
            else k1 = cprod(k1,k2);
            P3S = lcomp2(e1+e2,k1,P3S);
            }
         while (P1S != _0);
         P3 = pcsum(r,P3,P3S);
         }
      while (P2 != _0);
      }

/* Ausgabe */

   return(P3);
}
