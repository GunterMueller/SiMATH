/*M
.SH NAME
iftpt - integer Fermat's theorem primality test

.SH SYNOPSIS
.nf
#include<_arith1.h>

single iftpt(n,L,num)
int n;
list L;
single num;

.SH DESCRIPTION
iftpt() returns 1 if n is a prime number,
0 if n is not prime and -1 if it could not
be determined whether or not n is prime.
iftpt() tries to find an element in (Z/nZ)*
that has order r > sqrt(n).  

.PP
.TP 4
.B n
> 3, is the number to be tested.
.TP 4
.B num
> 0, is the maximum number of attempts to find
an element that proves the primality of n.
Useful values for num are 100 - 1000.
.TP 4
.B L
is the list of prime factors of n-1.

.SH SEE ALSO
ispt, isiprime, isipprime, isispprime, ifact, ifactlf
M*/
/*H
	Version 1	16.01.1993	Georg Lay
   DATE iftpt	      : 930531.9311__
H*/

#include <_arith1.h>

                       
int iftpt (p,lp,anz)
int        p,lp,anz;
 {
 single i;
 int   p1,h1,h2,h3,q,p1q,s,s4p,ww;
 list  l;

 bind (lp);
 init (p1,h1,h2,h3,q,p1q,s,s4p,ww);
 init (l);

 if (lp == _0)                          return (UNKNOWN);
 l = lcopy (lp);
 libsort (l);
 lp = ifel (l);

 p1 = idif (p,1);

 s4p = isqrt (p);

 for (i = 1; i != anz+1; i++)
   {
   do    ww = irand (p);
   while (ww == 0);

   if (igcd (ww,p) > 1)			return (NOTPRIME);

   h3= 0;
   s = 1;
   for (l = lp; l != _0; l = lred2 (l))
     {
     q = lfirst (l);
     p1q = iquot (p1,q);

     h1 = miexp (p,ww,p1q);
     if (h3 != 1)
       {
       h3 = miexp (p,h1,q);
       if (h3 != 1)			return (NOTPRIME);
       }

     h1 = idif (h1,1);
     h2 = igcd  (h1,p);
     if (h2 == 1)
       {
       q = iexp (q,lsecond (l));
       s = iprod (s,q);
       if (icomp (s,s4p) > 0)           return (ISAPRIME);
       }
     else if (icomp (h2,p) != 0)	return (NOTPRIME);
     }
   }
                                        return (UNKNOWN);
 }
