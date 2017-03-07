/*M
.SH NAME
ipjacsym - integer prime Jacobi-symbol ( Legendre-symbol )

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ipjacsym(a,p)
int a,p;

.SH DESCRIPTION
ipjacsym() returns the value of the Jacobi-symbol (a|p)
if p is prime. If a is congruent to 0 modulo , then the
return code is 0.
If p is not prime, then the special return code -2 will appear.
This may be used for a simple randomised primality test
by calling ipjacsym() with several different values of a.
.PP
.TP 4
.B p
>=1, should be prime
M*/

/*H
	Version 1	16.09.1991	Georg Lay
   ipjacsym           : 920331
H*/

#include <_arith1.h>

 
int ipjacsym (a,p)
int           a,p;
 {
 int   erg,ex,p1;

 bind (a,p);
 init (erg,ex,p1);

 a = mihom (p,a);
 
 if (p == 2)
   erg = a;
 else
   {
   p1 = idif  (p ,1);
   ex = iquot (p1,2);
   erg = miexp (p,a,ex);			/* Fuer primes p != 2 ist 	*/
						/* (a|p) = a^(p-1)/2		*/
   if (icomp (erg,p1) == 0) erg = -1;
   if (icomp (erg, 1)  > 0) erg = -2;
   }

 return (erg);
 } 
