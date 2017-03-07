/*M
.SH NAME
ctoc - complex number to complex number 

.SH SYNOPSIS
.nf

complex ctoc(c)
complex	c;

.SH DESCRIPTION
ctoc() returns the complex number c, represented according to
the current value of FL_EPS.

.SH SEE ALSO
fltofl
M*/

/*H
        Version 1       02.03.1995      S. Schmitt
   DATE ctoc          : 951201
H*/

#include <_arith1.h>

complex ctoc (c)
complex	c;
 {
 floating cr,ci;
 bind(c); 
 init    (cr,ci);

 cr = fltofl(creal (c));
 ci = fltofl(cimag (c));

 return (ccri (cr,ci));
 }
