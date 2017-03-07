/*M
.SH NAME
cprod - complex product

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cprod(v, w)
complex v,w;

.SH DESCRIPTION
cprod() returns the product z = v * w of the complex numbers v and w.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cprod         : 930531
H*/

#include <_arith1.h>

complex cprod (a,b)
complex	       a,b;
 {
 floating ar,ai,br,bi;
 floating cr,ci,x1,x2,x3;
 bind(a,b); 
 init    (cr,ci,x1,x2,x3);

 ar = creal (a);	ai = cimag (a);
 br = creal (b);	bi = cimag (b);

 x1 = flprod (ar,br);		/* Idee von Karatsuba	*/
 x2 = flprod (ai,bi);
 x3 = flsum  (ar,ai);
 ci = flsum  (br,bi);
 x3 = flprod (x3,ci);

 cr = fldif  (x1,x2);
 ci = flsum  (x1,x2);
 ci = fldif  (x3,ci); 

 return (ccri (cr,ci));
 }
