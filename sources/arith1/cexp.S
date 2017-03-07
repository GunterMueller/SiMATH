/*M
.SH NAME
cexp - complex exponential function

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cexp(z)
complex z;

.SH DESCRIPTION
cexp() returns e^z where e is the Euler number.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cexp          : 930531
H*/

#include <_arith1.h>

complex cexp (z)
complex	      z;
 {
 floating zr,zi,wb,wr,wi,pi2,r;
 bind(z); 
 init    (zr,zi,wb,wr,wi,pi2,r);

 zr = creal (z);
 zi = cimag (z);

 wb = flexp (zr);		/* wb = |w|		*/

 wr = flcos (zi);		/* wr = cos (zi)	*/
 wi = flprod (wr,wr);
 zr = itofl (1);
 wi = fldif (zr,wi);
 wi = flsqrt (wi);		/* wi = |sin (zi)|	*/

 pi2 = itofl (2);
 pi2 = flprod (pi2,flPi());

 flqrem (zi,pi2,&zr,&r);

 if (flcomp (r,flPi()) > 0)	wi = flneg (wi);

 wr = flprod (wb,wr);
 wi = flprod (wb,wi);

 return (ccri (wr,wi));
 }

