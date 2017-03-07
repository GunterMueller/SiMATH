/*M
.SH NAME
isipprime - is integer pseudo prime ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isipprime(n,a)
int n,a;

.SH DESCRIPTION
For n >0 and in Z/nZ
isipprime() returns 1 if n is pseudo prime
to base n, and 0 otherwise. If the result of
k calls to isipprime with different values
a1, ..., ak for a fixed value of n always
equals 1, then the probability of n not being
prime is less than 4^(-k).
M*/
/*H
	Version 1	08.12.1991	Georg Lay   
   DATE isipprime     : 920331.9305__
H*/

#include <_arith1.h>

                       
single isipprime (n,a)
int n,a;
 {
 single t,j;
 int   n0,n1,h;

 bind (n,a);
 init (n0,n1,h);

 n0 = n1 = idif (n,1);
 

 for (t = 0; iodd (n0) == 0; t++)			/* n = 1 + 2^t * n0	*/
   n0 = iquot (n0,2);

 if ((h = miexp (n,a,n0)) == 1)		return (ISAPPRIME);

 if (icomp (h,n1) == 0)			return (ISAPPRIME);

 for (j = 1; j < t; j++)
   {
   h = miprod (n,h,h);					/* h = a^(2^j * n0)	*/
  
   if (icomp (h,n1) == 0)		return (ISAPPRIME);
   }

 return (NOTPRIME);
 }

