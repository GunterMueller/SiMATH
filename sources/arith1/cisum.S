/*M
.SH NAME
cisum - complex number integer sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cisum(v, i)
complex v;
int i;

.SH DESCRIPTION
cisum() returns the sum z = v + i  of the complex number z and the integer i.
M*/

/*H
        Version 1       15.01.1994      Georg J. Lay
   DATE cisum         : 941201
H*/

#include <_arith1.h>

complex cisum (v,i)
complex	       v;
int		 i;
 {
 bind (i);

 i = itofl (i);
 i = ccri  (i,0);
 
 return (csum (v,i));
 }
