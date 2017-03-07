/*M
.SH NAME
csabsv - complex number, square of the absolute value

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating csabsv(z)
complex z;


.SH DESCRIPTION
csabsv() returns the square of the absolute value of the complex number z,
i.e.  |z|^2 = Re(z)^2 + Im(z)^2.
M*/

/*H
        Version 1       15.01.1994	Georg J. Lay
   DATE csabsv	      : 941201
H*/

#include <_arith1.h>

floating csabsv (z)
complex          z;
 {
 floating r,r1;
 bind(z); 
 init    (r,r1);

 r1 = flprod (creal (z),creal (z));
 r  = flprod (cimag (z),cimag (z));
 r  = flsum  (r,r1);

 return (r);
 }
