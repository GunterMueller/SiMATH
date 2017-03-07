/*M
.SH NAME
isppecmpeq - is projective point of an elliptic curve over modular primes equal

.SH SYNOPSIS
.nf
#include<_ec1.h>

single isppecmpeq(p, P1, P2)
int p;
list P1, P2;

.SH DESCRIPTION
isppecmpeq returns 1, if P1 == P2
               and 0, if P1 != P2.
.TP 4
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B P1, P2                                                                       
are lists of 3 elements of Z/pZ, eg. P1, P2 are projective                      
Points.      

M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3	20.10.1994	Dokumentation korrigiert. MP
   DATE isppecmpeq    : 910715.910915.941201
H*/

#include <_ec1.h>

single isppecmpeq(p, P1, P2)
	int             p;
	list            P1, P2;
{
	single          n;

	bind(p, P1, P2);

	P1 = ecmpsrpp(p, P1);
	P2 = ecmpsrpp(p, P2);
	n = oequal(P1, P2);
	return (n);
}
