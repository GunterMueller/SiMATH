/*M
.SH NAME
cabsv - complex absolute value
.SH SYNOPSIS
.nf

#include<_arith1.h>

floating cabsv(z) 
complex z;

.SH DESCRIPTION
Returns the absolute value |z| of the complex number z.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cabsv         : 930531
H*/

#include <_arith1.h>

floating cabsv (z)
complex	        z;
 {
 floating r,r1;
 bind(z); 
 init    (r,r1);

 r1 = flprod (creal (z),creal (z));
 r  = flprod (cimag (z),cimag (z));
 r  = flsum  (r,r1);
 r = flsqrt (r);

 return (r);
 }
