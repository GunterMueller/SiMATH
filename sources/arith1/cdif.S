/*M
.SH NAME
cdif - complex difference

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cdif(v, w)
complex v, w;

.SH DESCRIPTION
cdif() returns the difference z = v - w of the two complex numbers v and w.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cdif          : 930531
H*/

#include <_arith1.h>

complex cdif (a,b)
complex       a,b;
 {
 floating cr,ci;
 bind(a,b); 
 init    (cr,ci);

 cr = fldif (creal (a), creal (b));
 ci = fldif (cimag (a), cimag (b));

 return (ccri (cr,ci));
 }
