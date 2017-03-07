/*M
.SH NAME
iecpt - integer elliptic curve primality test

.SH SYNOPSIS
.nf
#include<_arith1.h>

single iecpt(n,m,lp,a,b,num)
int n,m,a,b;
list lp;
single num;

.SH DESCRIPTION
iecpt() returns 1 if n is prime, 0 if n is not prime
and -1 if it could not be determined whether or not n is prime.
.PP
.TP 4
.B n
> 3 is the number to be tested for primality.
.TP
.B m
it holds that m*P=0 for all points P on the elliptic curve
E: y^2 = x^3 + a*x + b mod p.
.TP 4
.B lp
is the list of prime factors of m.
.TP 4
.B a,b
in Z/nZ are the coefficients of E.
.TP 4
.B num
> 0 is the maximum number of of attempts
when testing for the primality of n.
M*/
/*H
	Version 1	16.1.1993	Georg Lay
   DATE iecpt         : 930531
H*/

#include <_arith1.h>

                       
int iecpt (p,p1,lp,a,b,anz)
int        p,p1,lp,a,b,anz;
 {
 single i;
 int   h1,h2,q,p1q,s,s4p,ww;
 list  l;

 bind (lp);
 init (h1,h2,q,p1q,s,s4p,ww);
 init (l);

 if (lp == _0)				return (UNKNOWN);
 l = lcopy (lp);
 libsort (l);
 lp = ifel (l);

 s4p = isqrt (p);
 s4p = isqrt (s4p);
 s4p = isum  (s4p,1);
 s4p = iprod (s4p,s4p);
  
 for (i = 1; i != anz+1; i++)
   {
   ww = iecfindp (p,a,b);
   if (ww == _0)			return (NOTPRIME);			

   s = 1;
   for (l = lp; l != _0; l = lred2 (l))
     {
     q = lfirst (l);
     p1q = iquot (p1,q);

     h1 = iecpprod (p,p1q,ww,a);
     h2 = iecpprod (p,q  ,h1,a);
/* M. Conrad. 19.02.97: Der Fall h2 ungleich 0 und ungleich _0 sollte meines
   Erachtens nicht vorkommen, bzw. auf eine Nichtprimzahl hindeuten.
   Er kommt aber vor beim Aufruf isiprime((10^25  + 2109)/13).
   Vermutlich ein Bug. 
     if( h2 != 0 && h2 != _0 ) { return (UNKNOWN); }
   M. Conrad, 10.04.97: Nachdem in igkapt der Fehler verbessert ist, sollte
   es hier wieder die alte Version tun.   
   
*/
     if (h2 != 0)			return (NOTPRIME);
 
     if (h1 != 0) 
       {
       q = iexp  (q,lsecond (l));
       s = iprod (s,q);   
       if (icomp (s,s4p) > 0)		return (ISAPRIME);
       }
     }
   }
 					return (UNKNOWN);
 }

