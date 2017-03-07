/*M
.SH NAME
isppecmppai - is projective point of an elliptic curve over modular primes point at infinity

.SH SYNOPSIS
.nf
#include<_ec1.h>

single isppecmppai(p, P1)
int p;
list P1;

.SH DESCRIPTION
isppecmppai returns 1, if P = (x, y, 0),
                    0, else.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B P1                                                                           
is a list of 3 elements of Z/pZ, defining the projective                
Point P of the elliptic curve E.  

M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE isppecmppai   : 910715.910915
H*/

#include <_ec1.h>

single isppecmppai(p, P)
	int             p;
	list            P;
{
	int             z;

	bind(p, P);

	init(z);

	z = mihom(p, lthird(P));
	if (z == 0)
	{
		return (1);
	}
	else
	{
		return (0);
	}
}
