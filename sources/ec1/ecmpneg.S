/*M
.SH NAME
ecmpneg - elliptic curve over modular primes negative point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpneg(p, a1, a2, a3, a4, a6, P1)
int p, a1, a2, a3, a4, a6;
list P1(x, y, z);
int x, y, z;

.SH DESCRIPTION
ecmpsnfneg computes the negativ of the point P as projectiv point and returns it
as a list of 3 elements.                                               
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ, defining the elliptic curve E, represented in Weierstrass normal form.
.TP 4                                                                           
.B P1                                                                           
is a list of 3 elements of Z/pZ, defining the projective point P lying on E.          
                                                           
.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.58. 
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3	13.07.1992	Deklarationen korrigiert, p war nicht
					deklariert.  MP
   DATE ecmpneg       : 910715.910915.921130
H*/

#include <_ec1.h>

list            ecmpneg(p, a1, a2, a3, a4, a6, P)
    int             p, a1, a2, a3, a4, a6;
    list            P;
{
    int             x, y, z, h;

    bind(p, a1, a2, a3, a4, a6, P);

    init(x, y, z, h);

    x = mihom(p, lfirst(P));
    y = mihom(p, lsecond(P));
    z = mihom(p, lthird(P));

    /*
     * Berechnung des additiv inversen Punktes
     */

    if (z != 0)
    {
	x = miquot(p, x, z);
	y = miquot(p, y, z);
	z = 1;
	h = miprod(p, a1, x);
	y = misum(p, y, h);
	y = misum(p, y, a3);
	y = mineg(p, y);
    }
    else
    {
	x = 0;
	y = 1;
	z = 0;
    }
    return (list3(x, y, z));
}
