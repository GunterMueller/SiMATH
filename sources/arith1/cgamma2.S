/*M
.SH NAME
cgamma2 - complex gamma 2

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cgamma2(z)
complex z;

.SH DESCRIPTION
Provided that Im(z) > 0,
cgamma2() returns an approximation of the function gamma_2(z).
gamma_2 is the cube root of the module invariants j -> cmodinvj,
i.e. j = gamma_2^3
M*/

/*H
        Version 1       15.01.1994	Georg J. Lay
   DATE cgamma2       : 941201
H*/

#include <_arith1.h>

complex cgamma2 (z)
complex z;
 {
 complex  f2,g2;
 bind    (z);
 init    (f2,g2);

 f2 = cweberf2 (z);
 f2 = csexp (f2,8);

 g2 = csexp (f2,3);
 g2 = cisum  (g2,16);
 g2 = cquot (g2,f2);

 return (g2);
 }
