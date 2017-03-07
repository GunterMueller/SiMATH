/*M
.SH NAME
cquot - complex quotient

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cquot(v, w)
complex v,w;

.SH DESCRIPTION
cquot() returns the quotient z = v / w of the complex numbers v and w.
M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cquot         : 930531
H*/

#include <_arith1.h>

complex cquot (a,b)
complex	       a,b;
 {
 floating ar,ai,br,bi;
 floating cr,ci,n,h;
 bind(a, b); 
 init    (cr,ci,n,h);

 if (b == 0)
   {
   printf (stderr,"\n *** cquot: division by zero ***\n");
   return (ERROR);
   }

 ar = creal (a);	br = creal (b);
 ai = cimag (a);	bi = cimag (b);

 n = flprod (br,br);
 h = flprod (bi,bi);
 n = flsum  (n,h);

 h  = flprod (ar,bi);
 ci = flprod (ai,br);
 ci = fldif  (ci,h);

 h  = flprod (ai,bi);
 cr = flprod (ar,br);
 cr = flsum  (cr,h);

 cr = flquot (cr,n);
 ci = flquot (ci,n);

 return (ccri (cr,ci));
 }
