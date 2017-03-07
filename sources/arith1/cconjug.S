/*M
.SH NAME
cconjug - complex conjugation

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cconjug(v)
complex v;

.SH DESCRIPTION
cconjug() returns the complex conjugate z = re - i*im
of the complex number v = re + i*im where i^2 = -1.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cconjug       : 930531
H*/

#include <_arith1.h>

complex cconjug (a)
complex		 a;
 {
 floating  ai;
 bind(a); 
 init     (ai);

 ai = cimag (a);
 ai = flneg (ai);

 return (ccri (creal (a),ai));
 }
