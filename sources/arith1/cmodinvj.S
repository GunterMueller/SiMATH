/*M
.SH NAME
cmodinvj - complex modular invariant j

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cmodinvj(z) 
complex z;

.SH DESCRIPTION
Provided that Im(z) > 0,
cmodinvj() returns an approximation of the module invariant j.

.SH SEE ALSO
cmodinv
M*/

/*H
        Version 1       15.01.1993	Georg J. Lay
   DATE cmodinvj      : 941201
H*/

#include <_arith1.h>

complex cmodinvj (z)
complex z;
 {
 bind    (z);

 z = cgamma2 (z);
 z = csexp   (z,3);

 return (z); 
 }
