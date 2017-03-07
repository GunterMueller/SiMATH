/*M
.SH NAME
ecqnfpnp - elliptic curve over quadratic number field number modulo prime ideal

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecqnfpnp(E, P, pi, z)
list   E, P;
nfel pi;
single z;

.SH DESCRIPTION
ecqnfpnp() returns the number of points of an elliptic curve E over a quadratic
number field K = Q(D^(1/2)) modulo a prime ideal.
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod'). The prime ideal P divides a prime number not equal to 2.
.TP 4
.B pi
is a prime element of the prime ideal P.
.TP 4
.B z
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime
number in Q.
M*/
/*H
        Version 1       31.07.1998      S. Schmitt
   DATE ecqnfpnp     :980731
H*/


# include <_ec2.h>


int ecqnfpnp(E,P,pi,z)
list E,P;
nfel pi;
single z;
{
	int n;
	
	bind(E,P,pi);
	init(n);

	n = eqisnfpnp(E,P,pi,z);
	return(n);
}

	
