/*M
.SH NAME 
ecmpsrpp - elliptic curve over modular primes, standard representation of projective point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsrpp(p, P1)
int p;
list P1;

.SH DESCRIPTION
ecmpsrpp returns a representation Q = (x', y', z') of the projective point P = ( x, y, z), where 

	0 <= x' <= p-1,

	0 <= y' <= p-1,

	z' = 1;			for z != 0,

or 

	Q = ( 0, 1, 0 )	for z = 0.

.TP 4                                                                           
.B p                                                                            
is a prime  
.TP 4                                                                           
.B P1                                                                           
is a list of 3 elements of Z/pZ, defining the projective Point P of E 

M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsrpp      : 910715.910915
H*/

#include <_ec1.h>

list ecmpsrpp(p, P)
	int             p;
	list            P;
{
	int             x, y, z;

	bind(p, P);

	init(x, y, z);

	x = mihom(p, lfirst(P));
	y = mihom(p, lsecond(P));
	z = mihom(p, lthird(P));

	if (z != 0)
	{
		x = miquot(p, x, z);
		y = miquot(p, y, z);
		x = mihom(p, x);
		y = mihom(p, y);
		z = 1;
	}
	else
	{
		x = 0;
		y = 1;
		z = 0;
	}

	return (list3(x, y, z));
}
