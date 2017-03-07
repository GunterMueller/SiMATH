/*M
.SH NAME
ecmpsnffp - elliptic curve over modular primes, short normal form, find a point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsnffp (p, a4, a6)
int p, a4, a6;

.SH DESCRIPTION
ecmpsnffp computes a point P on the elliptic curve E.     P = (x, y, 1) is a list of three integers and represents the projective point (x:y:1). P is not the 
point at infinity, i.e. P != (0,1,0).                     
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                                       
are elements of Z/pZ, defining the elliptic curve E, represented in short Weierstrass normal form.
.TP 0
The output of ecmpsnffp depends on the global variable
.B SEMIRAND.
For a description of
.B SEMIRAND
, see irand.

.SH SEE ALSO
irand
M*/

/*H
	Version 1	03.04.1991	Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3	01.05.1996	Neue Doku	Georg Lay
   DATE ecmpsnffp     : 910715.910915.9203__.9612__
H*/


#include<_ec1.h>

list ecmpsnffp(p, a4, a6)
	int             p, a4, a6;
{
	single          i, j;
	int             x0, y0;
	list            P0;

	bind(p, a4, a6);

	init(x0, y0);
	init(P0);
	if (icomp(p, 5) >= 0)
	{
		for ( ; ; )
		{
			x0 = irand(p);
			y0 = miprod(p, x0, x0);
			y0 = misum(p, y0, a4);
			y0 = miprod(p, x0, y0);
			y0 = misum(p, y0, a6);
			if (mihom(p, y0) != 0)
			{
				if (ijacsym(y0, p) == 1)
				{
					break;
				}
			}
		}
		y0 = mpsqrt(p, y0);
		P0 = list3(x0, y0, 1);
		return (P0);
	}

	if ((p == 2) || (p == 3))
	{
		for (i = 0; i < p; i++)
		{
			for (j = 0; j < p; j++)
			{
				P0 = list3(i, j, 1);
				if (iselecmpsnf(p, a4, a6, P0))
				{
					return (P0);
				}
			}
		}
	}
}
