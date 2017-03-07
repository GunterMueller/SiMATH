/*M
.SH NAME
msprod - modular single product

.SH SYNOPSIS
.nf
#include<_arith1.h>

single msprod(m,a,b)
single m,a,b;

.SH DESCRIPTION
msprod() returns a * b for m > 0 and a,b from Z/mZ.
M*/
/*H
					
	Version 1       02.12.1986      B. Weis    
	Version 2	05.05.1992  	diverse Beschleunigungen.  MC
   DATE msprod        : 890501.8910__.921130
  
H*/

#include <_arith1.h>

single msprod(m, a, b)
	single m, a, b;
{

	if (m < 46341)
		return (a * b % m);
	else if (m < 65536)
		return ((single) ((unsigned) a * (unsigned) b % (unsigned) m));
	else {
		unsigned c, d;
		unsigned a0, a1, b0, b1, c2;
/*    Multiplizieren  (vgl. sprod) */
		a0 = ((unsigned) a % BSMALL);
		a1 = (unsigned) a >> 15;
		b0 = ((unsigned) b % BSMALL);
		b1 = (unsigned) b >> 15;
		c = a0 * b0;
		c2 = a1 * b1;
		d = (a0 + a1) * (b0 + b1) - (c + c2);
		a0 = d % BSMALL;
		a1 = d >> 15;

		d = ((a0 << 15) + c);
		c = (c2 + a1);         
/*   Reduzieren   (vgl. sqrem) */

		if ((a0 = (unsigned) m) < 1664717) {
			return ((single) ((c * (BASIS % a0) + (d % a0)) % a0));
		} else {
			d = d % a0;
			b0 = 30;
			while (b0--) {
				c <<= 1, d <<= 1;
				if (d >= BASIS) {
					d -= BASIS;
					c++;
				}
				if (c >= a0)
					c -= a0;
			}
			return ((single) c);
		}

	}
}
