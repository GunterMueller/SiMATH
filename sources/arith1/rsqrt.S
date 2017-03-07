/*M
.SH NAME
rsqrt - rational number square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat isqrt(A)
rat A;

.SH DESCRIPTION
rsqrt() returns the square root of A for A >= 0. A must be a square in Q!!!
M*/
/*H
        Version  1      19.08.1998      S.Schmitt
   DATE rsqrt         : 980819
H*/

# include <_arith1.h>

rat rsqrt(r)
rat r;
{
	int n,z;
	rat w;

	init(n,z);
	init(w);
	bind(r);

	if(isrsqr(r)!=1) return(ERROR);
	if(!r) return(r);

	n = rden(r);
	z = rnum(r);	
	
	n = isqrt(n);
	z = isqrt(z);

	w = rcons(z,n);
	return(w);
}
