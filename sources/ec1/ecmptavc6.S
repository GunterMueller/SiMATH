/*M
.SH NAME                                                                        
ecmptavc6 - elliptic curve over modular primes Tate's values c4, c6         
                                                                                
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_ec1.h>                                                                
                                                                                
list ecmptavc6(p, a1, a2, a3, a4, a6)                                           
int p, a1, a2, a3, a4, a6;                                                      
                                                                                
.SH DESCRIPTION                                                                 
.TP 4                                                                           
.B p                                                                            
is a prime number                                                               
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of the cubic curve E over Z/pZ, given 
in Weierstrass normal form.                                                     
.P                                                                              
ecmptavc6 computes the Tate's values c4, c6 of E, and returns them as a list of two elements.

.SH SEE ALSO
D. Husemoeller: Elliptic curves, p.68.

M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmptavc6     : 910715.910915
H*/

#include <_ec1.h>

list ecmptavc6(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             b2, b4, b6, c4, c6, h;
	list            L;

	bind(p, a1, a2, a3, a4, a6);

	init(b2, b4, b6, c4, c6, h);
	init(L);

	L = ecmptavb6(p, a1, a2, a3, a4, a6);
	b2 = lfirst(L);
	b4 = lsecond(L);
	b6 = lthird(L);

	/*
	 * Berechnung von c4 und c6
	 */

	h = 24;
	h = miprod(p, b4, h);
	c4 = miprod(p, b2, b2);
	c4 = midif(p, c4, h);
	h = 216;
	h = miprod(p, b6, h);
	c6 = 36;
	c6 = miprod(p, b2, c6);
	c6 = miprod(p, b4, c6);
	c6 = midif(p, c6, h);
	h = miprod(p, b2, b2);
	h = miprod(p, b2, h);
	c6 = midif(p, c6, h);

	return (list2(c4, c6));

}
