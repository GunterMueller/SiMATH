/*M
.SH NAME
csqrt - complex square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csqrt(z)
complex z;

.SH DESCRIPTION
csqrt() returns a square root r of the complex number z.
r satisfies Re (r) >= 0 and r^2 = z.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE csqrt         : 930531
H*/

#include <_arith1.h>

complex csqrt (z)
complex	       z;
 {
 floating b,rr,ri;
 bind(z); 
 init    (b,rr,ri);

 b = cabsv (z);

 rr = creal (z);

 ri = fldif (b,rr);
 rr = flsum (b,rr);

 ri = flsquot (ri,2);
 rr = flsquot (rr,2);

 ri = flsqrt (ri);
 rr = flsqrt (rr);

 b = cimag (z);

 if (flcomp (b,0) < 0)	ri = flneg (ri);

 return (ccri (rr,ri));
 }

