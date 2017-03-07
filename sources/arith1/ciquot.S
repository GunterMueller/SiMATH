/*M
.SH NAME
ciquot - complex integer quotient

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex ciquot(v, i)
complex v;
int i;

.SH DESCRIPTION
ciquot() returns the quotient z = v / i of the complex number z and the integer i.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE ciquot        : 930531
H*/

#include <_arith1.h>

complex	ciquot (z,n)
complex z;
int n;
 {
 bind (z,n);

 n = itofl (n);
 n = ccri (n,0);
 n = cquot (z,n);

 return (n);
 }
