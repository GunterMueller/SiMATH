/*M
.SH NAME
irandprime - integer randomize prime

.SH SYNOPSIS
.nf
#include <_arith2.h>

int irandprime (a1, a2, n)
int a1, a2;
single n;

p = irandprime (a1, a2, n);

.SH DESCRIPTION
irandprime() generates a random (pseudo) prime p in the
range 0 < a1 <= p <= a2.
.TP 4
.B if n = 0
then p is an odd prime number.
.TP 4
.B if n > 0
then p is an odd integer that has passed n pseudo-primality tests.
The probability that p is composite is smaller than 4^(-n).
.PP
If a2 <= 10^13, then irandprime() returns a prime number, regardless
what value n has been set to.

irandprime() runs slower than iprimeconstr(), but the numbers generated
by irandprime() are of no special form.

The output of irandprime() depends on the value of the global
variable SEMIRAND. For a desciption of SEMIRAND, see irand().

.SH BUGS
If the interval [a1,a2] does not contain a prime number and n is set
to zero, then irandprime() does not stop. The same is likely to
happen if n > 0.  
M*/

/*H
	Version 1	03.12.1992	Georg Lay
	Version 2	23.03.1993	isispprime ist ausgebaut. GL
	Version 3	18.10.1993	while(0==0) -> while(llength(_0)==0). PS
   DATE irandprime    : 930115.930531.931130.961201
H*/

#include <_arith2.h>

int irandprime (a1,a2,mode)
int	        a1,a2,mode;
 {
 int   n,da;
 init (n,da);

 da = idif (a2,a1);

 do
   {
   n = irand (da);
   n = isum  (n,1 + iodd(n) - iodd (a1));
   n = isum  (n,a1);

   if (mode == 0) if (isiprime (n) == 1)	return (n);
   if (mode >  0) if (isispprime (n,mode) == 1)	return (n);
   }

 while (llength(_0) == 0);
 }
