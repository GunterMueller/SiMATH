/*M
.SH NAME
csimag - complex number, set real part

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csreal(z, Re)
complex z;
floating Re;

.SH DESCRIPTION
csimag() returns the complex number w = Re + i*cimag(z).
M*/

/*H
        Version 1       15.01.1994      Georg J. Lay
   DATE csreal        : 941201
H*/

#include <_arith1.h>

complex csreal (z,Re)
complex         z;
floating	  Re;
 {
 bind (z);

 z = cimag (z);
 z = ccri  (Re,z);
 
 return (z);
 }
