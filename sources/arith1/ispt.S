/*M
.SH NAME
ispt - integer Selfridge primality test

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ispt(M,M1,F)
int M,M1;
list F;

.SH DESCRIPTION
ispt() returns 1 if M is a prime number,
0 if M is not prime and -1 if it could not
be determined whether or not M is prime,
provided that M >= 3, M1 = M - 1 and
F = ( Q1, ..., Qk ), with Q1 <= ... <= Qk,
is the list of prime factors of M1, i.e.
M1 = Q1 * ... * Qk.

.SH SEE ALSO
iftpt, isiprime.
M*/
/*H
	Version 1	27.2.1987  	Pascale Serf
	Version 2       5.3.1987        LIST_SP jetzt Array statt Liste
						Pascale Serf
	Version 3       04.5.1988      	lcopy() und F1 eliminiert.  RB
	Version 4	16.1.1993	ispt benutzt das schnellere 
					iftpt. GL
   DATE ispt          : 890501.9203__.930531
H*/


# include <_arith1.h>

single ispt(M,M1,F)
int M,M1;
list F;
 {
 if (M == 2)	return (1);

 switch (iftpt (M,F,1000))
   {
   case (-1):return ( 0);
   case ( 0):return (-1);
   case ( 1):return ( 1);
   }
 }

