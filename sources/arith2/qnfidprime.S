/*M
.SH NAME
qnfidprime - quadratic number field prime ideal, prime number

.SH SYNOPSIS
.nf
#include<_arith2.h>

int qnfidprime(P,pi,z)
list P;
nfel pi;
single z;

.SH DESCRIPTION
qnfidprime() returns the prime number which is divided by the prime ideal P.

.PP
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi 
is a prime element of the prime ideal P.
.TP 4
.B z
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime
number in Q.
M*/
/*H
	Version 1       31.07.1998      Susanne Schmitt
   DATE qnfidprime     : 980731
H*/


# include <_arith2.h>

int qnfidprime(P,pi,z)
list P;
nfel pi;
single z;
{
	int p;

	bind(P,pi);
	init(p);

	if(z) /** zerlegt oder verzweigt, P=(1 p*s x s) */
	{
		p = lsecond(P);
		p = isquot(p,lfourth(P));
	}
	else	/** traege: P = (p s x s) **/
	{
		p = lfirst(P);
	}
	return(p);
}
