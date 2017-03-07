/*M
.SH NAME
cneg - complex number negation

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cneg(v)
complex v;


.SH DESCRIPTION
cneg() returns the negation z = -v of the complex number v.
M*/

/*H
        Version 1       22.12.1993      S.Schmitt/U.Schneiders
   DATE cneg	      : 941201
H*/

#include <_arith1.h>

complex cneg (a)
complex a;
 {
 floating cr,ci;
 init    (cr,ci);
 bind(a);

 cr = flneg (creal (a));
 ci = flneg (cimag (a));

 return (ccri (cr,ci));
 }
