/*M
.SH NAME
csimag - complex number, set imaginary part

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csimag(z, Im)
complex z;
floating Im;

.SH DESCRIPTION
csimag() returns the complex number w = creal(z) + i*Im.
M*/

/*H
        Version 1       15.01.1994      Georg J. Lay
   DATE csimag        : 941201
H*/

#include <_arith1.h>

complex csimag (z,Im)
complex         z;
floating	  Im;
 {
 bind (z);

 z = creal (z);
 z = ccri  (z,Im);
 
 return (z);
 }
