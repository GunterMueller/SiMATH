/*M
.SH NAME
csum - complex number sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex csum(v, w)
complex v,w;

.SH DESCRIPTION
csum() returns the sum z = v + w  of the complex numbers v and w..
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE csum          : 930531
H*/

#include <_arith1.h>

complex csum (a,b)
complex	      a,b;
 {
 floating cr,ci;
 bind(a,b); 
 init    (cr,ci);

 cr = flsum (creal (a), creal (b));
 ci = flsum (cimag (a), cimag (b));

 return (ccri (cr,ci));
 }
