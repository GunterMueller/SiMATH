/*M
.SH NAME
udpicycgen - univariate dense polynomial over integers cyclotomic polynomial 
generation. 

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpicycgen(n)  
single n;

.SH DESCRIPTION
.TP 4
.B n is a single number, n > 1. 
.PP
udpicycgen returns the n-th cyclotomic polynomial as univariate 
dense polynomial over integers. 
M*/

/*H
	Version 1     04.04.00      Marc Conrad
H*/


# include <_pol1.h>

pol udpicycgen(n)
single n; 
{
   list L; 
   pol P, Q, X; 
   single p, d; 
   rat R; 
   init(R, P, Q, L, X); 
   Q = ptodp(1, list4(n,1, 0, -1)); 
   if( n == 1 ) { return (Q); } 
   Q = udpitoudpr(Q); 
   L = lfirst(iflel(n)); 
   while( L != _0 ) { 
      p = lfirst(L); 
      L = lred(L); 
      d = n/p; 
      P = udpitoudpr(ptodp(1, list4(d,1,0,-1))); 
      P = udprgcd(P, Q); 
      Q = udprqrem(Q, P, &X);   
      } 
/* Umrechnung pr -> pi */
   P = list1(lfirst(Q)); 
   Q = lred(Q); 
   R = lfirst(Q); 
   while( Q != _0 ) { 
       p = rfloor(rquot(lfirst(Q), R));  
       Q = lred(Q);  
       P = lcomp(p, P); 
       } 
   return linv(P); 
}

/* Testprogramm 
testXXXXXmain() {
   single n; 
   pol P, Q, R, V;
   list f, g, h;
   init(f, g, h);
   init(P, Q, R, V);
   for( n = 1; n < 1000; n++ ) { 
      V = pmakevl("b");
      P = udpicycgen(n);
      printf("n = %d\n", n); 
      f = list3(1,1,1);
      g = nfexp(P,f, n);
      if( !oequal( g, list3(1,0,1) ) ) {
        printf("P = %obj\n", P);
        putpi(1,dptop(1,P),V);
        printf("n = %d, g = %obj, f = %obj\n", n, g, f);
        printf("\n*****************Fehler!!!!\n");
        exit(1);
        }
      } 
   }
*/

