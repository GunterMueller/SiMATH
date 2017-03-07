/*M
.SH NAME
isispprime - is integer strong pseudo prime ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isispprime(n,k)
int n;
single k;

.SH DESCRIPTION
For n >=1 and k >0
isispprime() returns 0 if n is not prime, and 1
in case n < 10^13 and n is prime. If n is greater
than 10^13 and the returned value equals 1, then the
probability of n not being prime is about 4^(-k).

.SH SEE ALSO
isiprime, issprime, isipprime
M*/
/*H
	Version 1	16.1.1993	Georg Lay
	Version 2	15.12.1993	ist nun korrekt fuer
					Eingaben < 10^13	GJL
   DATE isispprime    : 930531.941201
H*/

#include <_arith1.h>

                       
single isispprime (n,i0)
int n,i0;
 {
 int E13;

 bind (n);
 init (E13);

 if (n == 1)			return (NOTPRIME);

 if (n <= 50000000)		return (issprime (n,&DUM));	/* empirisch		*/

 if (iodd (n) == 0)		return (NOTPRIME);
 if (isipprime (n, 2) == 0)	return (NOTPRIME);
 if (isipprime (n, 3) == 0)	return (NOTPRIME);
 if (isipprime (n, 5) == 0)	return (NOTPRIME);
 if (isipprime (n, 7) == 0)	return (NOTPRIME);
 if (isipprime (n,61) == 0)	return (NOTPRIME);

 if (ilog10 (n) <= 13)		return (ISAPPRIME);

 for (i0 -= 5; i0 > 0; i0--)
   if (isipprime (n,irand (100000007)) == 0)	return (NOTPRIME);

 return (ISAPPRIME);
 }
