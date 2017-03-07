/*M
.SH NAME
cexpsv - complex exponential function special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cexpsv(z, n)
complex z;
int n;

.SH DESCRIPTION
cexpsv() returns e^(2*pi*i*z/n) where e is the Euler number.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cexpsv        : 930531
H*/

#include <_arith1.h>

complex cexpsv (z,n)
complex	      z;
int n;
 {
 complex  i2pi;
 bind    (z,n);
 init    (i2pi);

 i2pi = ccri (0,flPi());
 i2pi = csum (i2pi,i2pi);		/* 2*pi*i			*/

 z = ciquot (z,n);
 z = cprod  (z,i2pi);
 z = cexp (z);

 return (z);
 }

