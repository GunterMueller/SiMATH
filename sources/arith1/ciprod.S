/*M
.SH NAME
ciprod - complex integer product

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex ciprod(v, i)
complex v;
int i;

.SH DESCRIPTION
ciprod() returns the product z = v * i of the complex number z and the integer i.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE ciprod        : 930531
H*/

#include <_arith1.h>

complex ciprod (a,i)
complex		a;
int               i;
 {
 complex  ic;
 bind(a,i); 
 init    (ic);

 ic = ccri (ic = itofl(i),0);

 return (cprod (a,ic));
 }

