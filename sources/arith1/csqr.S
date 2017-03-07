/*M
.SH NAME
csqr - complex square

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csqr(v)
complex v;

.SH DESCRIPTION
csqr() returns the square z = v * v of the complex number v.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE csqr          : 930531
H*/

#include <_arith1.h>

complex csqr (a)
complex	      a;
 {
 floating  ar,ai,cr,ci,h1,h2;
 bind(a); 
 init     (ar,ai,cr,ci,h1,h2);

 ar = creal (a);	ai = cimag (a);

 h1 = flsum (ar,ai);
 h2 = fldif (ar,ai);

 cr = flprod (h1,h2);
 ci = flprod (ar,ai);
 ci = flsum  (ci,ci);

 return (ccri (cr,ci));
 }
